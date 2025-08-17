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
        x = 3,
        y = 4
    },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    in_pool = function(self, args)
          return not args   or args.source == 'sho' or args.source == 'buf' or args.source == 'jud' or args.source == 'rif' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
      end
    ,

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.patch, card.ability.extra.mult}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
                return {
                    Xmult = card.ability.extra.mult
                }
        end
        if context.end_of_round and context.main_eval and G.GAME.blind.boss  and not context.blueprint then
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