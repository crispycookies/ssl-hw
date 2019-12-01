/////////////////////////////////////////////////////////////
// Author: Patrick Wuerflinger
// Filename: APDS9301.h
// Description: Header file for the APDS9301 sensor
// Revision: 0
/////////////////////////////////////////////////////////////

#ifndef APDS9301_H
#define APDS9301_H

#include "Sensor.h"

class APDS9301 : public Sensor, public std::enable_shared_from_this<APDS9301>
{
public:
	APDS9301(std::string const & sensorName, std::string const & driverPath, size_t const & pauseMs, std::shared_ptr<ConcurrentQueue<PublishData_t>> const & queue)
		: Sensor(sensorName, driverPath, pauseMs, queue) {}
	
	virtual PublishDataVec_t accept(std::shared_ptr<Visitor> const & visitor) override;
	virtual void measure() override;	
	double getBrightness() const;
private:
	double mBrightness = 0.0;    
}
;

#endif