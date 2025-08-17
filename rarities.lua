SMODS.Rarity {
    key = "peculiar",
    pools = {
        ["Joker"] = true
    },
    default_weight = 0.005,
    badge_colour = HEX('50e3c2'),
    loc_txt = {
        name = "Peculiar"
    },
    get_weight = function(self, weight, object_type)
        return weight
    end,
}

SMODS.Rarity {
    key = "_rare",
    pools = {
        ["Joker"] = true
    },
    default_weight = 0.001,
    badge_colour = HEX('ff4936'),
    loc_txt = {
        name = " rare"
    },
    get_weight = function(self, weight, object_type)
        return weight
    end,
}