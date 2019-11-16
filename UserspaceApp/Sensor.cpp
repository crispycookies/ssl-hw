/////////////////////////////////////////////////////////////
// Author: Patrick Wuerflinger
// Filename: Sensor.cpp
// Description: Source file for the base class of all sensors
// Revision: 0
/////////////////////////////////////////////////////////////

#include "Sensor.h"
#include <fstream>
#include <sstream> 

Sensor::Sensor(std::string const & name, std::string const & driverPath)
{
	if (name.empty() || driverPath.empty())
	{
		throw std::string{"Sensor:CTOR: invalid name or driverpath! "};
	}
	
	mName = name;
	mDriverPath = driverPath;
}

std::string Sensor::getName()
{
	return mName;
}

std::string Sensor::getDriverPath()
{
	return mDriverPath;
}

std::string Sensor::readDeviceDriver()
{
	std::ifstream driverFile;
	std::stringstream strStream;
	
	driverFile.open(mDriverPath);
	if (!driverFile) 
	{
		throw std::string{ "Sensor:readDeviceDriver: opening driver file failed: " + mDriverPath };
	}
	
	// read the file and return string
	strStream << driverFile.rdbuf();    
	std::string content = strStream.str();  	
	driverFile.close();
	return content;
}
