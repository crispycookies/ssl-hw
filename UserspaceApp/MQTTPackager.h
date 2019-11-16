/////////////////////////////////////////////////////////////
// Author: Patrick Wuerflinger
// Filename: MQTTPackager.h
// Description: Header file for the MQTT Packager class
// Revision: 0
/////////////////////////////////////////////////////////////

#ifndef MQTTPACKAGER_H
#define MQTTPACKAGER_H

#include "Visitor.h"
#include "HDC1000.h"
#include <iostream>

class MQTTPackager : public Visitor
{
public:
	virtual PublishDataVec_t visitSensor(std::shared_ptr<HDC1000> const & sensor) override;
};

#endif