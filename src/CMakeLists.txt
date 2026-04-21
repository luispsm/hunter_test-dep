include(GNUInstallDirs)

# Targets
set(TARGET_LIB_OBJ ${PROJECT_NAME}_obj)
add_library(${TARGET_LIB_OBJ} OBJECT
			print.cpp
)
set_target_properties(${TARGET_LIB_OBJ} PROPERTIES
    POSITION_INDEPENDENT_CODE ON
)

target_include_directories(${TARGET_LIB_OBJ}
	PUBLIC 
		$<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/include>
		$<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
)

include(BuildVersion)
generate_version_header(${TARGET_LIB_OBJ} PROJECT_NAME "print")

# Define the HEADERS fileset for later installation. Pior to 3.23 this
# was done by manually setting the PUBLIC_HEADER property of the target
# set_target_properties(calc PROPERTIES
# 	PUBLIC_HEADER src/include/calc/basic.h
# )
set(PRINT_PROJECT_ROOT_DIR ${CMAKE_SOURCE_DIR})

target_sources(${TARGET_LIB_OBJ} 
	PUBLIC 
		FILE_SET HEADERS
			TYPE HEADERS
			BASE_DIRS ${PRINT_PROJECT_ROOT_DIR}/include
			FILES ${PRINT_PROJECT_ROOT_DIR}/include/print/print.h
)

set(TARGET_LIB_SHARED ${PROJECT_NAME})
# Target properties (include directories) aren't being propagated to dependent targets
# add_library(${TARGET_LIB_SHARED} SHARED $<TARGET_OBJECTS:${TARGET_LIB_OBJ}>)
add_library(${TARGET_LIB_SHARED} SHARED)
target_link_libraries(${TARGET_LIB_SHARED}
	PUBLIC ${TARGET_LIB_OBJ}
)

set(TARGET_LIB_STATIC ${PROJECT_NAME}_static)
add_library(${TARGET_LIB_STATIC} STATIC $<TARGET_OBJECTS:${TARGET_LIB_OBJ}>)
set_target_properties(${TARGET_LIB_STATIC} PROPERTIES OUTPUT_NAME Print)

# INSTALLATION
## Install target artifacts (library) and headers (fileset)
## also create named export (used from install and export)
install(TARGETS ${TARGET_LIB_SHARED} ${TARGET_LIB_STATIC} ${TARGET_LIB_OBJ} EXPORT PrintTarget
	ARCHIVE
		COMPONENT libraries
		DESTINATION ${CMAKE_INSTALL_LIBDIR}/print
    LIBRARY
        DESTINATION ${CMAKE_INSTALL_LIBDIR}
	FILE_SET HEADERS
)

# After installing the library linker should be updated (for share only)
# install(CODE "execute_process(COMMAND ldconfig)")

# Export without installing. Generate the <name>Targets.cmake to be used from build tree and
# can be then used as include(/path/to/nameTargets.cmake). Manual target selection.
# export(TARGETS ${PROJECT_NAME}
# 	   NAMESPACE lps::
# 	   FILE "${CMAKE_CURRENT_BINARY_DIR}/cmake/${PROJECT_NAME}Targets.cmake"
# )

## Create the <name>Targets.cmake file (same as above) to be used from BUILD dir.
## Nice for devs.
export(EXPORT PrintTarget
	FILE ${CMAKE_CURRENT_BINARY_DIR}/cmake/PrintTargets.cmake
 	NAMESPACE lps::
)

# Install generates and install the targets export file to be used from SYSTEM TREE
install(EXPORT PrintTarget
		DESTINATION ${CMAKE_INSTALL_LIBDIR}/print/cmake
		NAMESPACE lps::
)
