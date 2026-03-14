
SMODS.Joker{ --Rose Gold Joker
    key = "rosegoldjoker",
    config = {
        extra = {
            slot_change = '2'
        }
    },
    loc_txt = {
        ['name'] = 'Rose Gold Joker',
        ['text'] = {
            [1] = '{C:attention}+2{} Consumable slots',
            [2] = '{X:chips,C:white}X0.7{} Chips'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 8,
        y = 6
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main and not context.blueprint then
            return {
                x_chips = 0.7
            }
        end
    end,
    
    add_to_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({func = function()
            G.consumeables.config.card_limit = G.consumeables.config.card_limit + 2
            return true
        end }))
    end,
    
    remove_from_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({func = function()
            G.consumeables.config.card_limit = G.consumeables.config.card_limit - 2
            return true
        end }))
    end
}
