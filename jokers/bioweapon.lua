SMODS.Joker{ --Bioweapon
    key = "bioweapon",
    config = {
        extra = {
            mult = 1,
            mod = 0.3
        }
    },
    loc_txt = {
        ['name'] = 'Bioweapon',
        ['text'] = {
            [1] = 'This Joker gains {X:red,C:white}X#2#{} Mult',
            [2] = 'at the end of round',
            [3] = '{C:inactive}(Currently{} {X:red,C:white}X#1#{} {C:inactive}Mult){}'
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
        return {vars = {card.ability.extra.mult, card.ability.extra.mod}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
                return {
                    Xmult = card.ability.extra.mult
                }
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
                return {
                    func = function()
                    card.ability.extra.mult = (card.ability.extra.mult) + card.ability.extra.mod
                    return true
                end,
                    message = "Upgrade!"
                }
        end
		if context.forcetrigger then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "mult",
				scalar_value = "mod",
				message_key = "a_xmult",
				message_colour = G.C.RED,
			})
			return {
				Xmult_mod = card.ability.extra.mult,
			}
		end
    end
}