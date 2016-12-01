#
# Try to find GLEW library and include path.
# Once done this will define
#
# GLEW_FOUND
# GLEW_INCLUDE_PATH
# GLEW_LIBRARY
# 


IF ( BASE_BUILD_PATH ) 
  IF ( NOT GLEW_ROOT_DIR )
    message ( STATUS "Searching ${BASE_BUILD_PATH} for GLEW.." ) 
    FILE ( GLOB children RELATIVE ${BASE_BUILD_PATH} ${BASE_BUILD_PATH}/*)
    UNSET ( GLEW_ROOT_DIR )
    FOREACH(subdir ${children})
        IF ( "${subdir}" MATCHES "glew(.*)" )
          SET ( GLEW_ROOT_DIR ${BASE_BUILD_PATH}/${subdir}/ CACHE PATH "Path to GLEW")               
       ENDIF()
    ENDFOREACH()     
  ENDIF ( NOT GLEW_ROOT_DIR )
ENDIF ( BASE_BUILD_PATH ) 

IF (WIN32)
	FIND_PATH( GLEW_INCLUDE_PATH GL/glew.h
		$ENV{PROGRAMFILES}/GLEW/include
		${PROJECT_SOURCE_DIR}/src/nvgl/glew/include
    ${GLEW_ROOT_DIR}/include/
		DOC "The directory where GL/glew.h resides")
	FIND_LIBRARY( GLEW_LIBRARY
		NAMES glew GLEW glew32 glew32s
		PATHS
		$ENV{PROGRAMFILES}/GLEW/lib
		${PROJECT_SOURCE_DIR}/src/nvgl/glew/bin
		${PROJECT_SOURCE_DIR}/src/nvgl/glew/lib
    ${GLEW_ROOT_DIR}/lib
    ${GLEW_ROOT_DIR}/lib/Release/x64
		DOC "The GLEW library")
ELSE (WIN32)
	FIND_PATH( GLEW_INCLUDE_PATH GL/glew.h
		/usr/include
		/usr/local/include
		/sw/include
		/opt/local/include
		DOC "The directory where GL/glew.h resides")
	FIND_LIBRARY( GLEW_LIBRARY
		NAMES GLEW glew
		PATHS
		/usr/lib64
		/usr/lib
		/usr/local/lib64
		/usr/local/lib
		/sw/lib
		/opt/local/lib
		DOC "The GLEW library")
ENDIF (WIN32)

UNSET ( GLEW_FOUND CACHE )

IF (NOT EXISTS ${GLEW_INCLUDE_PATH} )   
   SET ( GLEW_INCLUDE_PATH "" )
endif (NOT EXISTS ${GLEW_INCLUDE_PATH} )

IF (NOT EXISTS ${GLEW_LIBRARY} )   
   SET ( GLEW_LIBRARY "" )
endif (NOT EXISTS ${GLEW_LIBRARY} )

IF (GLEW_INCLUDE_PATH AND GLEW_LIBRARY)
	SET( GLEW_FOUND 1 CACHE STRING "Set to 1 if GLEW is found, 0 otherwise")
  message ( STATUS "GLEW Library: Found at ${GLEW_LIBRARY}" )
ELSE (GLEW_INCLUDE_PATH AND GLEW_LIBRARY)
	SET( GLEW_FOUND 0 CACHE STRING "Set to 1 if GLEW is found, 0 otherwise")
  message ( "GLEW Library: Not found. Confirm that GLEW_LIBRARY and GLEW_INCLUDE_PATH are correct." )
ENDIF (GLEW_INCLUDE_PATH AND GLEW_LIBRARY)

MARK_AS_ADVANCED( GLEW_FOUND )
