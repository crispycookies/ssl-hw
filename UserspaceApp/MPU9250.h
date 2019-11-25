/////////////////////////////////////////////////////////////
// Author: Patrick Wuerflinger
// Filename: MPU9250.h
// Description: Header file for the MPU9250 sensor
// Revision: 0
/////////////////////////////////////////////////////////////

#ifndef MPU9250_H
#define MPU9250_H

#include "Sensor.h"

class MPU9250 : public Sensor, public std::enable_shared_from_this<MPU9250>
{
public:
	MPU9250(std::string const & sensorName, std::string const & driverPath)
		: Sensor(sensorName, driverPath) {}
	
	virtual PublishDataVec_t accept(std::shared_ptr<Visitor> const & visitor) override;
	virtual void measure() override;	
	
private:
}
;

#endif