/////////////////////////////////////////////////////////////
// Author: Patrick Wuerflinger
// Filename: APDS9301.h
// Description: Header file for the APDS9301 sensor
// Revision: 0
/////////////////////////////////////////////////////////////

#ifndef APDS9301_H
#define APDS9301_H

#include "Sensor.h"
#include "SevenSegDisplay.h"

class APDS9301 : public Sensor, public std::enable_shared_from_this<APDS9301>
{
public:
	APDS9301(std::string const & sensorName, std::string const & driverPath, size_t const & pauseMs, std::shared_ptr<ConcurrentQueue<PublishData_t>> const & queue, std::shared_ptr<SevenSegDisplay> const & sevenSeg)
		: Sensor(sensorName, driverPath, pauseMs, queue) 
	{
		if (sevenSeg != nullptr)
		{
			mSevenSeg = sevenSeg;
		}
		else
		{
			throw std::string{ "APDS9301:APDS9301: nullptr in CTOR"};
		}
	}
	uint32_t  getBrightness() const;
protected:
	virtual PublishDataVec_t accept(std::shared_ptr<Visitor> const & visitor) override;
	virtual void measure() override;	
private:
	uint32_t mBrightness = 0;    
	std::shared_ptr<SevenSegDisplay> mSevenSeg = nullptr;
	uint8_t calcBrightnessForSevenSeg() const; 
}
;

#endif