SMODS.Joker{ --Cave Monkey
    key = "cavemonkey",
    config = {
        extra = {
            echips = 50
        }
    },
    loc_txt = {
        ['name'] = 'Cave Monkey',
        ['text'] = {
            [1] = 'Me hit rock'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 3
    },
    cost = 30,
    rarity = "sholium_peculiar",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    calculate = function(self, card, context)
        if context.setting_blind  then
                return {
                    func = function()
                local card_front = G.P_CARDS.C_7
                local new_card = create_playing_card({
                    front = card_front,
                    center = G.P_CENTERS.m_stone
                }, G.discard, true, false, nil, true)
            new_card:set_seal("Red", true)
            new_card:set_edition("e_negative", true)
                
                G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                new_card.playing_card = G.playing_card
                table.insert(G.playing_cards, new_card)
                
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.hand:emplace(new_card)
                        new_card:start_materialize()
                        SMODS.calculate_context({ playing_card_added = true, cards = { new_card } })
                        return true
                    end
                }))
            end,
                    message = "Added Card to Hand!"
                }
        end
        if context.individual and context.cardarea == G.play  then
            if SMODS.get_enhancements(context.other_card)["m_stone"] == true then
                return {
                    e_chips = card.ability.extra.echips
                }
            end
        end
    end
}