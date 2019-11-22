/////////////////////////////////////////////////////////////
// Author: Patrick Wuerflinger
// Filename: SensorSettings.h
// Description: Header file for the sensor settings
// Revision: 0
/////////////////////////////////////////////////////////////

#ifndef SENSORSETTINGS_H
#define SENSORSETTINGS_H

#include <string>
#include <vector>

///////////////////////////////
// GENERAL
///////////////////////////////
const std::string MQTT_SERVER_ADDRESS = "tcp://193.170.192.225:1883";

// Quality of service
typedef enum 
{
	QoS_AT_MOST_ONCE = 0,
	QoS_AT_LEAST_ONCE = 1,
	QoS_EXACTLY_ONCE = 2
} QoS_t;

typedef struct
{
	std::string topic;
	std::string sensorVal;
	
} PublishData_t;

typedef std::vector <PublishData_t> PublishDataVec_t;

///////////////////////////////
// SENSOR: HDC1000
///////////////////////////////
const std::string HDC1000_DRIVER_PATH = "/dev/hdc1000";
const std::string MQTT_HDC1000_NAME = "HDC1000";
const std::string MQTT_HDC1000_TEMPERATURE_TOPIC = "SSL/HDC1000/Temperature";
const std::string MQTT_HDC1000_HUMIDITY_TOPIC = "SSL/HDC1000/Humidity";  

///////////////////////////////
// SENSOR: APDS9301
///////////////////////////////
const std::string MQTT_APDS9301_NAME = "APDS9301";
const std::string MQTT_APDS9301_BRIGHTNESS_TOPIC = "SSL/APDS9301/Brightness";


#endif