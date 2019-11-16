/////////////////////////////////////////////////////////////
// Author: Patrick Wuerflinger
// Filename: main.cpp
// Description: Prints the IpAddress on the seven-seg-display
// Revision: 0
/////////////////////////////////////////////////////////////

#include <stdio.h>
#include <unistd.h>
#include <string.h> 
#include <sys/socket.h>
#include <sys/ioctl.h>
#include <netinet/in.h>
#include <net/if.h>
#include <arpa/inet.h>
#include <cstring>
#include <algorithm>
#include <string>
#include <fstream>
#include <iostream>

const size_t BUFFER_IP_ADDRESS = 15;
const std::string SEVEN_SEG_DRIVER_FILE = "/dev/sevensegchar";
 
int main()
{
	try
	{
		char ip_address[BUFFER_IP_ADDRESS];
		int fd;
		struct ifreq ifr;
     
		/*AF_INET - to define network interface IPv4*/
		/*Creating soket for it.*/
		fd = socket(AF_INET, SOCK_DGRAM, 0);
     
		/*AF_INET - to define IPv4 Address type.*/
		ifr.ifr_addr.sa_family = AF_INET;
     
		/*eth0 - define the ifr_name - port name
		where network attached.*/
		memcpy(ifr.ifr_name, "eth0", IFNAMSIZ - 1);
     
		/*Accessing network interface information by
		passing address using ioctl.*/
		ioctl(fd, SIOCGIFADDR, &ifr);
		/*closing fd*/
		close(fd);
     
		/*Extract IP Address*/
		std::strcpy(ip_address, inet_ntoa(((struct sockaddr_in *)&ifr.ifr_addr)->sin_addr));
		
		// convert char array to string and remove dots
		std::string str = ip_address;
		str.erase(std::remove(str.begin(), str.end(), '.'), str.end());
		
		// write to driver
		std::ofstream outfile;
		outfile.open(SEVEN_SEG_DRIVER_FILE, std::ofstream::out);
		if (!outfile.good())
		{
			throw std::string{ "File error!" };
		}
		outfile << reinterpret_cast<const uint8_t*>(&str[0]);
		outfile.close();
	}
	catch(std::string const & error)
	{
		std::cerr << error << std::endl;
		return 1;
	}
	catch(std::bad_alloc const & error)
	{
		std::cerr << "Memory allocation: " << error.what() << std::endl;
		return 1; 
	}
	catch(...)
	{
		std::cerr << "Unhandled Exception" << std::endl;
		return 1; 
	}
	return 0;
}