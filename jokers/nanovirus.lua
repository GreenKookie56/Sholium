SMODS.Joker{ --Nano-virus
    key = "nanovirus",
    config = {
        extra = {
            dollars = 2
        }
    },
    loc_txt = {
        ['name'] = 'Nano-virus',
        ['text'] = {
            [1] = 'Earn {C:gold}$2{}',
            [2] = 'when a card is bought'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 3
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 1,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    calculate = function(self, card, context)
        if context.buying_card or context.forcetrigger then
                return {
                    dollars = card.ability.extra.dollars
                }
        end
    end
}