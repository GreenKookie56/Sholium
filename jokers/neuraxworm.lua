SMODS.Joker{ --Neurax worm
    key = "neuraxworm",
    config = {
        extra = {
            mult = 13
        }
    },
    loc_txt = {
        ['name'] = 'Neurax worm',
        ['text'] = {
            [1] = 'Each card held in hand',
            [2] = 'gives {X:legendary,C:white}^#1#{} Mult'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 8,
        y = 5
    },
    cost = 30,
    rarity = "sholium_peculiar",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    soul_pos = {
        x = 9,
        y = 5
    },
    in_pool = function(self, args)
          return (
          not args 
          or args.source ~= 'buf' and args.source ~= 'jud' and args.source ~= 'rif' and args.source ~= 'rta' and args.source ~= 'sou' and args.source ~= 'uta' and args.source ~= 'wra' 
          or args.source == 'sho'
          )
          and true
      end,

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.mult}}
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round  then
                return {
                    e_mult = card.ability.extra.mult
                }
        end
    end
}