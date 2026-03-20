if not next(SMODS.find_mod("Cryptid")) then
  return nil
end

SMODS.Joker{ --tt5
    key = "tt5bug",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Total transformation bug (v38)',
        ['text'] = {
            [1] = '{C:attention}Force-trigger{} Joker to the {C:attention}right{}',
            [2] = 'when Joker to the {C:attention}left{} is triggered',
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 4,
        y = 7
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 50,
    rarity = "cry_exotic",
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
	soul_pos = { x = 5, y = 7, extra = { x = 6, y = 7 } },
    
    calculate = function(self, card, context)
        if context.post_trigger then
            local left_joker = nil
            for k, v in ipairs(G.jokers.cards) do
                if v == card then
                    if k > 1 then
                        left_joker = G.jokers.cards[k - 1]
                    end
                end
            end
            if left_joker and context.other_card == left_joker then
			    for i = 1, #G.jokers.cards do
				    if G.jokers.cards[i] == card then
					    if Cryptid.demicolonGetTriggerable(G.jokers.cards[i + 1])[1] then
						    local results = Cryptid.forcetrigger(G.jokers.cards[i + 1], context)
						    if results and results.jokers then
							    return results.jokers
						    end
						end
					end
				end
			end
        end
    end
}
