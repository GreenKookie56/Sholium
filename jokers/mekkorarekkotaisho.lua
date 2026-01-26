if not next(SMODS.find_mod("Cryptid")) then
  return nil
end

SMODS.Joker{ --Taisho
	key = "taisho",
	rarity = 3,
	cost = 9,
  loc_txt = {
        ['name'] = 'Taisho',
        ['text'] = {
            [1] = '{C:attention}Force-trigger{} the Joker to the right',
            [2] = 'for the last hand of the round'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
	blueprint_compat = false,
	demicoloncompat = true,
  unlocked = true,
  discovered = true,
	pos = { x = 8, y = 5 },
  atlas = 'CustomJokers',
	calculate = function(self, card, context)
		if context.joker_main and G.GAME.current_round.hands_left <= 0 and not context.blueprint then
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					if Cryptid.demicolonGetTriggerable(G.jokers.cards[i + 1])[1] then
						local results = Cryptid.forcetrigger(G.jokers.cards[i + 1], context)
						if results and results.jokers then
							results.jokers.message = localize("cry_demicolon")
							results.jokers.colour = G.C.RARITY.cry_epic
							results.jokers.sound = "cry_demitrigger"
							return results.jokers
						end
						return {
							message = localize("cry_demicolon"),
							colour = G.C.RARITY.cry_epic,
							sound = "cry_demitrigger",
						}
					end
				end
			end
		end
	end
}
