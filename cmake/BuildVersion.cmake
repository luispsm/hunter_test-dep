include(GNUInstallDirs)

function(generate_version_header target_name)
    set(oneValueArgs PROJECT_NAME)
    cmake_parse_arguments(GENERATE_VERSION_HEADER
        "" #Options 
        "${oneValueArgs}" #One value arg
        ""
        ${ARGN}
    )

    execute_process(
        COMMAND git describe --always --dirty
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        OUTPUT_VARIABLE GIT_COMMIT_HASH
        OUTPUT_STRIP_TRAILING_WHITESPACE
    )

    #generate version file
    set(version_file_path_base ${CMAKE_BINARY_DIR}/versions)
    configure_file(${CMAKE_SOURCE_DIR}/cmake/version.h.in
                   ${version_file_path_base}/${GENERATE_VERSION_HEADER_PROJECT_NAME}/version.h
                   @ONLY)



    target_include_directories(${target_name} 
        PUBLIC 
            $<BUILD_INTERFACE:${version_file_path_base}>
            $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
    )

    install(FILES
        ${version_file_path_base}/${GENERATE_VERSION_HEADER_PROJECT_NAME}/version.h
        DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/print/
    )
endfunction()
