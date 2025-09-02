SMODS.Joker{ --Glaive Lord (v48+)
    key = "glaivelord",
    config = {
        extra = {
            chips = 0,
            chipsmod = 6,
            first = 1
        }
    },
    loc_txt = {
        ['name'] = 'Glaive Lord (v48+)',
        ['text'] = {
            [1] = 'This Joker gains {C:blue}+#2#{} Chips',
            [2] = 'for each {C:attention}non-first{} scored card',
            [3] = 'of every {C:attention}hand{}{}',
            [4] = '{C:inactive}(Currently {}{C:blue}+#1#{}{C:inactive} Chips){}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 2,
        y = 2
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = true,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    soul_pos = {
        x = 3,
        y = 2
    },

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.chips, card.ability.extra.chipsmod}}
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  and not context.blueprint then
            if (card.ability.extra.first or 0) == 1 then
                card.ability.extra.first = 0
            elseif (card.ability.extra.first or 0) ~= 1 then
                card.ability.extra.chips = (card.ability.extra.chips) + card.ability.extra.chipsmod
                return {
                    message = "Upgrade!"
                }
            end
        end
        if context.cardarea == G.jokers and context.joker_main  then
                return {
                    chips = card.ability.extra.chips
                }
        end
        if context.after and context.cardarea == G.jokers  and not context.blueprint then
                return {
                    func = function()
                    card.ability.extra.first = 1
                    return true
                end
                }
        end
        if context.forcetrigger then
	SMODS.scale_card(card, {
		ref_table = card.ability.extra,
		ref_value = "chips",
		scalar_value = "chipsmod",
		message_colour = G.C.BLUE,
			})
	return {
                    chips = card.ability.extra.chips
            }
        end
    end
}