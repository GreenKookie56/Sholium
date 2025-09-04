SMODS.Joker{ --The Pudding
    key = "thepudding",
    config = {
        extra = {
            mult = 1.17,
            Spectral = 0
        }
    },
    loc_txt = {
        ['name'] = 'The Pudding',
        ['text'] = {
            [1] = 'Create a {C:dark_edition}Negative{} {C:spectral,E:1}Sholium{}',
            [2] = 'if played hand contains',
            [3] = 'a {C:clubs}Club{} and a {C:attention}7{}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 8,
        y = 4
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 30,
    rarity = "sholium_peculiar",
    blueprint_compat = true,
    demicoloncompat = true,
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
        if context.cardarea == G.jokers and context.joker_main  then
            if ((function()
    local suitCount = 0
    for i, c in ipairs(context.full_hand) do
        if c:is_suit("Clubs") then
            suitCount = suitCount + 1
        end
    end
    
    return suitCount >= 1
end)() and (function()
    local rankCount = 0
    for i, c in ipairs(context.full_hand) do
        if c:get_id() == 7 then
            rankCount = rankCount + 1
        end
    end
    
    return rankCount >= 1
end)()) then
                local created_consumable = true
                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.add_card{set = 'Spectral', key = 'c_sholium_sholium', edition = 'e_negative', key_append = 'joker_forge_spectral'}
                        return true
                    end
                }))
                return {
                    message = created_consumable and localize('k_plus_spectral') or nil
                }
            end
        end
        if context.forcetrigger then
                local created_consumable = true
                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.add_card{set = 'Spectral', key = 'c_sholium_sholium', edition = 'e_negative', key_append = 'joker_forge_spectral'}
                        return true
                    end
                }))
                return {
                    message = created_consumable and localize('k_plus_spectral') or nil
                }
        end
    end
}