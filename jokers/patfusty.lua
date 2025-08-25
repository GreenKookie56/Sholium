SMODS.Joker{ --Pat Fusty
    key = "patfusty",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Pat Fusty',
        ['text'] = {
            [1] = '{C:attention}+100{} Card selection limit',
            [2] = '{C:inactive}big monke{}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 7,
        y = 3
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 7,
    rarity = 3,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    calculate = function(self, card, context)
    end,

    add_to_deck = function(self, card, from_debuff)
        SMODS.change_play_limit(100)
        SMODS.change_discard_limit(100)
    end,

    remove_from_deck = function(self, card, from_debuff)
        SMODS.change_play_limit(-100)
        SMODS.change_discard_limit(-100)
    end
}