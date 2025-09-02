SMODS.Joker{ --Giganotosaurus
    key = "giganotosaurus",
    config = {
        extra = {
            hands = 2,
            Xmult = 10,
            round = 0
        }
    },
    loc_txt = {
        ['name'] = 'Giganotosaurus',
        ['text'] = {
            [1] = '{X:red,C:white}X10{} Mult',
            [2] = '{C:blue}-2{} hands',
            [3] = 'when a hand is played'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 2
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 9,
    rarity = 2,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers  and not context.blueprint then
                return {
                    func = function()
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "-"..tostring(card.ability.extra.hands).." Hand", colour = G.C.RED})
                G.GAME.current_round.hands_left = G.GAME.current_round.hands_left - card.ability.extra.hands
                return true
            end
                }
        end
        if context.cardarea == G.jokers and context.joker_main or context.forcetrigger then
                return {
                    Xmult = card.ability.extra.Xmult
                }
        end
    end
}