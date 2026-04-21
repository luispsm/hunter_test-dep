cmake_minimum_required(VERSION 3.20)

project(Print VERSION 0.0.5 LANGUAGES CXX)
list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

add_subdirectory(src)

include(install)
include(Packaging)
