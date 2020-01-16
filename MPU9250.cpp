/////////////////////////////////////////////////////////////
// Author: Patrick Wuerflinger
// Filename: MPU9250.cpp
// Description: Source file for the MPU9250 sensor
// Revision: 0
/////////////////////////////////////////////////////////////

#include "MPU9250.h"
#include "Visitor.h"
#include "MQTTPackager.h"
#include <chrono>
#include <sys/types.h>
#include <unistd.h>
#include <iostream>
#include <cmath>

using namespace std::chrono;

const size_t SIG_IRQ = 44;
const size_t RAW_VAL_LENGTH_DATA = 2*9;       // streaming mode
const size_t RAW_VAL_LENGTH_TOTAL = 2 * 3 * 1024 + RAW_VAL_LENGTH_DATA;  //event mode
const size_t RINGPUFFER_OFFSET = 18;
const size_t DATASET_OFFSET = 6;
const float ACC_DIVIDER = 16384.0;
const float G_SI = 9.80665;
const float PI = 3.13159;
const float GYRO_DIVIDER = 131.0;
const float MAGNETOMETER_SENSITIVITY_SCALE_FACTOR = 0.15;

////////////////////

const uint8_t DUMMY_BYTE = 0x00;
const uint8_t EVENT_MODE_BYTE = 0x01;
const uint8_t STREAMING_MODE_BYTE = 0x0;

MPU9250* MPU9250::ptrMe = nullptr;

PublishDataVec_t MPU9250::accept(std::shared_ptr<Visitor> const & visitor)
{
	if (visitor != nullptr)
	{
		return visitor->visitSensor(shared_from_this());
	}
	else
	{
		throw std::string{ "MPU9250:accept: no nullptr allowed! " };
	}
}

void MPU9250::measure()
{
	std::string rawDataString = readDeviceDriver();
	if (!rawDataString.empty())
	{
		auto rawDataArray = reinterpret_cast<const uint8_t*>(&rawDataString[0]);
		
		int16_t rawAccX = ((((int16_t)rawDataArray[1]) << 8) | (int16_t)rawDataArray[0]);
		mAccelerator.x = ((float)rawAccX * G_SI) / ACC_DIVIDER;
		int16_t rawAccY = ((((int16_t)rawDataArray[3]) << 8) | (int16_t)rawDataArray[2]);
		mAccelerator.y = ((float)rawAccY * G_SI) / ACC_DIVIDER;
		int16_t rawAccZ = ((((int16_t)rawDataArray[5]) << 8) | (int16_t)rawDataArray[4]);
		mAccelerator.z = ((float)rawAccZ * G_SI) / ACC_DIVIDER;
		
		int16_t rawGyroX = ((((int16_t)rawDataArray[7]) << 8) | (int16_t)rawDataArray[6]);
		mGyroscope.x = ((PI/180)*(float)rawGyroX)/GYRO_DIVIDER;
		int16_t rawGyroY = ((((int16_t)rawDataArray[9]) << 8) | (int16_t)rawDataArray[8]);
		mGyroscope.y = ((PI/180)*(float)rawGyroY) / GYRO_DIVIDER;
		int16_t rawGyroZ = ((((int16_t)rawDataArray[11]) << 8) | (int16_t)rawDataArray[10]);
		mGyroscope.z = ((PI/180)*(float)rawGyroZ) / GYRO_DIVIDER;
		
		int16_t rawMagX = ((((int16_t)rawDataArray[13]) << 8) | (int16_t)rawDataArray[12]);
		mMagnetometer.x = (float)rawMagX * MAGNETOMETER_SENSITIVITY_SCALE_FACTOR;
		int16_t rawMagY = ((((int16_t)rawDataArray[15]) << 8) | (int16_t)rawDataArray[14]);
		mMagnetometer.y = (float)rawMagY * MAGNETOMETER_SENSITIVITY_SCALE_FACTOR;
		int16_t rawMagZ = ((((int16_t)rawDataArray[17]) << 8) | (int16_t)rawDataArray[16]);
		mMagnetometer.z = (float)rawMagZ * MAGNETOMETER_SENSITIVITY_SCALE_FACTOR;
		//std::cout << rawMagX << " : " << rawMagY << " : " << rawMagZ << std::endl;
	}
	else
	{
		throw std::string{ "MPU9250:measure: Device driver return invalid raw data! " };	
	}
}

ThreeAxis_t MPU9250::getGyroscope() const
{
	return mGyroscope;
}


ThreeAxis_t MPU9250::getAccelerator() const
{
	return mAccelerator;
}


ThreeAxis_t MPU9250::getMagnetometer() const
{
	return mMagnetometer;
}


void MPU9250::measureIRQ(int n, siginfo_t *info, void * me)
{
	std::cout << "Function got called by IRQ" << SIG_IRQ << std::endl;	
	MPU9250::ptrMe->handleIRQ();
}

