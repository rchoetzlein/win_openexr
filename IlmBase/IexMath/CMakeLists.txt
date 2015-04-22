# pstanczyk@ilm.com

IF(BUILD_SHARED_LIBS)
    ADD_DEFINITIONS(-DIEXMATH_EXPORTS)
ENDIF()
ADD_LIBRARY ( IexMath ${LIB_TYPE}
  IexMathFloatExc.cpp  
  IexMathFpu.cpp
  )
TARGET_LINK_LIBRARIES(IexMath Iex)

# Packaging lib and includes
POST_COPY ( IexMath ${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_CFG_INTDIR} IexMath.dll ${CMAKE_BINARY_DIR}/lib )
POST_COPY ( IexMath ${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_CFG_INTDIR} IexMath.lib ${CMAKE_BINARY_DIR}/lib )
POST_COPY ( IexMath ${CMAKE_CURRENT_SOURCE_DIR} *.h "${CMAKE_BINARY_DIR}/include" )


INSTALL ( TARGETS
  IexMath
  DESTINATION
  lib
)

INSTALL ( FILES 
  IexMathFloatExc.h  
  IexMathFpu.h  
  IexMathIeeeExc.h
  DESTINATION
  include/OpenEXR
)
