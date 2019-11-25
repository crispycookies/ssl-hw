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
	APDS9301(std::string const & sensorName, std::string const & driverPath)
		: Sensor(sensorName, driverPath) {}
	
	virtual PublishDataVec_t accept(std::shared_ptr<Visitor> const & visitor) override;
	virtual void measure() override;	
	size_t getBrightness() const;
private:
	size_t mBrightness = 0;    
}
;

#endif