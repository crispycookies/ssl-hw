/////////////////////////////////////////////////////////////
// Author: Patrick Wuerflinger
// Filename: Sensor.h
// Description: Header file for the base class of all sensors
// Revision: 0
/////////////////////////////////////////////////////////////

#ifndef SENSOR_H
#define SENSOR_H

#include <memory>
#include <string>
#include "ConcurrentQueue.h"
#include "Settings.h"

class Visitor;

class Sensor
{
public:
	Sensor(std::string const & name, std::string const & driverPath, size_t const & pauseMs, std::shared_ptr<ConcurrentQueue<PublishData_t>> const & queue);
	virtual ~Sensor() = default;
	void start(std::mutex & m);
	std::string getName() const;
	std::string getDriverPath() const;
	uint64_t getTimeStamp() const;
	std::shared_ptr<ConcurrentQueue<PublishData_t>> getQueue() const;
protected:
	std::string readDeviceDriver() const;	
	void writeDeviceDriver(std::string const & str) const;
	virtual PublishDataVec_t accept(std::shared_ptr<Visitor> const & visitor) = 0;
	virtual void measure() = 0;
	void createTimeStamp();
private:
	size_t mPauseMs;
	std::string mName = "";
	std::string mDriverPath = "";	
	uint64_t mTimeStamp = 0;
	std::shared_ptr<ConcurrentQueue<PublishData_t>> mQueue = nullptr;
}
;

#endif

