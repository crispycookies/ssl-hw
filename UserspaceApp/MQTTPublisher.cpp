/////////////////////////////////////////////////////////////
// Author: Patrick Wuerflinger
// Filename: MqttPublisher.cpp
// Description: Source file for the Publisher
// Revision: 0
/////////////////////////////////////////////////////////////

#include "MQTTPublisher.h"
#include "MQTTPackager.h"

const std::string payload2 = "hello";

MQTTPublisher::MQTTPublisher(std::string const & serverAddress)
{
	if (serverAddress.empty())
	{
		throw std::string{ "Publisher:CTOR: invalid server address! " };
	}
	
	mServerAddress = serverAddress;	
	mClient = std::make_shared<mqtt::async_client>(mServerAddress, "");
}


void MQTTPublisher::addSensor(std::shared_ptr<Sensor> const & sensor)
{
	if (sensor != nullptr)
	{
		mSensors.push_back(sensor);
	}
	else
	{
		throw std::string{ "Publisher:addSensor: nullpointer argument passed! " };
	}
}


void MQTTPublisher::connect() const
{
	mClient->connect()->wait();
}


void MQTTPublisher::disconnect() const
{
	mClient->disconnect()->wait();
}

void MQTTPublisher::publish(QoS_t const & qos) const
{
	auto mqttPackager = std::make_shared<MQTTPackager>();
	
	for (auto & sensor : mSensors)
	{
		// perform measurement
		sensor->measure();
		PublishDataVec_t package = sensor->accept(mqttPackager);

		for(size_t i = 0 ; i < package.size() ; i++)
		{			
			mqtt::topic topic(*mClient, package[i].topic, qos);
			// publish sensor value
			mqtt::token_ptr token = topic.publish(package[i].sensorVal.c_str(), package[i].sensorVal.size());
			token->wait();  		
			// publish timestamp 
			token = topic.publish(package[i].timestamp.c_str(), package[i].timestamp.size());
			token->wait();  	
		}
	}
}

