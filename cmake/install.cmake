# Create and install the config file. So that the package can be located by find_package in config mode
include(CMakePackageConfigHelpers)
include(GNUInstallDirs)

include(GNUInstallDirs)
set(LIB_INSTALL_DIR ${CMAKE_INSTALL_LIBDIR}/print)

configure_package_config_file(
	${CMAKE_SOURCE_DIR}/cmake/PrintConfig.cmake.in
	"${CMAKE_CURRENT_BINARY_DIR}/PrintConfig.cmake"
	INSTALL_DESTINATION ${CMAKE_INSTALL_LIBDIR}/print/cmake
	PATH_VARS LIB_INSTALL_DIR
)

install(FILES "${CMAKE_CURRENT_BINARY_DIR}/PrintConfig.cmake"
	DESTINATION ${CMAKE_INSTALL_LIBDIR}/print/cmake
)

# Write version file
include(CMakePackageConfigHelpers)
write_basic_package_version_file(
	"${CMAKE_CURRENT_BINARY_DIR}/PrintConfigVersion.cmake"
	COMPATIBILITY AnyNewerVersion
)

install(FILES "${CMAKE_CURRENT_BINARY_DIR}/PrintConfigVersion.cmake"
	DESTINATION ${CMAKE_INSTALL_LIBDIR}/print/cmake
)
