if not next(SMODS.find_mod("Cryptid")) then
  return nil
end

SMODS.Joker{ --Manyullyn Joker
    key = "manyullynjoker",
    config = {
        extra = {
            mult = 1,
            mod = 0.2
        }
    },
    loc_txt = {
        ['name'] = 'Manyullyn Joker',
        ['text'] = {
            [1] = 'When each played card is scored,',
            [2] = '{X:red,C:white}X#1#{} Mult and increase this by {X:red,C:white}#2#{}',
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 8
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 12,
    rarity = 'cry_epic',
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.mult, card.ability.extra.mod}}
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play or context.forcetrigger then
            card.ability.extra.mult = (card.ability.extra.mult) + card.ability.extra.mod
            return {
                Xmult = card.ability.extra.mult
            }
        end
    end
}
