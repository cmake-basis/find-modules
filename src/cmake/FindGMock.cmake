##############################################################################
# \file  FindGMock.cmake
# \brief Find Google Mock package.
#
# Input variables:
#
#   GMock_DIR                The Google Mock package files are searched under
#                            the specified root directory. If they are not found
#                            there, the default search paths are considered.
#                            This variable can also be set as environment variable.
#   GMOCK_DIR                Alternative environment variable for GMock_DIR.
#   GMock_SHARED_LIBRARIES   Forces this module to search for shared libraries.
#                            Otherwise, static libraries are preferred.
#
# Sets the following CMake variables:
#
#   GMock_FOUND          Whether the package was found and the following CMake
#                        variables are valid.
#   GMock_INCLUDE_DIR    Package include directories.
#   GMock_INCLUDES       Include directories including prerequisite libraries.
#   GMock_LIBRARY        Package libraries.
#   GMock_LIBRARIES      Package ibraries and prerequisite libraries.
#
# Copyright (c) 2011 University of Pennsylvania. All rights reserved.
# See COPYING file in project root or 'doc' directory for details.
#
# Contact: SBIA Group <sbia-software -at- uphs.upenn.edu>
##############################################################################

# ----------------------------------------------------------------------------
# initialize search
if (NOT DEFINED GMock_DIR)
  set (GMock_DIR "" CACHE PATH "Installation prefix for Google Mock")
endif ()

set (GMock_ORIG_CMAKE_FIND_LIBRARY_SUFFIXES ${CMAKE_FIND_LIBRARY_SUFFIXES})

if (GMock_SHARED_LIBRARIES)
  if (WIN32)
    set (CMAKE_FIND_LIBRARY_SUFFIXES .dll)
  else ()
    set (CMAKE_FIND_LIBRARY_SUFFIXES .so)
  endif()
else ()
  if (WIN32)
    set (CMAKE_FIND_LIBRARY_SUFFIXES .lib)
  else ()
    set (CMAKE_FIND_LIBRARY_SUFFIXES .a)
  endif()
endif ()

set (GMock_HINTS "HINTS ${GMock_DIR}" ENV GMock_DIR ENV GMOCK_DIR)

# ----------------------------------------------------------------------------
# find paths/files
find_path (
  GMock_INCLUDE_DIR
    NAMES         gmock.h
    ${GMock_HINTS}
    PATH_SUFFIXES "include/gmock"
    DOC           "Include directory for Google Mock"
    NO_DEFAULT_PATH
)

find_path (
  GMock_INCLUDE_DIR
    NAMES gmock.h
    HINTS ENV C_INCLUDE_PATH ENV CXX_INCLUDE_PATH
    DOC   "Include directory for Google Mock"
)

find_library (
  GMock_LIBRARY
    NAMES         gmock
    ${GMock_HINTS}
    PATH_SUFFIXES "lib"
    DOC           "Link library for Google Mock (gmock)"
    NO_DEFAULT_PATH
)

find_library (
  GMock_LIBRARY
    NAMES gmock
    HINTS ENV LD_LIBRARY_PATH
    DOC   "Link library for Google Mock (gmock)"
)

# ----------------------------------------------------------------------------
# prerequisite libraries
set (GMock_INCLUDES  "${GMock_INCLUDE_DIR}")
set (GMock_LIBRARIES "${GMock_LIBRARY}")

# ----------------------------------------------------------------------------
# reset CMake variables
set (CMAKE_FIND_LIBRARY_SUFFIXES ${GTest_ORIG_CMAKE_FIND_LIBRARY_SUFFIXES})

# ----------------------------------------------------------------------------
# aliases / backwards compatibility
set (GMock_INCLUDE_DIRS "${GTest_INCLUDES}")

# ----------------------------------------------------------------------------
# handle the QUIETLY and REQUIRED arguments and set *_FOUND to TRUE
# if all listed variables are found or TRUE
include (FindPackageHandleStandardArgs)

find_package_handle_standard_args (
  GMock
# MESSAGE
    DEFAULT_MSG
# VARIABLES
    GMock_INCLUDE_DIR
    GMock_LIBRARY
)
