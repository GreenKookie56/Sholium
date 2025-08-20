SMODS.Joker{ --A peculiar deck in the observable universe that contains every decks
    key = "adeckp",
    config = {
        extra = {
            ignore = 0
        }
    },
    loc_txt = {
        ['name'] = 'A peculiar deck in the observable universe that contains every decks',
        ['text'] = {
            [1] = 'Create {C:dark_edition}EVERY DECKS{} when a hand is played {C:inactive}(apditoutced included){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 5,
        y = 1
    },
    cost = 52,
    rarity = "sholium_peculiar",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    soul_pos = {
        x = 6,
        y = 1
    },

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
                local created_joker = true
                  G.E_MANAGER:add_event(Event({
                      func = function()
                          local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_sholium_adeck1' })
                          if joker_card then
                              
                              
                          end
                          
                          return true
                      end
                  }))
                local created_joker = true
                  G.E_MANAGER:add_event(Event({
                      func = function()
                          local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_sholium_adeck2' })
                          if joker_card then
                              
                              
                          end
                          
                          return true
                      end
                  }))
                local created_joker = true
                  G.E_MANAGER:add_event(Event({
                      func = function()
                          local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_sholium_adeck3' })
                          if joker_card then
                              
                              
                          end
                          
                          return true
                      end
                  }))
                local created_joker = true
                  G.E_MANAGER:add_event(Event({
                      func = function()
                          local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_sholium_adeck4' })
                          if joker_card then
                              
                              
                          end
                          
                          return true
                      end
                  }))
                local created_joker = true
                  G.E_MANAGER:add_event(Event({
                      func = function()
                          local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_sholium_adeck5' })
                          if joker_card then
                              
                              
                          end
                          
                          return true
                      end
                  }))
                local created_joker = true
                  G.E_MANAGER:add_event(Event({
                      func = function()
                          local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_sholium_adeck6' })
                          if joker_card then
                              
                              
                          end
                          
                          return true
                      end
                  }))
                local created_joker = true
                  G.E_MANAGER:add_event(Event({
                      func = function()
                          local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_sholium_adeck7' })
                          if joker_card then
                              
                              
                          end
                          
                          return true
                      end
                  }))
                local created_joker = true
                  G.E_MANAGER:add_event(Event({
                      func = function()
                          local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_sholium_adeck8' })
                          if joker_card then
                              
                              
                          end
                          
                          return true
                      end
                  }))
                local created_joker = true
                  G.E_MANAGER:add_event(Event({
                      func = function()
                          local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_sholium_adeck9' })
                          if joker_card then
                              
                              
                          end
                          
                          return true
                      end
                  }))
                local created_joker = true
                  G.E_MANAGER:add_event(Event({
                      func = function()
                          local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_sholium_adecka' })
                          if joker_card then
                              
                              
                          end
                          
                          return true
                      end
                  }))
                local created_joker = true
                  G.E_MANAGER:add_event(Event({
                      func = function()
                          local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_sholium_adeckb' })
                          if joker_card then
                              
                              
                          end
                          
                          return true
                      end
                  }))
                local created_joker = true
                  G.E_MANAGER:add_event(Event({
                      func = function()
                          local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_sholium_adeckc' })
                          if joker_card then
                              
                              
                          end
                          
                          return true
                      end
                  }))
                local created_joker = true
                  G.E_MANAGER:add_event(Event({
                      func = function()
                          local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_sholium_adeckd' })
                          if joker_card then
                              
                              
                          end
                          
                          return true
                      end
                  }))
                local created_joker = true
                  G.E_MANAGER:add_event(Event({
                      func = function()
                          local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_sholium_adecke' })
                          if joker_card then
                              
                              
                          end
                          
                          return true
                      end
                  }))
                local created_joker = true
                  G.E_MANAGER:add_event(Event({
                      func = function()
                          local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_sholium_adeckp' })
                          if joker_card then
                              
                              
                          end
                          
                          return true
                      end
                  }))
                return {
                    message = created_joker and localize('k_plus_joker') or nil,
                    extra = {
                        message = created_joker and localize('k_plus_joker') or nil,
                        colour = G.C.BLUE,
                        extra = {
                            message = created_joker and localize('k_plus_joker') or nil,
                            colour = G.C.BLUE,
                        extra = {
                            message = created_joker and localize('k_plus_joker') or nil,
                            colour = G.C.BLUE,
                        extra = {
                            message = created_joker and localize('k_plus_joker') or nil,
                            colour = G.C.BLUE,
                        extra = {
                            message = created_joker and localize('k_plus_joker') or nil,
                            colour = G.C.BLUE,
                        extra = {
                            message = created_joker and localize('k_plus_joker') or nil,
                            colour = G.C.BLUE,
                        extra = {
                            message = created_joker and localize('k_plus_joker') or nil,
                            colour = G.C.BLUE,
                        extra = {
                            message = created_joker and localize('k_plus_joker') or nil,
                            colour = G.C.BLUE,
                        extra = {
                            message = created_joker and localize('k_plus_joker') or nil,
                            colour = G.C.BLUE,
                        extra = {
                            message = created_joker and localize('k_plus_joker') or nil,
                            colour = G.C.BLUE,
                        extra = {
                            message = created_joker and localize('k_plus_joker') or nil,
                            colour = G.C.BLUE,
                        extra = {
                            message = created_joker and localize('k_plus_joker') or nil,
                            colour = G.C.BLUE,
                        extra = {
                            message = created_joker and localize('k_plus_joker') or nil,
                            colour = G.C.BLUE,
                        extra = {
                            message = created_joker and localize('k_plus_joker') or nil,
                            colour = G.C.BLUE
                        }
                        }
                        }
                        }
                        }
                        }
                        }
                        }
                        }
                        }
                        }
                        }
                        }
                        }
                }
        end
    end
}