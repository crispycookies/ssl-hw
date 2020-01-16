/////////////////////////////////////////////////////////////
// Author: Patrick Wuerflinger
// Filename: HDC1000.cpp
// Description: Source file for the HDC1000 sensor
// Revision: 0
/////////////////////////////////////////////////////////////

#include "HDC1000.h"
#include "Visitor.h"

const size_t RAW_VAL_LENGTH = 4;

float HDC1000::getTemperature() const
{
	return mTemperature;
}

float HDC1000::getHumidity() const
{
	return mHumidity;
}

void HDC1000::measure()
{
	std::string rawDataString = readDeviceDriver();
	if (!rawDataString.empty() && rawDataString.size() == RAW_VAL_LENGTH)
	{
		auto rawDataArray = reinterpret_cast<const uint8_t*>(&rawDataString[0]);
		
		// Temperature: 3st & 4th Byte
		uint16_t rawTemperature = ((((uint16_t)rawDataArray[3]) << 8) | (uint16_t)rawDataArray[2]);
		mTemperature = (((float)rawTemperature / (float)(1 << 16)) * 165) - 40;
		
		// Humidity: 1st & 2nd Byte
		uint16_t rawHumidity = ((((uint16_t)rawDataArray[1]) << 8) | (uint16_t)rawDataArray[0]);
		mHumidity = (((float)rawHumidity / (float)(1 << 16)) * 100);
	}
	else
	{
		throw std::string{ "HDC1000:measure: Device driver return invalid raw data! " };	
	}
}


PublishDataVec_t HDC1000::accept(std::shared_ptr<Visitor> const & visitor) 
{
	if (visitor != nullptr)
	{
		return visitor->visitSensor(shared_from_this());
	}
	else
	{
		throw std::string{ "HDC1000:accept: no nullptr allowed! " };
	}
}
