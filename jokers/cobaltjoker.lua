
SMODS.Joker{ --Cobalt Joker
    key = "cobaltjoker",
    config = {
    },
    loc_txt = {
        ['name'] = 'Cobalt Joker',
        ['text'] = {
            [1] = '{C:attention}Retrigger{} the effect of',
            [2] = 'Joker to the right'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 8
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 10,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

	calculate = function(self, card, context)

        if context.retrigger_joker then 
            return{
                repetitions = 1,
                retrigger_joker = retrigger_card
            }
        end
		if context.retrigger_joker_check and not context.retrigger_joker and context.other_card ~= self then
        local target_joker = nil
        local my_pos = nil
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i] == card then
                my_pos = i
                break
            end
        end
			if context.other_card == G.jokers.cards[my_pos + 1] then
				return {
					message = localize("k_again_ex"),
					repetitions = 1,
					card = card,
				}
			else
				return nil, true
			end
		end
	end,
}