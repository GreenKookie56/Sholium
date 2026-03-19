SMODS.Joker{ --Ezili
    key = "ezili",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Ezili',
        ['text'] = {
            [1] = '{C:purple}Balances{} {C:blue}Chips{} and {C:red}Mult{}',
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 6,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 7,
    rarity = 3,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                balance = true,
                message = "Hex"
            }
        end
        if context.forcetrigger then
            return {
                balance = true,
                message = "Hex"
            }
        end
    end
}
