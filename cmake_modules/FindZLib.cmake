#
# Try to find GLEW library and include path.
# Once done this will define
#
# GLEW_FOUND
# GLEW_INCLUDE_PATH
# GLEW_LIBRARY
# 


IF ( BASE_BUILD_PATH ) 
  IF ( NOT ZLIB_ROOT_DIR )
    message ( STATUS "Searching ${BASE_BUILD_PATH} for Zlib.." ) 
    FILE ( GLOB children RELATIVE ${BASE_BUILD_PATH} ${BASE_BUILD_PATH}/*)
    UNSET ( ZLIB_ROOT_DIR )
    FOREACH(subdir ${children})
        IF ( "${subdir}" MATCHES "zlib(.*)" )
          SET ( ZLIB_ROOT_DIR ${BASE_BUILD_PATH}/${subdir}/ CACHE PATH "Path to ZLib")
       ENDIF()
    ENDFOREACH()     
  ENDIF ()
ENDIF ()

IF (WIN32)
	FIND_PATH( ZLIB_INCLUDE_PATH zlib.h
		$ENV{PROGRAMFILES}/zlib/include
		${PROJECT_SOURCE_DIR}/src/nvgl/zlib/include
    ${ZLIB_ROOT_DIR}/include/
		DOC "The directory where zlib.h resides")
	FIND_LIBRARY( ZLIB_LIBRARY
		NAMES zlib ZLIB zlibd zlibstatic
		PATHS
		$ENV{PROGRAMFILES}/zlib/lib
		${PROJECT_SOURCE_DIR}/src/nvgl/zlib/bin
		${PROJECT_SOURCE_DIR}/src/nvgl/zlib/lib
    ${ZLIB_ROOT_DIR}/lib    
		DOC "The ZLIB library")
ELSE (WIN32)
	FIND_PATH( ZLIB_INCLUDE_PATH zlib.h
		/usr/include
		/usr/local/include
		/sw/include
		/opt/local/include
		DOC "The directory where zlib.h resides")
	FIND_LIBRARY( GLEW_LIBRARY
		NAMES zlib ZLIB zlibd zlibstatic
		PATHS
		/usr/lib64
		/usr/lib
		/usr/local/lib64
		/usr/local/lib
		/sw/lib
		/opt/local/lib
		DOC "The ZLIB library")
ENDIF (WIN32)

UNSET ( ZLIB_FOUND CACHE )

IF (NOT EXISTS ${ZLIB_INCLUDE_PATH} )   
   SET ( ZLIB_INCLUDE_PATH "" )
endif ()

IF (NOT EXISTS ${ZLIB_LIBRARY} )   
   SET ( ZLIB_LIBRARY "" )
endif ()

UNSET ( ZLIB_FOUND CACHE)

IF ( (NOT ${ZLIB_INCLUDE_PATH} STREQUAL "") AND (NOT ${ZLIB_LIBRARY} STREQUAL "") )
	SET( ZLIB_FOUND TRUE CACHE BOOL "")
  message ( STATUS "Zlib Library: Found at ${ZLIB_LIBRARY}" )
ELSE ()
  SET ( ZLIB_FOUND FALSE CACHE BOOL "")
  message ( "Zlib Library: Not found. Confirm that ZLIB_LIBRARY and ZLIB_INCLUDE_PATH are correct." )
ENDIF ()

MARK_AS_ADVANCED( ZLIB_FOUND )
