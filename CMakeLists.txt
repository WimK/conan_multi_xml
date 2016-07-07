cmake_minimum_required(VERSION 3.0)

set(TARGET_NAME conan_multi_xml)
project(${TARGET_NAME} CXX)

include(ConanFindUtilities.cmake)

option(CONAN_MULTI_CONF "CMake should use multiconfiguration" ON)

if(${CONAN_MULTI_CONF})
    include(${CMAKE_BINARY_DIR}/conanbuildinfo_multi.cmake)
    set(CMAKE_PREFIX_PATH "${CONAN_CMAKE_MODULE_PATH_RELEASE} ${CONAN_CMAKE_MODULE_PATH_DEBUG} ${CMAKE_PREFIX_PATH}")
    set(CMAKE_MODULE_PATH "${CONAN_CMAKE_MODULE_PATH_RELEASE} ${CONAN_CMAKE_MODULE_PATH_DEBUG} ${CMAKE_MODULE_PATH}")
else()
    include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
    conan_set_find_paths()
    link_directories(${CONAN_LIB_DIRS})
endif() 

find_package(LIBXML2 CONFIG)

message(STATUS "INC RELEASE: ${LIBXML2_INCLUDE_DIRS_RELEASE}")
message(STATUS "INC DEBUG: ${LIBXML2_INCLUDE_DIRS_DEBUG}")
message(STATUS "INC RELEASE/DEBUG: ${LIBXML2_INCLUDE_DIRS}")

message(STATUS "LIB RELEASE: ${LIBXML2_LIBRARY_RELEASE}")
message(STATUS "LIB DEBUG: ${LIBXML2_LIBRARY_DEBUG}")
message(STATUS "LIB RELEASE/DEBUG: ${LIBXML2_LIBRARIES}")

set(SRCS 
    main.cpp)
    
include_directories(
    include
    $<$<CONFIG:Release>:${LIBXML2_INCLUDE_DIRS_RELEASE}>
    $<$<CONFIG:Debug>:${LIBXML2_INCLUDE_DIRS_DEBUG}>
)

add_executable(${TARGET_NAME} ${SRCS} ${HDRS})

target_link_libraries(${TARGET_NAME}
    ${LIBXML2_LIBRARIES})