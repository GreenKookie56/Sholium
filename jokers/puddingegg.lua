SMODS.Joker{ --Pudding Egg
    key = "puddingegg",
    config = {
        extra = {
            joker_slots = 1
        }
    },
    loc_txt = {
        ['name'] = 'Pudding Egg',
        ['text'] = {
            [1] = '{C:dark_edition}+1{} Joker slot',
            [2] = 'at end of round'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 1,
        y = 4
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 30,
    rarity = "sholium_peculiar",
    blueprint_compat = false,
    demicoloncompat = true,
    eternal_compat = false,
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

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval or context.forcetrigger then
                return {
                    func = function()
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(card.ability.extra.joker_slots).." Joker Slot", colour = G.C.DARK_EDITION})
                G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.joker_slots
                return true
            end
                }
        end
    end
}