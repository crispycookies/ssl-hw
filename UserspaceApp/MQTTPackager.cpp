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
	
	package.push_back({ MQTT_HDC1000_TEMPERATURE_TOPIC, temperature});
	package.push_back({ MQTT_HDC1000_HUMIDITY_TOPIC, humidity});
	return package;
}
