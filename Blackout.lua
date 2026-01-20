--[[
Blackout
Author: Lxtus & ChatGPT
License: GNU General Public License v3.0 (GPL-3.0)
GitHub: https://github.com/VX-Lo/blackout
Download: https://www.curseforge.com/wow/addons/blackout

Description:
A lightweight addon that toggles a full-screen black overlay
with /blackout for immersion, roleplay, cinematic transitions,
or whenever you want to hide the rest of your interface.

─────────────
Copyright (C) 2026 Lxtus

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
─────────────
]]

local addonName = ...
local frame = CreateFrame("Frame")

-- Create black overlay frame (hidden by default)
local blackout = CreateFrame("Frame", "BlackoutOverlay", UIParent)
blackout:SetFrameStrata("MEDIUM") -- same as WeakAura's medium layer
blackout:SetFrameLevel(0)
blackout:SetAllPoints(UIParent)

local tex = blackout:CreateTexture(nil, "BACKGROUND")
tex:SetColorTexture(0, 0, 0, 1) -- solid black
tex:SetAllPoints(blackout)

-- Make it completely non-interactive
blackout:EnableMouse(false)
blackout:Hide()

-- Saved variable helper
local function SetBlackoutState(enabled)
    if enabled then
        blackout:Show()
    else
        blackout:Hide()
    end
    BlackoutEnabled = enabled
end

-- Slash command definition
SLASH_BLACKOUT1 = "/blackout"

SlashCmdList["BLACKOUT"] = function()
    local newState = not BlackoutEnabled
    SetBlackoutState(newState)
    if newState then
        print("|cff808080[Blackout]|r Screen is now |cff00ff00blacked out|r.")
    else
        print("|cff808080[Blackout]|r Blackout |cffff0000disabled|r.")
    end
end

-- Initialize on load
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_LOGIN")

frame:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" and arg1 == addonName then
        if BlackoutEnabled == nil then
            BlackoutEnabled = false
        end
        SetBlackoutState(BlackoutEnabled)
    elseif event == "PLAYER_LOGIN" then
        SetBlackoutState(BlackoutEnabled)
    end
end)
