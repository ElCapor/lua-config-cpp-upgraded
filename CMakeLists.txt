project(luaconfig)

cmake_minimum_required(VERSION 3.12)

# build config
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_VERBOSE_MAKEFILE ON)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(LIBRARY_OUTPUT_PATH ${PROJECT_BINARY_DIR}/lib)
set(EXECUTABLE_OUTPUT_PATH ${PROJECT_BINARY_DIR}/bin)

# options
set(BUILD_SHARED_LIBS "Build shared libs" OFF)


find_package(Lua)
if (NOT LUA_FOUND)
	message("include lua/install for liblua")
	set(CMAKE_PREFIX_PATH lua/install)
endif()

# find lua again, fatal if cant find it again
find_package(Lua)
if (NOT LUA_FOUND) 
	message(FATAL_ERROR "lua not found!")
endif()

include_directories(${LUA_INCLUDE_DIR})


set(luaconf_src luaconf/value.h luaconf/luaconf.h)

add_executable(luaconfig test/main.cc ${luaconf_src})
target_link_libraries(luaconfig ${LUA_LIBRARIES})

install(DIRECTORY luaconf/ DESTINATION include/luaconf FILES_MATCHING PATTERN "*.h")