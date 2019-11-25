/////////////////////////////////////////////////////////////
// Author: Patrick Wuerflinger
// Filename: MPU9250.cpp
// Description: Source file for the MPU9250 sensor
// Revision: 0
/////////////////////////////////////////////////////////////

#include "MPU9250.h"
#include "Visitor.h"

PublishDataVec_t MPU9250::accept(std::shared_ptr<Visitor> const & visitor)
{
	if (visitor != nullptr)
	{
		return visitor->visitSensor(shared_from_this());
	}
	else
	{
		throw std::string{ "MPU9250:accept: no nullptr allowed! " };
	}
}

void MPU9250::measure()
{
}
