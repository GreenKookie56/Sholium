SMODS.Joker{ --Stupid Owl Stall
    key = "stupidowlstall",
    config = {
        extra = {
            hands = 1,
            chips = 0,
            odds = 2,
            round = 0
        }
    },
    loc_txt = {
        ['name'] = 'Stupid Owl Stall',
        ['text'] = {
            [1] = 'When a hand is played,',
            [2] = '{C:green}#4# in #5#{} chance',
            [3] = 'to {C:blue}+#1#{} hand and {X:blue,C:white}X#2#{} Chips'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 5,
        y = 4
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
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_sholium_stupidowlstall') 
        return {vars = {card.ability.extra.hands, card.ability.extra.chips, card.ability.extra.round, new_numerator, new_denominator}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main or context.forcetrigger then
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_e9967624', 1, card.ability.extra.odds, 'j_sholium_stupidowlstall', false) then
              SMODS.calculate_effect({x_chips = card.ability.extra.chips}, card)
                        SMODS.calculate_effect({func = function()
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(card.ability.extra.hands).." Hand", colour = G.C.GREEN})
                G.GAME.current_round.hands_left = G.GAME.current_round.hands_left + card.ability.extra.hands
                return true
            end}, card)
          end
            end
        end
    end
}