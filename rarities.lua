SMODS.Rarity {
    key = "peculiar",
    pools = {
        ["Joker"] = true
    },
    default_weight = 0.01,
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

SMODS.Rarity {
    key = "subtower",
    pools = {
        ["Joker"] = true
    },
    default_weight = 0,
    badge_colour = HEX('6A7A8B'),
    loc_txt = {
        name = "subtower"
    },
    get_weight = function(self, weight, object_type)
        return weight
    end,
}