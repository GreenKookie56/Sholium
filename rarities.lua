SMODS.Rarity {
    key = "the_pro",
    pools = {
        ["Joker"] = true
    },
    default_weight = 0.001,
    badge_colour = HEX('ff9500'),
    loc_txt = {
        name = "The Pro"
    },
    get_weight = function(self, weight, object_type)
        return weight
    end,
}

SMODS.Rarity {
    key = "the_expert",
    pools = {
        ["Joker"] = true
    },
    default_weight = 0,
    badge_colour = HEX('609621'),
    loc_txt = {
        name = "The Expert"
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