
SMODS.Joker{ --Literally Cryptid
    key = "literallycryptid",
    config = {
        extra = {
            repetitions = 2
        }
    },
    loc_txt = {
        ['name'] = 'Literally Cryptid',
        ['text'] = {
            [1] = 'if played hand is exactly {C:attention}1{} card,',
            [2] = 'create {C:attention}2{} copies of that card',
            [3] = 'and {C:red}self-destruct{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 7
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  and not context.blueprint then
            if to_big(#context.full_hand) == to_big(1) then
                local target_joker = card
                
                if target_joker then
                    if target_joker.ability.eternal then
                        target_joker.ability.eternal = nil
                    end
                    target_joker.getting_sliced = true
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            target_joker:start_dissolve({G.C.RED}, nil, 1.6)
                            return true
                        end
                    }))
                end
                for i = 1, 2 do
                    local cards_to_copy = {}
                    local target_index = 1
                    if context.full_hand[target_index] then
                        table.insert(cards_to_copy, context.full_hand[target_index])
                    end
                    for i, source_card in ipairs(cards_to_copy) do
                        G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                        local copied_card = copy_card(source_card, nil, nil, G.playing_card)
                        copied_card:add_to_deck()
                        G.deck.config.card_limit = G.deck.config.card_limit + 1
                        table.insert(G.playing_cards, copied_card)
                        G.hand:emplace(copied_card)
                        copied_card.states.visible = nil
                        G.E_MANAGER:add_event(Event({
                            func = function() 
                                copied_card:start_materialize()
                                return true
                            end
                        }))
                    end
                end
            end
        end
    end
}
