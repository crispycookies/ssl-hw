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
#include "APDS9301.h"
#include "MPU9250.h"

class MQTTPackager : public Visitor
{
public:
	virtual PublishDataVec_t visitSensor(std::shared_ptr<HDC1000> const & sensor) override;
	virtual PublishDataVec_t visitSensor(std::shared_ptr<APDS9301> const & sensor) override;
	virtual PublishDataVec_t visitSensor(std::shared_ptr<MPU9250> const & sensor) override;
};

#endif