#include <string>
#include <iostream>

#include <luaconf/luaconf.h>

std::string s = "return {x= 1}";

std::string fpath = "E:\\Code\\lua-config-cpp\\test\\config.lua";

int main(int argc, char *argv[]) {
	std::cout << "input file path(default " << fpath << "): ";
	std::string line;
	std::getline(std::cin, line);
	if (line.length() > 0) fpath = line;
	luaconf::Value value;
	bool ret = luaconf::ParseFile(fpath, value);
	if (!ret) {
		std::cout << "parse failed!" << std::endl;
		getchar();
		return false;
	}
	
	std::cout << value << std::endl;

	std::string s = value["pass"][0]["ps_shader"].Get<luaconf::string_t>();
	std::cout << s << std::endl;

	std::vector<double> v;
	value.GetValSafety(v, "test_val");
	getchar();
}