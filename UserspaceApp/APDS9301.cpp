/////////////////////////////////////////////////////////////
// Author: Patrick Wuerflinger
// Filename: APDS9301.cpp
// Description: Source file for the APDS9301 sensor
// Revision: 0
/////////////////////////////////////////////////////////////

#include "APDS9301.h"
#include "Visitor.h"

void APDS9301::measure()
{
	//std::string rawDataString = readDeviceDriver();
	//if (!rawDataString.empty() && rawDataString.size() == RAW_VAL_LENGTH)
	mBrightness = 123;
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

size_t APDS9301::getBrightness() const
{
	return mBrightness;
}
