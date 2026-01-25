SMODS.Joker{ --Boundary
    key = "boundary",
    config = {
        extra = {
            Xmult = 2.718
        }
    },
    loc_txt = {
        ['name'] = 'Boundary',
        ['text'] = {
            [1] = 'lim {C:attention}n{} -> {X:dark_edition,C:white}+infinity{}',
            [2] = '{X:red,C:white}X1.444667861^^n{} Mult',
            [3] = '{C:inactive,s:0.6}Explanation: e^e^-1 has exactly {}',
            [4] = '{C:inactive,s:0.6}1 fixed point for f(x)=a^x, which is e{}',
            [5] = '{C:inactive,s:0.6}That means (e^e^-1)^^inf, or {}',
            [6] = '{C:inactive,s:0.6}(e^e^-1)^(e^e^-1)^... stacking infinite times,{}',
            [7] = '{C:inactive,s:0.6}does not scale past the fix point{}',
            [8] = '{C:inactive,s:0.6}1.444667861 is an approximation of e^e^-1{}',
            [9] = '{C:inactive,s:0.6}which has 2 fixed points for f(x)=a^x, {}',
            [10] = '{C:inactive,s:0.6}which stacks to around 2.718{}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 9,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 3,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main or context.forcetrigger then
                return {
                    Xmult = card.ability.extra.Xmult
                }
        end
    end
}
