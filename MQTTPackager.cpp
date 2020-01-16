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
		std::string lineProtocol = "HDC1000 temperature=" + temperature + ",humidity=" + humidity + " " + timestamp;
		package.push_back({ MQTT_HDC1000_TOPIC, lineProtocol });
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
		std::string lineProtocol = "APDS9301 brightness=" + brightness + " " + timestamp;
		package.push_back({ MQTT_APDS9301_TOPIC, lineProtocol });
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
		PublishDataVec_t package;
		auto gyroscopeX = std::to_string(sensor->getGyroscope().x);
		auto gyroscopeY = std::to_string(sensor->getGyroscope().y);
		auto gyroscopeZ = std::to_string(sensor->getGyroscope().z);
		
		auto acceleratorX = std::to_string(sensor->getAccelerator().x);
		auto acceleratorY = std::to_string(sensor->getAccelerator().y);
		auto acceleratorZ = std::to_string(sensor->getAccelerator().z);
		
		auto magnetometerX = std::to_string(sensor->getMagnetometer().x);
		auto magnetometerY = std::to_string(sensor->getMagnetometer().y);
		auto magnetometerZ = std::to_string(sensor->getMagnetometer().z);
		
		auto timestamp = std::to_string(sensor->getTimeStamp());
		
		// lineProtocol
		std::string lineProtocol = "MPU9250 gyroscopeX=" + gyroscopeX + 
									",gyroscopeY=" + gyroscopeY +
									",gyroscopeZ=" + gyroscopeZ +
									",acceleratorX=" + acceleratorX +
									",acceleratorY=" + acceleratorY +
									",acceleratorZ=" + acceleratorZ +
									",magnetometerX=" + magnetometerX +
									",magnetometerY=" + magnetometerY +
									",magnetometerZ=" + magnetometerZ +
									" " + timestamp;
		
		package.push_back({ MQTT_MPU9250_TOPIC, lineProtocol });
		return package;
	}
	else
	{
		throw std::string{ "MQTTPackager:visitSensor: no nullptr allowed! " };
	}
}
