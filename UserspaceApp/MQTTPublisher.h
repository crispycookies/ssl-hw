/////////////////////////////////////////////////////////////
// Author: Patrick Wuerflinger
// Filename: MqttPublisher.h
// Description: Header file for the Publisher
// Revision: 0
/////////////////////////////////////////////////////////////

#ifndef MQTTPUBLISHER_H
#define MQTTPUBLISHER_H

#include <vector>
#include <memory>
#include "Sensor.h"
#include "Settings.h"
#include "mqtt/async_client.h"

class MQTTPublisher
{
public:
	MQTTPublisher(std::string const & serverAddress);
	void connect() const;
	void disconnect() const;	
	void addSensor(std::shared_ptr<Sensor> const & sensor);	
	void publish(QoS_t const & qos = QoS_AT_LEAST_ONCE) const;
private:
	std::string mServerAddress = "";
	std::shared_ptr<mqtt::async_client> mClient = nullptr;
	std::vector<std::shared_ptr<Sensor>> mSensors;	
}
;

#endif