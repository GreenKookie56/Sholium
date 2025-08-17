SMODS.Joker{ --Flash
    key = "flash",
    config = {
        extra = {
            xmult = 2,
            ignore = 0
        }
    },
    loc_txt = {
        ['name'] = 'Flash',
        ['text'] = {
            [1] = 'Create {C:attention}2{} {C:dark_edition}Negative{} {C:attention}Flash Card{}s',
            [2] = 'when shop is rerolled',
            [3] = 'Each {C:attention}Flash Card{} gives {X:red,C:white}X#1#{} Mult',
            [4] = 'increase {X:red,C:white}XMult{} value by {X:red,C:white}2x{}',
            [5] = 'when shop is rerolled'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 2
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
        x = 3,
        y = 2
    },
    in_pool = function(self, args)
          return not args or args.source ~= 'buf' and args.source ~= 'jud' and args.source ~= 'rif' and args.source ~= 'rta' and args.source ~= 'sou' and args.source ~= 'uta' and args.source ~= 'wra' or args.source == 'sho'
      end
    ,

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.xmult}}
    end,

    calculate = function(self, card, context)
        if context.reroll_shop  then
                return {
                    func = function()
                    card.ability.extra.xmult = (card.ability.extra.xmult) * 2
                    return true
                end,
                    extra = {
                        func = function()
            local created_joker = true
            G.E_MANAGER:add_event(Event({
                func = function()
                    local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_flash' })
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
        end,
                        colour = G.C.BLUE,
                        extra = {
                            func = function()
            local created_joker = true
            G.E_MANAGER:add_event(Event({
                func = function()
                    local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_flash' })
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
        end,
                            colour = G.C.BLUE
                        }
                        }
                }
        end
        if context.other_joker  then
            if (function()
        return context.other_joker.config.center.key == "j_flash"
    end)() then
                return {
                    Xmult = card.ability.extra.xmult
                }
            end
        end
    end
}