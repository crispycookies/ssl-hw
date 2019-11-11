cmake_minimum_required(VERSION 3.5)

project(IpAddress LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_executable(IpAddress main.cpp)

set(CMAKE_INSTALL_PREFIX "/home/root/CrossCompileFolder")
install(TARGETS ${PROJECT_NAME}
        RUNTIME DESTINATION ${CMAKE_INSTALL_PREFIX}/bin
)
