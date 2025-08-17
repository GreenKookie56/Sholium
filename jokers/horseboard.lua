SMODS.Joker{ --Horseboard
    key = "horseboard",
    config = {
        extra = {
            Xmult = 7
        }
    },
    loc_txt = {
        ['name'] = 'Horseboard',
        ['text'] = {
            [1] = 'All played cards give {X:red,C:white}X1{} Mult',
            [2] = 'for every {C:attention}horse react{} in',
            [3] = '{C:dark_edition}Bloonlatro horseboard{}',
            [4] = '(in sholatro-ideas, Bloonlatro server)',
            [5] = '{C:inactive}(Currently{} {X:red,C:white}X7{} {C:inactive}Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 3
    },
    cost = 20,
    rarity = 4,
    blueprint_compat = true,
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
          or args.source ~= 'sho' 
          or args.source == 'buf' or args.source == 'jud' or args.source == 'rif' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
          )
          and true
      end
    ,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
                return {
                    Xmult = card.ability.extra.Xmult
                }
        end
    end
}