SMODS.Joker{ --The Pudding
    key = "thepudding",
    config = {
        extra = {
            mult = 17,
            peculiar = 0,
            ignore = 0
        }
    },
    loc_txt = {
        ['name'] = 'The Pudding',
        ['text'] = {
            [1] = 'Applies {C:attention}Showman{} effect',
            [2] = 'Create a {C:dark_edition}Negative{} {C:spectral,E:1}Peculiar{} Joker',
            [3] = 'if played hand contains',
            [4] = 'a {C:clubs}Club{} and a {C:attention}7{}',
            [5] = 'Each {C:dark_edition,E:1}Peculiar{} Joker gives',
            [6] = '{X:legendary,C:white}^#1#{} Mult'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 6,
        y = 7
    },
    cost = 30,
    rarity = "sholium_peculiar",
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

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.mult}}
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
                local created_joker = true
                  G.E_MANAGER:add_event(Event({
                      func = function()
                          local joker_card = SMODS.add_card({ set = 'Joker', rarity = 'sholium_peculiar' })
                          if joker_card then
                              joker_card:set_edition("e_negative", true)
                              
                          end
                          
                          return true
                      end
                  }))
                return {
                    message = created_joker and localize('k_plus_joker') or nil
                }
            end
        end
        if context.other_joker  then
            if (function()
    return context.other_joker.config.center.rarity == "sholium_peculiar"
end)() then
                return {
                    e_mult = card.ability.extra.mult
                }
            end
        end
    end,

    add_to_deck = function(self, card, from_debuff)
        -- Showman effect enabled (allow duplicate cards)
    end,

    remove_from_deck = function(self, card, from_debuff)
        -- Showman effect disabled
    end
}


local smods_showman_ref = SMODS.showman
function SMODS.showman(card_key)
    if next(SMODS.find_card("j_sholium_thepudding")) then
        return true
    end
    return smods_showman_ref(card_key)
end