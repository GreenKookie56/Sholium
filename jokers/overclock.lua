SMODS.Joker{ --Overclock
    key = "overclock",
    config = {
        extra = {
            currentmoney = 0,
            ignore = 0
        }
    },
    loc_txt = {
        ['name'] = 'Overclock',
        ['text'] = {
            [1] = 'Create a {C:dark_edition}Negative{} {C:attention}Boss Farming Guide{}',
            [2] = 'when {C:green}shop{} is rerolled',
            [3] = '{X:legendary,C:white}^${} Mult {C:inactive}(Currently #2#){}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 1,
        y = 6
    },
    cost = 30,
    rarity = "sholium_peculiar",
    blueprint_compat = true,
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
        return {vars = {card.ability.extra.ignore, (G.GAME.dollars or 0)}}
    end,

    calculate = function(self, card, context)
        if context.reroll_shop  then
                return {
                    func = function()
            local created_joker = true
            G.E_MANAGER:add_event(Event({
                func = function()
                    local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_sholium_bossfarmingguide' })
                    if joker_card then
                        joker_card:set_edition("e_negative", true)
                        
                    end
                    
                    return true
                end
            }))
            
            if created_joker then
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_joker'), colour = G.C.BLUE})
            end
            return true
        end
                }
        end
        if context.cardarea == G.jokers and context.joker_main  then
                return {
                    e_mult = G.GAME.dollars
                }
        end
    end
}