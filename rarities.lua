if Cryptid then
  SMODS.load_mod_config(SMODS.Mods.Cryptid)
end

SMODS.Rarity {
    key = "peculiar",
    pools = {
        ["Joker"] = true
    },
    default_weight = 0.001,
    badge_colour = HEX('50e3c2'),
    loc_txt = {
      ['default'] = {
            name = "Peculiar"
        },
      ['zh_TW'] = {
            name = "超激稀有"
        },
    },
    get_weight = function(self, weight, object_type)
        return weight
    end,
}