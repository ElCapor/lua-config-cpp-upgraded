-- use common as reference
common_sampler = {
    address_u = "WRAP",
    address_v = "WRAP",
    address_w = "WRAP",
    magfilter = "LINEAR",
    minfilter = "LINEAR",
    maxfilter = "LINEAR",
}

-- function support, generate config dynamic
function get_common_renderstate(test_var)
    return {
        cull_mode = "CULL_NONE",
        blend_mode = "",
        blend_var = test_var,
    }
end

conf = {
    name = 'common',
    description = 'This is a common material',
    author = 'swm',
    type = 'material',
    test_val = {1.0, 1.2, 2.1},
    technique = {
        default = {
            params = {
                emissive_factor  = {
                    type = "float",
                    val = 3.1231,
                },
                tiling = {
                    type ="float",
                    val = 1.0,
                },
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
            render_states = get_common_renderstate(666),
        }, {
            vs_shader = "common_gl.vs",
            ps_shader = "common_gl.ps",
            render_states = get_common_renderstate(888),
        },
    },
}

return conf;
