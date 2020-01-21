/////////////////////////////////////////////////////////////
// Author: Patrick Wuerflinger
// Filename: main.cpp
// Description: Entry point for the user application
// Revision: 0
/////////////////////////////////////////////////////////////

#include <iostream>
#include <vector>
#include <thread>
#include <chrono>
#include <mutex>
#include <string>
#include <libfpgaregion.h>
#include "Settings.h"
#include "MQTTPublisher.h"
#include "ConcurrentQueue.h"
#include "HDC1000.h"
#include "APDS9301.h"
#include "MPU9250.h"
#include "SevenSegDisplay.h"

// Callback functions for the FPGA region
void ReconfigRequest();
void ReconfigDone();
// Mutex for synchronization 
std::mutex fpgaMutex;
static FpgaRegion fpga("UserspaceApp", ReconfigRequest, ReconfigDone);

// Callback function for a reconfiguration request
void ReconfigRequest() 
{
	std::cout << "New incoming reconfigRequest." << std::endl;
	std::cout << "Wait to reconfigure savely." << std::endl;
	fpgaMutex.lock();
	std::cout << "FPGA ressources are free now." << std::endl;
	fpga.Release();
	std::cout << "Reconfiguration..." << std::endl;
}

// Callback function for the finished reconfiguration
void ReconfigDone() 
{
	std::cout << "Reconfiguration done" << std::endl;
	std::cout << "FPGA ressources are used again." << std::endl;
	fpga.Acquire();
	fpgaMutex.unlock();
}

class QueueDebugger
{
public:
	QueueDebugger(std::shared_ptr<ConcurrentQueue<PublishData_t>> const & queue)
	{
		mQueue = queue;
	}
	~QueueDebugger() = default;
	void start()
	{
		while (true)
		{
			std::cout << "Elements: " << mQueue->size() << std::endl;
			std::this_thread::sleep_for(std::chrono::milliseconds(20));
		}
	}
	std::shared_ptr<ConcurrentQueue<PublishData_t>> mQueue = nullptr;
};

int main()
{
	try
	{
		// create shared queue for multithreading
		auto queue = std::make_shared<ConcurrentQueue<PublishData_t>>();
				
		// create sensor objects
		auto publisher = std::make_shared<MQTTPublisher>(MQTT_SERVER_ADDRESS, THREAD_PUBLISHER_PAUSE_TIME, queue);	
		auto hdc1000 = std::make_shared<HDC1000>(MQTT_HDC1000_NAME, HDC1000_DRIVER_PATH, THREAD_HDC1000_PAUSE_TIME, queue);
		auto sevenseg = std::make_shared<SevenSegDisplay>(MQTT_SEVENSEGDIPLAY_NAME, SEVENSEGDISPLAY_DRIVER_PATH);
		auto apds9301 = std::make_shared<APDS9301>(MQTT_APDS9301_NAME, APDS9301_DRIVER_PATH, THREAD_APDS9301_PAUSE_TIME, queue, sevenseg);
		auto mpu9250 = std::make_shared<MPU9250>(MQTT_MPU9250_NAME, MPU9250_DRIVER_PATH, THREAD_MPU9250_PAUSE_TIME, queue);
		auto debugger = std::make_shared<QueueDebugger>(queue);
				
		// acquire fpga ressources & set some start values for the seven segment display
		fpga.Acquire();
		sevenseg->enable();
		sevenseg->setDigits({ 0, 1, 2, 3, 4, 5 });
		sevenseg->setBrightness(MAX_BRIGHTNESS);
				
		mpu9250->setThresholdValues({ -20.0, -20.0, -20.0 }, { 17.0, 25.0, 25.0 });
		mpu9250->setStreamingMode(true);
			
		// start sensor threads
		std::vector<std::thread> sensorThreads;
		sensorThreads.push_back(std::thread(&MQTTPublisher::start, publisher));
		sensorThreads.push_back(std::thread(&HDC1000::start, hdc1000, std::ref(fpgaMutex)));
		sensorThreads.push_back(std::thread(&APDS9301::start, apds9301, std::ref(fpgaMutex)));
		sensorThreads.push_back(std::thread(&MPU9250::start, mpu9250, std::ref(fpgaMutex))) ;
		sensorThreads.push_back(std::thread(&QueueDebugger::start, debugger));
				
		// wait till threads end
		for(auto & thread : sensorThreads)
		{
			thread.join();
		}		
	}
	catch(std::string const & error)
	{
		std::cerr << error << std::endl;
		return 1;
	}
	catch(std::bad_alloc const & error)
	{
		std::cerr << "Memory allocation: " << error.what() << std::endl;
		return 1; 
	}
	catch(...)
	{
		std::cerr << "Unhandled Exception" << std::endl;
		return 1; 
	}
	return 0;
}