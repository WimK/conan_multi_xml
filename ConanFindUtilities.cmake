
macro(conan_determine_library_build_type basename)   
    if(NOT CONAN_${basename}_ROOT)
        message(FATAL_ERROR "Unable to determine library (${basename}) build type. Make sure you are not running a multi-configuration.")
    else()
        if(NOT ${basename}_BUILD_TYPE)
            file(READ ${CONAN_${basename}_ROOT}/conaninfo.txt CONANINFO_FILE) 
        
            set(${basename}_BUILD_TYPE "Release")
            if(CONANINFO_FILE MATCHES "build_type=Debug")
                set(${basename}_BUILD_TYPE "Debug")
            endif()
        endif()
    endif()
endmacro()

macro(conan_select_include_configurations basename)
    set(${basename}_INCLUDE_DIRS_RELEASE "")
    set(${basename}_INCLUDE_DIRS_DEBUG "")
    if(CONAN_INCLUDE_DIRS_${basename}_RELEASE AND CONAN_INCLUDE_DIRS_${basename}_DEBUG) #multi-configuration
        set(${basename}_INCLUDE_DIRS_RELEASE ${CONAN_INCLUDE_DIRS_${basename}_RELEASE})
        set(${basename}_INCLUDE_DIRS_DEBUG ${CONAN_INCLUDE_DIRS_${basename}_DEBUG})
        set(${basename}_REQUIRED_VARS
            ${basename}_INCLUDE_DIRS_RELEASE
            ${basename}_INCLUDE_DIRS_DEBUG
            ${${basename}_REQUIRED_VARS})        
    elseif(CONAN_INCLUDE_DIRS_${basename}_RELEASE)
        set(${basename}_INCLUDE_DIRS ${CONAN_INCLUDE_DIRS_${basename}_RELEASE})
        set(${basename}_INCLUDE_DIRS_RELEASE ${CONAN_INCLUDE_DIRS_${basename}_RELEASE})
        set(${basename}_REQUIRED_VARS
            ${basename}_INCLUDE_DIRS
            ${${basename}_REQUIRED_VARS})
    elseif(CONAN_INCLUDE_DIRS_${basename}_DEBUG) 
        set(${basename}_INCLUDE_DIRS ${CONAN_INCLUDE_DIRS_${basename}_DEBUG})
        set(${basename}_INCLUDE_DIRS_DEBUG ${CONAN_INCLUDE_DIRS_${basename}_DEBUG})
        set(${basename}_REQUIRED_VARS
            ${basename}_INCLUDE_DIRS
            ${${basename}_REQUIRED_VARS})           
    elseif(CONAN_INCLUDE_DIRS_${basename})    
        set(${basename}_INCLUDE_DIRS ${CONAN_INCLUDE_DIRS_${basename}})
        conan_determine_library_build_type("${basename}")
        if(${basename}_BUILD_TYPE STREQUAL "Debug")        
            set(${basename}_INCLUDE_DIRS_DEBUG ${CONAN_INCLUDE_DIRS_${basename}})
        else()
            set(${basename}_INCLUDE_DIRS_RELEASE ${CONAN_INCLUDE_DIRS_${basename}})
        endif()
        set(${basename}_REQUIRED_VARS
            ${basename}_INCLUDE_DIRS
            ${${basename}_REQUIRED_VARS})
    endif()
endmacro()