SMODS.Joker{ --Clubism
    key = "clubism",
    config = {
        extra = {
            mult = 1,
            mod = 3
        }
    },
    loc_txt = {
        ['name'] = 'Clubism',
        ['text'] = {
            [1] = 'Each played {C:clubs}Clubs{} gives {X:red,C:white}X#1#{} Mult',
            [2] = 'and increase {X:red,C:white}XMult{} value by {X:red,C:white}#2#{}',
            [3] = 'when scored'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 1
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
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    in_pool = function(self, args)
          return (
          not args 
          or args.source ~= 'buf' and args.source ~= 'jud' and args.source ~= 'rif' and args.source ~= 'rta' and args.source ~= 'sou' and args.source ~= 'uta' and args.source ~= 'wra' 
          or args.source == 'sho'
          )
          and true
      end,

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.mult, card.ability.extra.mod}}
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if context.other_card:is_suit("Clubs") then
                local mult_value = card.ability.extra.mult
                card.ability.extra.mult = (card.ability.extra.mult) + card.ability.extra.mod
                return {
                    Xmult = mult_value
                }
            end
        end
        if context.forcetrigger then
            local mult_value = card.ability.extra.mult
            card.ability.extra.mult = (card.ability.extra.mult) + card.ability.extra.mod
            return {
                Xmult = mult_value
            }
        end
    end
}