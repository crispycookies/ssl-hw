/////////////////////////////////////////////////////////////
// Author: Patrick Wuerflinger
// Filename: Settings.h
// Description: Header file for the sensor settings
// Revision: 0
/////////////////////////////////////////////////////////////

#ifndef SETTINGS_H
#define SETTINGS_H

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


// TOPIC, MSG
typedef std::pair<std::string, std::string> PublishData_t; 
typedef std::vector<PublishData_t> PublishDataVec_t;

///////////////////////////////
// THREADS
///////////////////////////////
const size_t THREAD_PUBLISHER_PAUSE_TIME = 20;
const size_t THREAD_HDC1000_PAUSE_TIME = 1000;
const size_t THREAD_APDS9301_PAUSE_TIME = 250;
const size_t THREAD_MPU9250_PAUSE_TIME = 50;

///////////////////////////////
// SENSOR: HDC1000
///////////////////////////////
const std::string HDC1000_DRIVER_PATH = "/dev/hcsensor";
const std::string MQTT_HDC1000_NAME = "HDC1000";
const std::string MQTT_HDC1000_TOPIC = "SSL/HDC1000";

///////////////////////////////
// SENSOR: APDS9301
///////////////////////////////
const std::string APDS9301_DRIVER_PATH = "/dev/apdsensor";
const std::string MQTT_APDS9301_NAME = "APDS9301";
const std::string MQTT_APDS9301_TOPIC = "SSL/APDS9301";

///////////////////////////////
// SENSOR: MPU9250
///////////////////////////////
const std::string MPU9250_DRIVER_PATH = "/dev/mpu";
const std::string MQTT_MPU9250_NAME = "MPU9250";
const std::string MQTT_MPU9250_TOPIC = "SSL/MPU9250";

///////////////////////////////
// ACTUATOR: SEVENSEG
///////////////////////////////
const std::string SEVENSEGDISPLAY_DRIVER_PATH = "/dev/sevensegmentdisplay";
const std::string MQTT_SEVENSEGDIPLAY_NAME = "SevenSegDisplay";

#endif