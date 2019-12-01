/////////////////////////////////////////////////////////////
// Author: Patrick Wuerflinger
// Filename: MqttPublisher.h
// Description: Header file for the Publisher
// Revision: 0
/////////////////////////////////////////////////////////////

#ifndef MQTTPUBLISHER_H
#define MQTTPUBLISHER_H

#include <vector>
#include <string>
#include <memory>
#include "Sensor.h"
#include "Settings.h"
#include "ConcurrentQueue.h"
#include "mqtt/async_client.h"

class MQTTPublisher
{
public:
	MQTTPublisher(std::string const & serverAddress, size_t const & pauseMs, std::shared_ptr<ConcurrentQueue<PublishData_t>> const & queue);	
	void start() const;
private:
	void connect() const;
	void disconnect() const;	
	size_t mPauseMs;
	std::string mServerAddress = "";
	std::shared_ptr<mqtt::async_client> mClient = nullptr;
	std::shared_ptr<ConcurrentQueue<PublishData_t>> mQueue = nullptr;
}
;

#endif