SMODS.Joker{ --Iciclez_ alt
    key = "iciclezalt",
    config = {
        extra = {
            Xmult = 1.1
        }
    },
    loc_txt = {
        ['name'] = 'Iciclez_ alt',
        ['text'] = {
            [1] = '{X:red,C:white}X1.1{} Mult',
            [2] = '{C:dark_edition}+1{} Joker slot'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 6,
        y = 2
    },
    cost = 2,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
                return {
                    Xmult = card.ability.extra.Xmult
                }
        end
    end,

    add_to_deck = function(self, card, from_debuff)
        G.jokers.config.card_limit = G.jokers.config.card_limit + 1
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.jokers.config.card_limit = G.jokers.config.card_limit - 1
    end
}

local check_for_buy_space_ref = G.FUNCS.check_for_buy_space
G.FUNCS.check_for_buy_space = function(card)
    if card.config.center.key == "j_sholium_iciclezalt" then -- ignore slot limit when bought
        return true
    end
    return check_for_buy_space_ref(card)
end
