/////////////////////////////////////////////////////////////
// Author: Patrick Wuerflinger
// Filename: SevenSegDisplay.cpp
// Description: Source file for the seven segment display
// Revision: 0
/////////////////////////////////////////////////////////////

#include "SevenSegDisplay.h"

const uint8_t PORT_ENABLE = 0xFF;
const uint8_t PORT_DISABLE = 0x00;
const uint8_t MAX_BRIGHTNESS = 0x7F;

void SevenSegDisplay::enable()
{
	mEnable = PORT_ENABLE;
	writeDeviceDriver(createConfigStr());
}

void SevenSegDisplay::disable()
{
	mEnable = PORT_DISABLE;
	writeDeviceDriver(createConfigStr());
}

void SevenSegDisplay::setBrightness(uint8_t const & brightness)
{
	if (brightness <= MAX_BRIGHTNESS)
	{
		mBrightness = brightness;
		writeDeviceDriver(createConfigStr());
	}
	else
	{
		throw std::string{ "SevenSegDisplay:setBrightness: invalid brightness: maximum is 0x7F! " };
	}
}

void SevenSegDisplay::setDigits(DigitsVec_t const & digits)
{
	mDigits = digits;
	writeDeviceDriver(createConfigStr());
}


std::string SevenSegDisplay::createConfigStr()
{
	std::string str = std::to_string(mEnable);
	for (auto & digit : mDigits)
	{
		str += std::to_string(digit);
	}
	str += std::to_string(mBrightness);
	
	return str;
}
