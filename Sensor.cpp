/////////////////////////////////////////////////////////////
// Author: Patrick Wuerflinger
// Filename: Sensor.cpp
// Description: Source file for the base class of all sensors
// Revision: 0
/////////////////////////////////////////////////////////////

#include "Sensor.h"
#include "MQTTPackager.h"
#include <fstream>
#include <sstream>  
#include <thread>
#include <chrono>

using namespace std::chrono;

Sensor::Sensor(std::string const & name, std::string const & driverPath, size_t const & pauseMs, std::shared_ptr<ConcurrentQueue<PublishData_t>> const & queue)
{
	if (name.empty() || driverPath.empty() || queue == nullptr)
	{
		throw std::string{"Sensor:CTOR: invalid name or driverpath or nullptr! "};
	}
	
	mName = name;
	mDriverPath = driverPath;
	mPauseMs = pauseMs;
	mQueue = queue;
}

std::string Sensor::getName() const
{
	return mName;
}

std::string Sensor::getDriverPath() const
{
	return mDriverPath;
}

std::string Sensor::readDeviceDriver() const
{
	std::ifstream driverFile;
	std::stringstream strStream;
	
	driverFile.open(mDriverPath);
	if (!driverFile.good()) 
	{
		throw std::string{ "Sensor:readDeviceDriver: opening driver file failed: " + mDriverPath };
	}
	
	// read the file and return string
	strStream << driverFile.rdbuf();    
	std::string content = strStream.str();  	
	driverFile.close();
	return content;
}

void Sensor::start(std::mutex & m)
{
	auto mqttPackager = std::make_shared<MQTTPackager>();
	
	while (true)
	{
		// perform measurement & lock fpga resources
		m.lock();
		measure();
		m.unlock();
		// create timestamp
		createTimeStamp();
		// add mqtt packages to queue
		auto packages = accept(mqttPackager);
		for (auto & package : packages)
		{			
			mQueue->push(package);
		}
		std::this_thread::sleep_for(std::chrono::milliseconds(mPauseMs));
	}
}


uint64_t Sensor::getTimeStamp() const
{
	return mTimeStamp;
}


void Sensor::createTimeStamp()
{
	mTimeStamp = duration_cast<nanoseconds>(system_clock::now().time_since_epoch()).count();
}


void Sensor::writeDeviceDriver(std::string const & str) const
{
	std::ofstream driverFile;
	driverFile.open(mDriverPath);
	
	if (!driverFile.good()) 
	{
		throw std::string{ "Sensor:writeDeviceDriver: opening driver file failed: " + mDriverPath };
	}
	driverFile << str;
	driverFile.close();
}

std::shared_ptr<ConcurrentQueue<PublishData_t>> Sensor::getQueue() const
{
	return mQueue;	
}
