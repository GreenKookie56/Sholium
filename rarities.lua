SMODS.Rarity {
    key = "peculiar",
    pools = {
        ["Joker"] = true
    },
    default_weight = 0.001,
    badge_colour = HEX('50e3c2'),
    loc_txt = {
        name = "Peculiar"
    },
    get_weight = function(self, weight, object_type)
        return weight
    end,
}