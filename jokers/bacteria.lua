SMODS.Joker{ --Bacteria
    key = "bacteria",
    config = {
        extra = {
            c = 20,
            m = 2,
            respect = 0
        }
    },
    loc_txt = {
        ['name'] = 'Bacteria',
        ['text'] = {
            [1] = '{C:blue}+#1#{} Chips',
            [2] = '{C:red}+#2#{} Mult',
            [3] = 'create a copy of this {C:attention}Joker{}',
            [4] = 'when {C:attention}Blind{} is selected',
            [5] = '{C:inactive}(Removes {}{C:dark_edition}Negative{} {C:inactive}from copy,{}',
            [6] = '{C:inactive}Must have room){}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 3,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 3,
    rarity = 1,
    blueprint_compat = true,
    demicoloncompat = true,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.c, card.ability.extra.m}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main or context.forcetrigger then
                return {
                    chips = card.ability.extra.c,
                    extra = {
                        mult = card.ability.extra.m
                        }
                }
        end
        if context.setting_blind and not context.blueprint then
                return {
                    func = function()
                local target_joker = nil
                for i, joker in ipairs(G.jokers.cards) do
                    if joker.config.center.key == "j_sholium_bacteria" then
                        target_joker = joker
                        break
                    end
                end
                
                if target_joker and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                        G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local copied_joker = copy_card(target_joker, nil, nil, nil, target_joker.edition and target_joker.edition.negative)
                            
                            copied_joker:add_to_deck()
                            G.jokers:emplace(copied_joker)
                        G.GAME.joker_buffer = 0
                            return true
                        end
                    }))
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_duplicated_ex'), colour = G.C.GREEN})
                end
                    return true
                end
                }
        end
    end
}
