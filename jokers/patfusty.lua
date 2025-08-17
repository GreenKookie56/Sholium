SMODS.Joker{ --Pat Fusty
    key = "patfusty",
    config = {
        extra = {
            play_size = 1,
            play_size2 = 1
        }
    },
    loc_txt = {
        ['name'] = 'Pat Fusty',
        ['text'] = {
            [1] = '{C:attention}+1{} Card selection limit',
            [2] = 'when {C:attention}Boss Blind{} is defeated'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 6,
        y = 4
    },
    cost = 7,
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
        if context.end_of_round and context.main_eval and G.GAME.blind.boss  then
                return {
                    func = function()
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(card.ability.extra.play_size).." Play Size", colour = G.C.BLUE})
                SMODS.change_play_limit(card.ability.extra.play_size)
                return true
            end,
                    extra = {
                        func = function()
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(card.ability.extra.play_size).." Play Size", colour = G.C.BLUE})
                SMODS.change_discard_limit(card.ability.extra.play_size)
                return true
            end,
                        colour = G.C.BLUE
                        }
                }
        end
    end
}