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


PublishDataVec_t MQTTPackager::visitSensor(std::shared_ptr<APDS9301> const & sensor)
{
	PublishDataVec_t package;
	auto brightness = std::to_string(sensor->getBrightness());
	
	package.push_back({ MQTT_APDS9301_BRIGHTNESS_TOPIC, brightness });
	return package;
}


PublishDataVec_t MQTTPackager::visitSensor(std::shared_ptr<MPU9250> const & sensor)
{
	PublishDataVec_t package;
	return package;
}