void MPU9250::handleIRQ()
{
	std::string rawDataString = readDeviceDriver();
	std::cout << "Size: " << rawDataString.size() << std::endl;
	
	if (!rawDataString.empty() && rawDataString.size() == RAW_VAL_LENGTH_TOTAL)
	{
		for (size_t i = RINGPUFFER_OFFSET; i < RAW_VAL_LENGTH_TOTAL; i += DATASET_OFFSET)
		{
			auto rawDataArray = reinterpret_cast<const uint8_t*>(&rawDataString[0]);
		
			int16_t rawAccX = ((((int16_t)rawDataArray[i+1]) << 8) | (int16_t)rawDataArray[i]);
			int16_t rawAccY = ((((int16_t)rawDataArray[i+3]) << 8) | (int16_t)rawDataArray[i+2]);
			int16_t rawAccZ = ((((int16_t)rawDataArray[i+5]) << 8) | (int16_t)rawDataArray[i+4]);			
			float acceleratorX = ((float)rawAccX * G_SI) / ACC_DIVIDER;
			float acceleratorY = ((float)rawAccY * G_SI) / ACC_DIVIDER;
			float acceleratorZ = ((float)rawAccZ * G_SI) / ACC_DIVIDER;			
			auto strAcceleratorX = std::to_string(acceleratorX);
			auto strAcceleratorY = std::to_string(acceleratorY);
			auto strAcceleratorZ = std::to_string(acceleratorZ);
			
			uint64_t timestamp = duration_cast<nanoseconds>(system_clock::now().time_since_epoch()).count();
			auto strTimestamp = std::to_string(timestamp);
			
			std::string lineProtocol = "MPU9250 acceleratorX=" + strAcceleratorX +
								",acceleratorY=" + strAcceleratorY +
								",acceleratorZ=" + strAcceleratorZ +
								" " + strTimestamp;
			
			std::cout << lineProtocol << std::endl;
			
			auto queue = getQueue();
			if (queue != nullptr)
			{
				queue->push({ MQTT_MPU9250_TOPIC, lineProtocol });	
			}
		}
	}
	else
	{
		throw std::string{ "MPU9250:handleIRQ: Device driver return invalid raw data! " };		
	}
}

void MPU9250::initIRQ()
{
	MPU9250::ptrMe = this;
	mPidNumber = getpid();
	struct sigaction sig;
	sig.sa_sigaction = measureIRQ;
	sig.sa_flags = SA_SIGINFO;
	sigaction(SIG_IRQ, &sig, NULL);
}


void MPU9250::setThresholdValues(ThreeAxis_t const & accLowerBound, ThreeAxis_t const & accUpperBound)
{
	mAccLowerBound = accLowerBound;
	mAccUpperBound = accUpperBound;	
}

std::string MPU9250::createConfigStr()
{
	std::string str;
	
	// create threshold values in the correct format
	float accXLowerBoundF = (mAccLowerBound.x * ACC_DIVIDER) / G_SI;
	float accYLowerBoundF = (mAccLowerBound.y * ACC_DIVIDER) / G_SI;
	float accZLowerBoundF = (mAccLowerBound.z * ACC_DIVIDER) / G_SI;
	
	int16_t accXLowerBound = static_cast<int16_t>(std::round(accXLowerBoundF));
	int16_t accYLowerBound = static_cast<int16_t>(std::round(accYLowerBoundF));
	int16_t accZLowerBound = static_cast<int16_t>(std::round(accZLowerBoundF));
	
	uint8_t accLowerX1 = (uint8_t)((accXLowerBound & 0xFF00) >> 8);
	uint8_t accLowerX2 = (uint8_t)(accXLowerBound & 0x00FF);
	
	uint8_t accLowerY1 = (uint8_t)((accYLowerBound & 0xFF00) >> 8);
	uint8_t accLowerY2 = (uint8_t)(accYLowerBound & 0x00FF);
	
	uint8_t accLowerZ1 = (uint8_t)((accZLowerBound & 0xFF00) >> 8);
	uint8_t accLowerZ2 = (uint8_t)(accZLowerBound & 0x00FF);
	
	float accXUpperBoundF = (mAccUpperBound.x * ACC_DIVIDER) / G_SI;
	float accYUpperBoundF = (mAccUpperBound.y * ACC_DIVIDER) / G_SI;
	float accZUpperBoundF = (mAccUpperBound.z * ACC_DIVIDER) / G_SI;
	
	int16_t accXUpperBound = static_cast<int16_t>(std::round(accXUpperBoundF));
	int16_t accYUpperBound = static_cast<int16_t>(std::round(accYUpperBoundF));
	int16_t accZUpperBound = static_cast<int16_t>(std::round(accZUpperBoundF));
	
	uint8_t accUpperX1 = (uint8_t)((accXUpperBound & 0xFF00) >> 8);
	uint8_t accUpperX2 = (uint8_t)(accXUpperBound & 0x00FF);
			   
	uint8_t accUpperY1 = (uint8_t)((accYUpperBound & 0xFF00) >> 8);
	uint8_t accUpperY2 = (uint8_t)(accYUpperBound & 0x00FF);
			   
	uint8_t accUpperZ1 = (uint8_t)((accZUpperBound & 0xFF00) >> 8);
	uint8_t accUpperZ2 = (uint8_t)(accZUpperBound & 0x00FF);
	
	uint8_t mode;
	if (mEventMode)
	{
		mode = EVENT_MODE_BYTE;
	}
	else
	{
		mode = STREAMING_MODE_BYTE;
	}
	
	str += DUMMY_BYTE;
	str += mode;
	str += accUpperX1;
	str += accUpperX2;
	str += accLowerX1;
	str += accLowerX2;	
	str += accUpperY1;
	str += accUpperY2;
	str += accLowerY1;
	str += accLowerY2;	
	str += accUpperZ1;
	str += accUpperZ2;
	str += accLowerZ1;
	str += accLowerZ2;
	
	// PID
	str += (uint8_t)((mPidNumber >> 24) & 0xFF);
	str += (uint8_t)((mPidNumber >> 16) & 0xFF);
	str += (uint8_t)((mPidNumber >> 8) & 0xFF);
	str += (uint8_t)(mPidNumber & 0xFF);
	return str;
}


void MPU9250::setStreamingMode(bool const & eventmode)
{
	mEventMode = eventmode;
	writeDeviceDriver(createConfigStr());
}
