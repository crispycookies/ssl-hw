/////////////////////////////////////////////////////////////
// Author: Patrick Wuerflinger
// Filename: APDS9301.cpp
// Description: Source file for the APDS9301 sensor
// Revision: 0
/////////////////////////////////////////////////////////////

#include "APDS9301.h"
#include "Visitor.h"
#include <math.h> 

const size_t RAW_VAL_LENGTH = 4;

void APDS9301::measure()
{
	std::string rawDataString = readDeviceDriver();
	if (!rawDataString.empty() && rawDataString.size() == RAW_VAL_LENGTH)
	{
		// read both 16 bit channel registers and perform calculation according to datasheet (page 4/20)		
		auto rawDataArray = reinterpret_cast<const uint8_t*>(&rawDataString[0]);	
		uint16_t rawCH0 = ((((uint16_t)rawDataArray[0]) << 8) | (uint16_t)rawDataArray[1]);	
		uint16_t rawCH1 = ((((uint16_t)rawDataArray[3]) << 8) | (uint16_t)rawDataArray[2]);
		double channelRatio = (double)rawCH1 / (double)rawCH0;
		
		if (channelRatio > 0 && channelRatio <= 0.5)
			mBrightness = (0.0304 * rawCH0) - (0.062 * rawCH0 * pow(channelRatio, 1.4));
		else if (channelRatio > 0.5 && channelRatio <= 0.61)
			mBrightness = (0.0224 * rawCH0) - (0.031 * rawCH1);
		else if (channelRatio > 0.61 && channelRatio <= 0.8)
			mBrightness = (0.0128 * rawCH0) - (0.0153 * rawCH1);
		else if (channelRatio > 0.8 && channelRatio <= 1.3)
			mBrightness = (0.00146 * rawCH0) - (0.00112 * rawCH1);
		else
			mBrightness = 0;			
	}
	else
	{
		throw std::string{ "APDS9301:measure: Device driver return invalid raw data! " };	
	}
}

PublishDataVec_t APDS9301::accept(std::shared_ptr<Visitor> const & visitor)
{
	if (visitor != nullptr)
	{
		return visitor->visitSensor(shared_from_this());
	}
	else
	{
		throw std::string{ "APDS9301:accept: no nullptr allowed! " };
	}
}

double APDS9301::getBrightness() const
{
	return mBrightness;
}
