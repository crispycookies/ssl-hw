/////////////////////////////////////////////////////////////
// Author: Patrick Wuerflinger
// Filename: SevenSegDisplay.h
// Description: Header file for the seven segment display
// Revision: 0
/////////////////////////////////////////////////////////////

#ifndef SEVENSEGDISPLAY_H
#define SEVENSEGDISPLAY_H

#include "Actuator.h"
#include <array>

/*
1 Byte : 0xFF EIN 0x00 AUS
6 Byte : Zahlen
1 Byte : 0x00 AUS 0x7F MAXIMUM
*/

const size_t DIGITS_AMOUNT = 6;
const uint8_t MIN_VISIBLE_BRIGHTNESS = 0x0A;
const uint8_t MAX_BRIGHTNESS = 0x7F;
typedef std::array<uint8_t, DIGITS_AMOUNT> DigitsVec_t;

class SevenSegDisplay : public Actuator, public std::enable_shared_from_this<SevenSegDisplay>
{
public:
	SevenSegDisplay(std::string const & sensorName, std::string const & driverPath)
		: Actuator(sensorName, driverPath) {}
	void enable();
	void disable();
	void setBrightness(uint8_t const &  brightness);
	void setDigits(DigitsVec_t const & digits);
private:
	std::string createConfigStr();
	uint8_t mBrightness = 0;
	uint8_t mEnable = 0;
	DigitsVec_t mDigits = { 0 };
};

#endif
