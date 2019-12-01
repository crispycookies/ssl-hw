/////////////////////////////////////////////////////////////
// Author: Patrick Wuerflinger
// Filename: HDC1000.h
// Description: Header file for the HDC100 sensor
// Revision: 0
/////////////////////////////////////////////////////////////

#ifndef HDC1000_H
#define HDC1000_H

#include "Sensor.h"

class HDC1000 : public Sensor, public std::enable_shared_from_this<HDC1000>
{
public:
	HDC1000(std::string const & sensorName, std::string const & driverPath, size_t const & pauseMs, std::shared_ptr<ConcurrentQueue<PublishData_t>> const & queue)
		: Sensor(sensorName, driverPath, pauseMs, queue) {}
	
	virtual PublishDataVec_t accept(std::shared_ptr<Visitor> const & visitor) override;
	virtual void measure() override;	
	double getTemperature() const;
	double getHumidity() const;
private:
	double mTemperature = 0.0;  
	double  mHumidity = 0.0;   
};

#endif