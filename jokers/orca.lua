SMODS.Joker{ --Orca (v36.0-36.1)
    key = "orca",
    config = {
        extra = {
            patch = 1,
            mult = 18.75,
            dead = 0
        }
    },
    loc_txt = {
        ['name'] = 'Orca (v36.0-36.1)',
        ['text'] = {
            [1] = '{X:red,C:white}X#2#{} Mult',
            [2] = 'sets to {X:red,C:white}X#1#{} Mult when',
            [3] = '{C:attention}Boss Blind{} is defeated'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 4,
        y = 3
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 7,
    rarity = 1,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.patch, card.ability.extra.mult}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
                return {
                    Xmult = card.ability.extra.mult
                }
        end
        if (context.end_of_round and context.main_eval and G.GAME.blind.boss  and not context.blueprint) or context.forcetrigger then
            if (card.ability.extra.dead or 0) == 0 then
                return {
                    func = function()
                    card.ability.extra.dead = 1
                    return true
                end,
                    extra = {
                        func = function()
                    card.ability.extra.mult = card.ability.extra.patch
                    return true
                end,
                            message = "Patched!",
                        colour = G.C.BLUE
                        }
                }
            end
        end
    end
}
