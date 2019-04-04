# lua-config-cpp
use lua as config file

## example
config.lua
```lua
common_sampler = {
	address_u = "WRAP",
	address_v = "WRAP",
	address_w = "WRAP",
	magfilter = "LINEAR",
	minfilter = "LINEAR",
	maxfilter = "LINEAR",
}

common_renderstate = {
	cull_mode = "CULL_NONE",
	blend_mode = "",
}

conf = {
	name = 'common',
	description = 'This is a common material',
	author = 'swm',
	type = 'material',
	technique = {
		default = {
			params = {
				emissive_factor  = { type = "float", val = 3.1231, },
				tiling = { type ="float", val = 1.0, },
				DiffuseTex ={
					type = "texture",
					sampler = common_sampler,
					val ='',
				},
				MixTex = {
					type = "texture",
					sampler = common_sampler,
					val ='',
				},
				emissive_color = {
					type = "float4",
					val = {1.0,1.0,0.0,1.0},
				},
			},
		},
	},
	pass = {
		{
			vs_shader = "common_gl.vs",
			ps_shader = "common_gl.ps",
			render_states = common_renderstate,
		}, {
			vs_shader = "common_gl.vs",
			ps_shader = "common_gl.ps",
			render_states = common_renderstate,
		},
	},
}

return conf;
```

Parse result
```
{
    author : "swm",
    description : "This is a common material",
    name : "common",
    pass : {
        {
            ps_shader : "common_gl.ps",
            render_states : {
                blend_mode : "",
                cull_mode : "CULL_NONE"
            },
            vs_shader : "common_gl.vs"
        },
        {
            ps_shader : "common_gl.ps",
            render_states : {
                blend_mode : "",
                cull_mode : "CULL_NONE"
            },
            vs_shader : "common_gl.vs"
        }
    },
    technique : {
        default : {
            params : {
                DiffuseTex : {
                    sampler : {
                        address_u : "WRAP",
                        address_v : "WRAP",
                        address_w : "WRAP",
                        magfilter : "LINEAR",
                        maxfilter : "LINEAR",
                        minfilter : "LINEAR"
                    },
                    type : "texture",
                    val : ""
                },
                MixTex : {
                    sampler : {
                        address_u : "WRAP",
                        address_v : "WRAP",
                        address_w : "WRAP",
                        magfilter : "LINEAR",
                        maxfilter : "LINEAR",
                        minfilter : "LINEAR"
                    },
                    type : "texture",
                    val : ""
                },
                emissive_color : {
                    type : "float4",
                    val : {
                        1,
                        1,
                        0,
                        1
                    }
                },
                emissive_factor : {
                    type : "float",
                    val : 3.1231
                },
                tiling : {
                    type : "float",
                    val : 1
                }
            }
        }
    },
    type : "material"
}
```

## Usage
Parse and print result
```cpp
luaconf::Value value;
bool ret = luaconf::ParseFile(fpath, value);
if (!ret) {
	std::cout << "parse failed!" << std::endl;
	getchar();
	return false;
}
std::cout << value << std::endl;
	
```

Get methods
```cpp
// visit by index
std::string s = value["pass"][0]["ps_shader"].Get<luaconf::string_t>();

// get value
int width;
if (!value.GetValSafety(width) {
	width = 1024;
}

// get child value, same with value[".."].., but  throw no exception
int width;
if (!value.GetValSafety(width, "size", "width") {
	width = 1024;
}

// get int or double array
std::vector<int> v;
value.GetValSafety(v, "array_val);
```
