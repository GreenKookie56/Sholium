
SMODS.Joker{ --Clubism
    key = "clubism",
    config = {
    },
    loc_txt = {
        ['name'] = 'Clubism',
        ['text'] = {
            [1] = 'Increase level of played',
            [2] = '{C:attention}poker hand{} if played hand',
            [3] = 'contains a scoring {C:clubs}Clubs{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    in_pool = function(self, args)
        return (
            not args 
            or args.source ~= 'buf' and args.source ~= 'jud' and args.source ~= 'rif' and args.source ~= 'rta' and args.source ~= 'sou' and args.source ~= 'uta' and args.source ~= 'wra' 
            or args.source == 'sho'
        )
        and true
    end,
 
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.before then
            if (function()
                local count = 0
                for _, playing_card in pairs(context.scoring_hand or {}) do
                    if playing_card:is_suit("Clubs") then
                        count = count + 1
                    end
                end
                return count >= 1
            end)() then
                local target_hand = (context.scoring_name or "High Card")
                return {
                    level_up = true,
                    message = localize('k_level_up_ex')
                }
            end
        end
    end
}
