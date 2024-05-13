#ifndef LUACONF_H
#define LUACONF_H
#include <string>
#include <fstream>
#include <iostream>
extern "C"
{
#include <lua.h>
#include <lauxlib.h>
#include <luajit.h>
#include <lualib.h>
}

#include "value.h"

namespace luaconf {
namespace detail {
    bool ParseTable(lua_State *L, Value &table);
    bool ParseValue(lua_State *L, int index, Value &value);
}

bool Parse(const std::string&code, Value &value);
bool ParseFile(const std::string& filepath, Value &value);
}

#endif /* LUACONF_H */
