/////////////////////////////////////////////////////////////
// Author: Patrick Wuerflinger
// Filename: MqttPublisher.cpp
// Description: Source file for the Publisher
// Revision: 0
/////////////////////////////////////////////////////////////

#include "MQTTPublisher.h"

const size_t MAX_ELEMENTS_QUEUE = 100;

MQTTPublisher::MQTTPublisher(std::string const & serverAddress, size_t const & pauseMs, std::shared_ptr<ConcurrentQueue<PublishData_t>> const & queue)
{
	if (serverAddress.empty() || queue == nullptr)
	{
		throw std::string{ "MQTTPublisher:MQTTPublisher: nullpointer argument passed or empty server address! " };
	}
	mServerAddress = serverAddress;
	mQueue = queue;
	mPauseMs = pauseMs;
	mClient = std::make_shared <mqtt::async_client>(mServerAddress, "");
}

void MQTTPublisher::connect() const
{
	mClient->connect()->wait();
}


void MQTTPublisher::disconnect() const
{
	mClient->disconnect()->wait();
}

void MQTTPublisher::start() const
{
	while (true)
	{
		if (mQueue->size() > MAX_ELEMENTS_QUEUE)
		{
			connect();
			size_t counter = MAX_ELEMENTS_QUEUE;
			while (counter != 0)
			{
				auto package = mQueue->pop();		
				mqtt::token_ptr token = mClient->publish(package.first, package.second.c_str(), package.second.size(), QoS_AT_LEAST_ONCE, true);
				token->wait();  
				counter--;
			}
			disconnect();
		}
		std::this_thread::sleep_for(std::chrono::milliseconds(mPauseMs));
	}
}
