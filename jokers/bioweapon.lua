
SMODS.Joker{ --Bioweapon
    key = "bioweapon",
    config = {
        extra = {
            minusmod = 2,
            timesmod = 0.4,
            minus = 0,
            times = 1
        }
    },
    loc_txt = {
        ['name'] = 'Bioweapon',
        ['text'] = {
            [1] = 'This Joker gains',
            [2] = '{C:red}-#1#{} Mult and {X:red,C:white}X#2#{} Mult',
            [3] = 'at the end of round',
            [4] = '{C:inactive}(Currently{} {C:red}#3#{}{C:inactive},{} {X:red,C:white}X#4#{} {C:inactive}Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 5,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = true,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.minusmod, card.ability.extra.timesmod, card.ability.extra.minus, card.ability.extra.times}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                mult = card.ability.extra.minus,
                extra = {
                    Xmult = card.ability.extra.times
                }
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval  and not context.blueprint then
            return {
                func = function()
                    card.ability.extra.minus = lenient_bignum(card.ability.extra.minus - card.ability.extra.minusmod)
                    return true
                end,
                message = "Upgrade!",
                extra = {
                    func = function()
                        card.ability.extra.times = lenient_bignum(card.ability.extra.times + card.ability.extra.timesmod)
                        return true
                    end,
                    colour = G.C.GREEN
                }
            }
        end
		if context.forcetrigger then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "times",
				scalar_value = "timesmod",
				message_key = "a_xmult",
				message_colour = G.C.RED,
			})
			return {
				Xmult = card.ability.extra.times,
			}
		end
    end
}
