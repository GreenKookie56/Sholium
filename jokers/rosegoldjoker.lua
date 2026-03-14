
SMODS.Joker{ --Rose Gold Joker
    key = "rosegoldjoker",
    config = {
        extra = {
            slot_change = '1'
        }
    },
    loc_txt = {
        ['name'] = 'Rose Gold Joker',
        ['text'] = {
            [1] = '{C:dark_edition}+1{} Joker slot',
            [2] = '{C:attention}+1{} Consumable slot'
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
    end,
    
    add_to_deck = function(self, card, from_debuff)
        G.jokers.config.card_limit = G.jokers.config.card_limit + 1
        G.E_MANAGER:add_event(Event({func = function()
            G.consumeables.config.card_limit = G.consumeables.config.card_limit + 1
            return true
        end }))
    end,
    
    remove_from_deck = function(self, card, from_debuff)
        G.jokers.config.card_limit = G.jokers.config.card_limit - 1
        G.E_MANAGER:add_event(Event({func = function()
            G.consumeables.config.card_limit = G.consumeables.config.card_limit - 1
            return true
        end }))
    end
}

local check_for_buy_space_ref = G.FUNCS.check_for_buy_space
G.FUNCS.check_for_buy_space = function(card)
    if card.config.center.key == "j_sholextra_rosegoldjoker" then -- ignore slot limit when bought
        return true
    end
    return check_for_buy_space_ref(card)
end

local can_select_card_ref = G.FUNCS.can_select_card
G.FUNCS.can_select_card = function(e)
    	if e.config.ref_table.config.center.key == "j_sholextra_rosegoldjoker" then
        		e.config.colour = G.C.GREEN
        		e.config.button = "use_card"
    	else
        		can_select_card_ref(e)
    	end
end
