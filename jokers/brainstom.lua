SMODS.Joker{ --Brainstom
    key = "brainstom",
    config = {
        extra = {
            chips = 5
        }
    },
    loc_txt = {
        ['name'] = 'Brainstom',
        ['text'] = {
            [1] = 'Copies ability of the',
            [2] = 'midmost {C:attention}Joker{}',
            [3] = '{s:0.8,X:green,C:white} compatible {}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 1
    },
    cost = 10,
    rarity = "sholium__rare",
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
                    chips = card.ability.extra.chips
                }
        end
    end
}