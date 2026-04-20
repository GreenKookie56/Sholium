SMODS.current_mod.config_tab = function()
    return {
        n = G.UIT.ROOT,
        config = { r = 0.1, minw = 5, align = "tm", padding = 0.2, colour = G.C.BLACK },
        nodes = {
            {
                n = G.UIT.R,
                config = { padding = 0.2, align = "cm" },
                nodes = {
                    create_toggle({
                        label = "SholiumExtra content (requires game restart)",
                        ref_table = Sholium.config,
                        ref_value = 'sholextra',
                    })
                }
            },
            {
                n = G.UIT.R,
                config = { padding = 0.2, align = "cm" },
                nodes = {
                    create_toggle({
                        label = "PuddlesofPudding content (requires game restart)",
                        ref_table = Sholium.config,
                        ref_value = 'pudding',
                    })
                }
            },
            { n = G.UIT.R, config = { minh = 0.1 } }
        }
    }
end