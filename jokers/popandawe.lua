SMODS.Joker{ --Pop and Awe (v39)
    key = "popandawe",
    config = {
        extra = {
            chips = -8,
            xchips = 4
        }
    },
    loc_txt = {
        ['name'] = 'Pop and Awe (v39)',
        ['text'] = {
            [1] = '{C:blue}-8{} Chips',
            [2] = '{X:blue,C:white}X4{} Chips'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 8,
        y = 4
    },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    in_pool = function(self, args)
          return (
          not args 
            
          or args.source == 'sho' or args.source == 'buf' or args.source == 'jud' or args.source == 'rif' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
          )
          and true
      end
    ,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
                return {
                    chips = card.ability.extra.chips,
                    extra = {
                        x_chips = card.ability.extra.xchips,
                        colour = G.C.DARK_EDITION
                        }
                }
        end
    end
}