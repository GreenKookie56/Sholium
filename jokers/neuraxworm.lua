if Talisman then

SMODS.Joker{ --Neurax worm
    key = "neuraxworm",
    config = {
        extra = {
            mult = 1.1,
            odds = 2
        }
    },
    loc_txt = {
        ['name'] = 'Neurax worm',
        ['text'] = {
            [1] = 'Each card held in hand has a',
            [2] = '{C:green}#2# in #3#{} chance to {X:legendary,C:white}^#1#{} Mult'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 3
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 30,
    rarity = "sholium_peculiar",
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    soul_pos = {
        x = 3,
        y = 3
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
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_sholium_neuraxworm') 
        return {vars = {card.ability.extra.mult, new_numerator, new_denominator}}
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round then
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_ea22710b', 1, card.ability.extra.odds, 'j_sholium_neuraxworm', false) then
              SMODS.calculate_effect({e_mult = card.ability.extra.mult}, card)
          end
            end
        end
        if context.forcetrigger then
            return {
                e_mult = card.ability.extra.mult
            }
        end
    end
}

end