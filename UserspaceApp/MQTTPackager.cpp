/////////////////////////////////////////////////////////////
// Author: Patrick Wuerflinger
// Filename: MQTTPackager.cpp
// Description: Source file for the MQTT Packager class
// Revision: 0
/////////////////////////////////////////////////////////////

#include "MQTTPackager.h"

PublishDataVec_t MQTTPackager::visitSensor(std::shared_ptr<HDC1000> const & sensor)
{
	if (sensor != nullptr)
	{
		PublishDataVec_t package;
		auto temperature = std::to_string(sensor->getTemperature());
		auto humidity = std::to_string(sensor->getHumidity());	
		auto timestamp = std::to_string(sensor->getTimeStamp());
		// lineProtocol
		std::string lineString = "HDC1000 temperature=" + temperature + ",humidity=" + humidity + " " + timestamp;
		package.push_back({ MQTT_HDC1000_TOPIC, lineString});
		return package;
	}
	else
	{
		throw std::string{ "MQTTPackager:visitSensor: no nullptr allowed! " };
	}
}


PublishDataVec_t MQTTPackager::visitSensor(std::shared_ptr<APDS9301> const & sensor)
{
	if (sensor != nullptr)
	{
		PublishDataVec_t package;
		auto brightness = std::to_string(sensor->getBrightness());
		auto timestamp = std::to_string(sensor->getTimeStamp());
		// lineProtocol
		std::string lineString = "APDS9301 brightness=" + brightness + " " + timestamp;
		package.push_back({ MQTT_APDS9301_TOPIC, lineString });
		return package;
	}
	else
	{
		throw std::string{ "MQTTPackager:visitSensor: no nullptr allowed! " };
	}
}


PublishDataVec_t MQTTPackager::visitSensor(std::shared_ptr<MPU9250> const & sensor)
{
	if (sensor != nullptr)
	{

	}
	else
	{
		throw std::string{ "MQTTPackager:visitSensor: no nullptr allowed! " };
	}
}
