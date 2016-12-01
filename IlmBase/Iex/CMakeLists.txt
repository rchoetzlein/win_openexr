# yue.nicholas@gmail.com

IF(BUILD_SHARED_LIBS)
    ADD_DEFINITIONS(-DIEX_EXPORTS)
ENDIF()

ADD_LIBRARY ( Iex ${LIB_TYPE}
  IexBaseExc.cpp
  IexThrowErrnoExc.cpp
  )

# Packaging lib and includes
POST_COPY ( Iex ${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_CFG_INTDIR} Iex.dll ${CMAKE_BINARY_DIR}/lib )
POST_COPY ( Iex ${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_CFG_INTDIR} Iex.lib ${CMAKE_BINARY_DIR}/lib )
POST_COPY ( Iex ${CMAKE_CURRENT_SOURCE_DIR} *.h "${CMAKE_BINARY_DIR}/include" )


INSTALL ( TARGETS
  Iex
  DESTINATION
  lib
)

INSTALL ( FILES 
  IexBaseExc.h
  IexMathExc.h
  IexThrowErrnoExc.h
  IexErrnoExc.h
  IexMacros.h
  Iex.h
  IexNamespace.h
  IexExport.h
  IexForward.h
  DESTINATION
  include/OpenEXR
)
