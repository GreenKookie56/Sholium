if Talisman then
SMODS.Back {
    key = 'deck_of_peam',
    pos = { x = 4, y = 8 },
    config = {
    },
    loc_txt = {
        ['default'] = {
        name = 'Deck of Peam',
        text = {
            [1] = 'Start run with a {C:dark_edition}Peculiar{} Joker'
        },
        },
        ['zh_TW'] = {
        name = '這牌組給到夯',
        text = {
            [1] = '開始時擁有{C:dark_edition}超激稀有{}小丑'
        },
        }
    },
    unlocked = true,
    discovered = true,
    no_collection = false,
    atlas = 'CustomJokers',
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                play_sound('timpani')
                if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                    G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                    local new_joker = SMODS.add_card({ set = 'Joker', rarity = 'sholium_peculiar' })
                    if new_joker then
                    end
                    G.GAME.joker_buffer = 0
                end
                return true
            end
        }))
    end
}
end