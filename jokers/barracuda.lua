SMODS.Joker{ --Barracuda
    key = "barracuda",
    config = {
        extra = {
            repetitions = 2
        }
    },
    loc_txt = {
        ['name'] = 'Barracuda',
        ['text'] = {
            [1] = 'Retrigger each played',
            [2] = '{C:attention}6, 7, 8, 9 or 10{} {C:dark_edition}twice{}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 5,
        y = 0
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
        if context.repetition and context.cardarea == G.play  then
            if (context.other_card:get_id() == 6 or context.other_card:get_id() == 7 or context.other_card:get_id() == 8 or context.other_card:get_id() == 9 or context.other_card:get_id() == 10) then
                return {
                    repetitions = card.ability.extra.repetitions,
                    message = "Again!"
                }
            end
        end
    end
}