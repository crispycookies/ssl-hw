/////////////////////////////////////////////////////////////
// Author: Patrick Wuerflinger
// Filename: HDC1000.cpp
// Description: Source file for the HDC100 sensor
// Revision: 0
/////////////////////////////////////////////////////////////

#include "HDC1000.h"
#include "Visitor.h"

// for testing only
#include <random>

double HDC1000::getTemperature() const
{
	return mTemperature;
}

int HDC1000::getHumidity() const
{
	return mHumidity;
}

void HDC1000::measure()
{
	std::random_device dev;
	std::mt19937 rng(dev());
	std::uniform_int_distribution<std::mt19937::result_type> dist6(1, 100);  

	mTemperature = dist6(rng);
	mHumidity = dist6(rng);
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
