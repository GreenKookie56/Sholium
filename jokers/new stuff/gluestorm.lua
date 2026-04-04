
SMODS.Joker{ --Glue Storm (v39+)
    key = "gluestorm",
    config = {
        extra = {
            active = 0,
        }
    },
    loc_txt = {
        ['name'] = 'Glue Storm (v39+)',
        ['text'] = {
            [1] = 'Retrigger all {C:attention}held in hand{} effect {C:attention}twice{}',
            [2] = 'every other hand {C:inactive}(#1#){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 8,
        y = 8
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        local function process_var()
			if card.ability.extra.active == 0 then
				return 'Inactive'
            else
                return 'Active!'
			end
		end
		return {
			vars = {
                process_var(card.ability.extra.active),
			},
		}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  and not context.blueprint then
            if to_big((card.ability.extra.active or 0)) == to_big(0) then
                card.ability.extra.active = 1
            elseif to_big((card.ability.extra.active or 0)) ~= to_big(0) then
                card.ability.extra.active = 0
            end
        end
        if context.repetition and context.cardarea == G.hand and (not context.other_card.debuff) and (next(context.card_effects[1]) or #context.card_effects > 1)  then
            if to_big((card.ability.extra.active or 0)) ~= to_big(0) then
                return {
                    repetitions = 2,
                    message = localize('k_again_ex')
                }
            end
        end
    end
}