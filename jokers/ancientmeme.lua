SMODS.Joker{ --Ancient meme
    key = "ancientmeme",
    config = {
        extra = {
            reroll = 1,
            dollars = 939
        }
    },
    loc_txt = {
        ['name'] = 'Ancient meme',
        ['text'] = {
            [1] = '{X:money,C:edition}=$939{} for the',
            [2] = 'first {C:attention}reroll{} of the {C:green}shop{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 0
    },
    cost = 20,
    rarity = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    in_pool = function(self, args)
          return not args or args.source ~= 'sho' or args.source == 'buf' or args.source == 'jud' or args.source == 'rif' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
      end
    ,

    calculate = function(self, card, context)
        if context.reroll_shop  and not context.blueprint then
            if (card.ability.extra.reroll or 0) == 1 then
                return {
                    func = function()
                    local target_amount = card.ability.extra.dollars
                    local current_amount = G.GAME.dollars
                    local difference = target_amount - current_amount
                    ease_dollars(difference)
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Set to $"..tostring(card.ability.extra.dollars), colour = G.C.MONEY})
                    return true
                end,
                    extra = {
                        func = function()
                    card.ability.extra.reroll = 0
                    return true
                end,
                        colour = G.C.BLUE
                        }
                }
            end
        end
        if context.ending_shop  and not context.blueprint then
                return {
                    func = function()
                    card.ability.extra.reroll = 1
                    return true
                end
                }
        end
    end
}