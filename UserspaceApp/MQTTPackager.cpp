/////////////////////////////////////////////////////////////
// Author: Patrick Wuerflinger
// Filename: MQTTPackager.cpp
// Description: Source file for the MQTT Packager class
// Revision: 0
/////////////////////////////////////////////////////////////

#include "MQTTPackager.h"

PublishDataVec_t MQTTPackager::visitSensor(std::shared_ptr<HDC1000> const & sensor)
{
	PublishDataVec_t package;
	auto temperature = std::to_string(sensor->getTemperature());
	auto humidity = std::to_string(sensor->getHumidity());
	// TODO: Get time stamp ...
	
	package.push_back({ MQTT_HDC1000_TEMPERATURE_TOPIC, temperature, "123456789" });
	package.push_back({ MQTT_HDC1000_HUMIDITY_TOPIC, humidity, "123456789" });
	return package;
}
