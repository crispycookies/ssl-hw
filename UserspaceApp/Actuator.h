/////////////////////////////////////////////////////////////
// Author: Patrick Wuerflinger
// Filename: Actuator.h
// Description: Header file for the the actuator base class
// Revision: 0
/////////////////////////////////////////////////////////////

#ifndef ACTUATOR_H
#define ACTUATOR_H

#include <string>
#include <memory>

class Actuator
{
public:
	Actuator(std::string const & name, std::string const & driverPath);
	virtual ~Actuator() = default;
	std::string getName() const;
	std::string getDriverPath() const;
protected:
	void writeDeviceDriver(std::string const & str) const;
private:
	std::string mName = "";
	std::string mDriverPath = "";
}
;

#endif


