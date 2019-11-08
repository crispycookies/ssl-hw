cmake_minimum_required(VERSION 3.0)

############################################
# Setup your paths
############################################
set (MY_CROSSCOMPILER_DIR /home/patrick/Schreibtisch/CrossCompiler)
set (MY_CROSSCOMPILER_C_PATH ${MY_CROSSCOMPILER_DIR}/gcc-arm-8.3-2019.03-x86_64-arm-linux-gnueabihf/bin/arm-linux-gnueabihf-gcc)
set (MY_CROSSCOMPILER_CXX_PATH ${MY_CROSSCOMPILER_DIR}/gcc-arm-8.3-2019.03-x86_64-arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++)
############################################

SET(CMAKE_SYSTEM_NAME Generic)
SET(CMAKE_SYSTEM_VERSION 1)
SET(CMAKE_SYSTEM_PROCESSOR arm)
SET(CMAKE_CROSSCOMPILING 1)

set(CMAKE_C_COMPILER ${MY_CROSSCOMPILER_C_PATH})
set(CMAKE_CXX_COMPILER ${MY_CROSSCOMPILER_CXX_PATH})

#set (CMAKE_C_FLAGS "--specs=nosys.specs")
#set (CMAKE_CXX_FLAGS "--specs=nosys.specs")

project (Project_SSL)

add_subdirectory(Project_HelloWorld)
add_subdirectory(Project_IpAdress)
