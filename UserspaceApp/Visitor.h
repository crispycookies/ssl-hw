/////////////////////////////////////////////////////////////
// Author: Patrick Wuerflinger
// Filename: Visitor.h
// Description: Header file for the Visitor interface
// Revision: 0
/////////////////////////////////////////////////////////////

#ifndef VISITOR_H
#define VISITOR_H

#include <memory>
#include "SensorSettings.h"
class HDC1000;

class Visitor
{	
public:
	virtual ~Visitor() = default;
	virtual PublishDataVec_t visitSensor(std::shared_ptr<HDC1000> const & sensor) = 0;
};

#endif