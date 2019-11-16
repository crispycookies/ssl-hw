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
#include "SensorSettings.h"

class Visitor;

class Sensor
{
public:
	Sensor(std::string const & name, std::string const & driverPath);
	virtual ~Sensor() = default;
	virtual PublishDataVec_t accept(std::shared_ptr<Visitor> const & visitor) = 0;
	virtual void measure() = 0;
	std::string getName();
	std::string getDriverPath();
private:
	std::string mName = "";
	std::string mDriverPath = "";
	std::string readDeviceDriver();
}
;

#endif

