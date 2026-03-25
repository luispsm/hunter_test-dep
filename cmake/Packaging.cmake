# Package general information 
set(CPACK_PACKAGE_NAME "Print")
set(CPACK_PACKAGE_VERSION "0.0.1")
set(CPACK_PACKAGE_VENDOR "LPS")
set(CPACK_PACKAGE_CONTACT "lpsdevel14@example.com")
set(CPACK_PACKAGE_DESCRIPTION "Simple print project")

# binary package
set(CPACK_GENERATOR "TGZ")   # or ZIP, DEB, RPM, etc.

# source package
set(CPACK_SOURCE_GENERATOR "TGZ")
set(CPACK_SOURCE_IGNORE_FILES
    /build/
    /.git/
    /.vscode/
  
)

# ignore directories and files
set(CPACK_SOURCE_IGNORE_FILES
  "/.git/"
  "/.vscode/"
  "/build/"
  "/release/"
  "/CMakeCache.txt"
  "/CMakeFiles/"
  "/cmake_install.cmake"
  "/CPackConfig.cmake"
  "/_build/"
)

set(CPACK_PACKAGE_DIRECTORY ${CMAKE_BINARY_DIR}/Packaging)

include(CPack)