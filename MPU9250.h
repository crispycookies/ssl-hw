/////////////////////////////////////////////////////////////
// Author: Patrick Wuerflinger
// Filename: MPU9250.h
// Description: Header file for the MPU9250 sensor
// Revision: 0
/////////////////////////////////////////////////////////////

#ifndef MPU9250_H
#define MPU9250_H

#include "Sensor.h"
#include "signal.h"

typedef struct
{
	float x;
	float y;
	float z;
} ThreeAxis_t;

class MPU9250 : public Sensor, public std::enable_shared_from_this<MPU9250>
{
public:
	MPU9250(std::string const & sensorName, std::string const & driverPath, size_t const & pauseMs, std::shared_ptr<ConcurrentQueue<PublishData_t>> const & queue)
		: Sensor(sensorName, driverPath, pauseMs, queue)
	{
		initIRQ();
	}
	
	static void measureIRQ(int n, siginfo_t *info, void * me);	
	void setThresholdValues(ThreeAxis_t const & accLowerBound, ThreeAxis_t const & accUpperBound);	
	void setStreamingMode(bool const & eventmode);
	ThreeAxis_t getGyroscope() const;
	ThreeAxis_t getAccelerator() const;
	ThreeAxis_t getMagnetometer() const;
protected:
	virtual PublishDataVec_t accept(std::shared_ptr<Visitor> const & visitor) override;
	virtual void measure() override;		
private:
	void initIRQ();
	void handleIRQ();	
	std::string createConfigStr();
	ThreeAxis_t mGyroscope;
	ThreeAxis_t mAccelerator;
	ThreeAxis_t mMagnetometer;	
	ThreeAxis_t mAccLowerBound;
	ThreeAxis_t mAccUpperBound;	
	bool mEventMode = false;
	pid_t mPidNumber;
	static MPU9250 * ptrMe;
}
;

#endif