/////////////////////////////////////////////////////////////
// Author: Patrick Wuerflinger
// Filename: Actuator.cpp
// Description: Source file for the the actuator base class
// Revision: 0
/////////////////////////////////////////////////////////////

#include "Actuator.h"
#include <fstream>

Actuator::Actuator(std::string const & name, std::string const & driverPath)
{
	if (name.empty() || driverPath.empty())
	{
		throw std::string{ "Actuator:CTOR: invalid name or driverpath! " };
	}
	
	mName = name;
	mDriverPath = driverPath;
}

std::string Actuator::getName() const
{
	return mName;
}

std::string Actuator::getDriverPath() const
{
	return mDriverPath;
}


void Actuator::writeDeviceDriver(std::string const & str) const
{
	std::ofstream driverFile(mDriverPath);
	driverFile.open(mDriverPath);
	
	if (!driverFile.good()) 
	{
		throw std::string{ "Actuator:writeDeviceDriver: opening driver file failed: " + mDriverPath };
	}
	
	driverFile << str;
	driverFile.close();
}
