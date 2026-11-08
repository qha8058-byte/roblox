-- PART 1: SETUP + GUI HEADER
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("ReplicatedStorage")
local LP = Players.LocalPlayer

local Remotes = RS:FindFirstChild("Remotes")
local DataFolder = RS:FindFirstChild("Data")

_G.FarmAuto = false
_G.FarmSkill = false
_G.FarmRange = 50
_G.RollAuto = false
_G.RollDelay = 0.15
_G.RollStopRare = false
_G.ESP = false
_G.BossESP = false
_G.Sprint = false
_G.Speed = false
_G.SpeedVal = 60
_G.Jump = false
_G.JumpVal = 100
_G.Noclip = false
_G.Fullbright = false
_G.AutoCollect = false
_G.AutoM1 = false

local function fire(name, ...)
    if not Remotes then return end
    local r = Remotes:FindFirstChild(name)
    if r and (r:IsA("RemoteEvent") or r:IsA("RemoteFunction")) then
        pcall(function() r:FireServer(...) end)
    end
end

local function getData()
    if not DataFolder then return nil end
    return DataFolder:FindFirstChild(tostring(LP.UserId))
end

local SG = Instance.new("ScreenGui")
SG.Name = "QuyetHub"
SG.Parent = game:GetService("CoreGui")
SG.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
SG.ResetOnSpawn = false

local ToggleIcon = Instance.new("TextButton")
ToggleIcon.Parent = SG
ToggleIcon.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
ToggleIcon.BorderSizePixel = 0
ToggleIcon.Position = UDim2.new(0, 15, 0, 15)
ToggleIcon.Size = UDim2.new(0, 44, 0, 44)
ToggleIcon.Font = Enum.Font.GothamBold
ToggleIcon.Text = "😈"
ToggleIcon.TextColor3 = Color3.fromRGB(0, 255, 150)
ToggleIcon.TextSize = 20
ToggleIcon.Visible = false
Instance.new("UICorner", ToggleIcon).CornerRadius = UDim.new(0, 10)
local TIS = Instance.new("UIStroke", ToggleIcon)
TIS.Color = Color3.fromRGB(0, 255, 150)

local Main = Instance.new("Frame")
Main.Parent = SG
Main.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0, 15, 0, 15)
Main.Size = UDim2.new(0, 260, 0, 380)
Main.ClipsDescendants = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
local MS = Instance.new("UIStroke", Main)
MS.Color = Color3.fromRGB(0, 255, 150)
MS.Thickness = 1.5

local Header = Instance.new("Frame")
Header.Parent = Main
Header.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
Header.BorderSizePixel = 0
Header.Size = UDim2.new(1, 0, 0, 42)
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 10)

local Logo = Instance.new("TextLabel")
Logo.Parent = Header
Logo.BackgroundTransparency = 1
Logo.Position = UDim2.new(0, 10, 0, 0)
Logo.Size = UDim2.new(0, 26, 1, 0)
Logo.Font = Enum.Font.GothamBold
Logo.Text = "😈"
Logo.TextColor3 = Color3.fromRGB(0, 255, 150)
Logo.TextSize = 18
Logo.TextXAlignment = Enum.TextXAlignment.Left

local Title = Instance.new("TextLabel")
Title.Parent = Header
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 38, 0, 0)
Title.Size = UDim2.new(0, 130, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "Quyet Hub"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 13
Title.TextXAlignment = Enum.TextXAlignment.Left
local SubTitle = Instance.new("TextLabel")
SubTitle.Parent = Header
SubTitle.BackgroundTransparency = 1
SubTitle.Position = UDim2.new(0, 38, 0, 6)
SubTitle.Size = UDim2.new(0, 130, 1, 0)
SubTitle.Font = Enum.Font.Gotham
SubTitle.Text = "v8 Loaded"
SubTitle.TextColor3 = Color3.fromRGB(140, 140, 150)
SubTitle.TextSize = 8
SubTitle.TextXAlignment = Enum.TextXAlignment.Left

local MinBtn = Instance.new("TextButton")
MinBtn.Parent = Header
MinBtn.BackgroundColor3 = Color3.fromRGB(38, 38, 48)
MinBtn.BorderSizePixel = 0
MinBtn.Position = UDim2.new(1, -60, 0, 11)
MinBtn.Size = UDim2.new(0, 22, 0, 22)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.Text = "−"
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.TextSize = 14
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 5)

local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = Header
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
CloseBtn.BorderSizePixel = 0
CloseBtn.Position = UDim2.new(1, -32, 0, 11)
CloseBtn.Size = UDim2.new(0, 22, 0, 22)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "×"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 14
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 5)

local TabBar = Instance.new("Frame")
TabBar.Parent = Main
TabBar.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
TabBar.BorderSizePixel = 0
TabBar.Position = UDim2.new(0, 8, 0, 48)
TabBar.Size = UDim2.new(1, -16, 0, 28)
Instance.new("UICorner", TabBar).CornerRadius = UDim.new(0, 6)

local function makeTab(name, x, w)
    local t = Instance.new("TextButton")
    t.Parent = TabBar
    t.BackgroundColor3 = Color3.fromRGB(38, 38, 48)
    t.BorderSizePixel = 0
    t.Position = UDim2.new(0, x, 0, 3)
    t.Size = UDim2.new(0, w, 0, 22)
    t.Font = Enum.Font.GothamBold
    t.Text = name
    t.TextColor3 = Color3.fromRGB(140, 140, 150)
    t.TextSize = 9
    Instance.new("UICorner", t).CornerRadius = UDim.new(0, 4)
    return t
end

local TabFarm = makeTab("Farm", 3, 58)
local TabRoll = makeTab("Roll", 63, 58)
local TabMove = makeTab("Move", 123, 58)
local TabVis = makeTab("Vis", 183, 58)

local Content = Instance.new("ScrollingFrame")
Content.Parent = Main
Content.BackgroundTransparency = 1
Content.BorderSizePixel = 0
Content.Position = UDim2.new(0, 8, 0, 82)
Content.Size = UDim2.new(1, -16, 1, -120)
Content.CanvasSize = UDim2.new(0, 0, 0, 0)
Content.ScrollBarThickness = 3
Content.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 150)
local StatsBar = Instance.new("Frame")
StatsBar.Parent = Main
StatsBar.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
StatsBar.BorderSizePixel = 0
StatsBar.Position = UDim2.new(0, 8, 1, -34)
StatsBar.Size = UDim2.new(1, -16, 0, 28)
Instance.new("UICorner", StatsBar).CornerRadius = UDim.new(0, 6)

local StatsLbl = Instance.new("TextLabel")
StatsLbl.Parent = StatsBar
StatsLbl.BackgroundTransparency = 1
StatsLbl.Size = UDim2.new(1, -10, 1, 0)
StatsLbl.Position = UDim2.new(0, 5, 0, 0)
StatsLbl.Font = Enum.Font.GothamBold
StatsLbl.Text = "Loading..."
StatsLbl.TextColor3 = Color3.fromRGB(0, 255, 150)
StatsLbl.TextSize = 9
StatsLbl.TextXAlignment = Enum.TextXAlignment.Left

local function makePage()
    local p = Instance.new("Frame")
    p.Parent = Content
    p.BackgroundTransparency = 1
    p.Size = UDim2.new(1, 0, 0, 320)
    p.Visible = false
    return p
end

local FarmPage = makePage()
local RollPage = makePage()
local MovePage = makePage()
local VisPage = makePage()

local function makeSection(parent, y, icon, title, color)
    local sec = Instance.new("Frame")
    sec.Parent = parent
    sec.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
    sec.BorderSizePixel = 0
    sec.Position = UDim2.new(0, 0, 0, y)
    sec.Size = UDim2.new(1, 0, 0, 48)
    Instance.new("UICorner", sec).CornerRadius = UDim.new(0, 6)
    local h = Instance.new("TextLabel")
    h.Parent = sec
    h.BackgroundTransparency = 1
    h.Position = UDim2.new(0, 10, 0, 4)
    h.Size = UDim2.new(1, -20, 0, 14)
    h.Font = Enum.Font.GothamBold
    h.Text = icon .. " " .. title
    h.TextColor3 = color
    h.TextSize = 9
    h.TextXAlignment = Enum.TextXAlignment.Left
    return sec
end

local function makeToggle(parent, y, text)
    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.BackgroundColor3 = Color3.fromRGB(38, 38, 48)
    btn.BorderSizePixel = 0
    btn.Position = UDim2.new(0, 8, 0, y)
    btn.Size = UDim2.new(1, -16, 0, 22)
    btn.Font = Enum.Font.GothamBold
    btn.Text = text .. ": OFF"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 10
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
    return btn
end

local function makeInput(parent, x, y, w, default)
    local b = Instance.new("TextBox")
    b.Parent = parent
    b.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
    b.BorderSizePixel = 0
    b.Position = UDim2.new(0, x, 0, y)
    b.Size = UDim2.new(0, w, 0, 22)
    b.Font = Enum.Font.Gotham
    b.Text = default
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.TextSize = 10
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 4)
    return b
end

local function toggleUI(btn, state, name, onColor)
    btn.Text = name .. ": " .. (state and "ON" or "OFF")
    btn.BackgroundColor3 = state and (onColor or Color3.fromRGB(0, 180, 100)) or Color3.fromRGB(38, 38, 48)
end
-- FARM PAGE
local FarmSec = makeSection(FarmPage, 0, "F", "AUTO FARM", Color3.fromRGB(255, 60, 60))
local FarmBtn = makeToggle(FarmSec, 22, "AUTO FARM")
local SkillSec = makeSection(FarmPage, 52, "S", "AUTO SKILL", Color3.fromRGB(255, 200, 0))
local SkillBtn = makeToggle(SkillSec, 22, "AUTO SKILL")
local M1Sec = makeSection(FarmPage, 104, "M", "AUTO M1", Color3.fromRGB(255, 100, 200))
local M1Btn = makeToggle(M1Sec, 22, "AUTO M1")
local CollectSec = makeSection(FarmPage, 156, "C", "AUTO COLLECT", Color3.fromRGB(0, 255, 150))
local CollectBtn = makeToggle(CollectSec, 22, "COLLECT")

-- ROLL PAGE
local RollSec = makeSection(RollPage, 0, "R", "AUTO ROLL", Color3.fromRGB(255, 200, 0))
local RollBtn = makeToggle(RollSec, 22, "AUTO ROLL")
local StopSec = makeSection(RollPage, 52, "S", "STOP RARE+", Color3.fromRGB(180, 100, 255))
local StopBtn = makeToggle(StopSec, 22, "STOP RARE")

-- MOVE PAGE
local SprintSec = makeSection(MovePage, 0, "SP", "SPRINT", Color3.fromRGB(0, 255, 150))
local SprintBtn = makeToggle(SprintSec, 22, "SPRINT")
local SpeedSec = makeSection(MovePage, 52, "SP", "SPEED", Color3.fromRGB(255, 200, 0))
local SpeedInput = makeInput(SpeedSec, 8, 22, 100, "60")
local SpeedBtn = Instance.new("TextButton")
SpeedBtn.Parent = SpeedSec
SpeedBtn.BackgroundColor3 = Color3.fromRGB(38, 38, 48)
SpeedBtn.BorderSizePixel = 0
SpeedBtn.Position = UDim2.new(0, 114, 0, 22)
SpeedBtn.Size = UDim2.new(0, 120, 0, 22)
SpeedBtn.Font = Enum.Font.GothamBold
SpeedBtn.Text = "SPEED: OFF"
SpeedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedBtn.TextSize = 10
Instance.new("UICorner", SpeedBtn).CornerRadius = UDim.new(0, 4)
local JumpSec = makeSection(MovePage, 104, "J", "JUMP", Color3.fromRGB(0, 150, 255))
local JumpInput = makeInput(JumpSec, 8, 22, 100, "100")
local JumpBtn = Instance.new("TextButton")
JumpBtn.Parent = JumpSec
JumpBtn.BackgroundColor3 = Color3.fromRGB(38, 38, 48)
JumpBtn.BorderSizePixel = 0
JumpBtn.Position = UDim2.new(0, 114, 0, 22)
JumpBtn.Size = UDim2.new(0, 120, 0, 22)
JumpBtn.Font = Enum.Font.GothamBold
JumpBtn.Text = "JUMP: OFF"
JumpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
JumpBtn.TextSize = 10
Instance.new("UICorner", JumpBtn).CornerRadius = UDim.new(0, 4)
local NoclipSec = makeSection(MovePage, 156, "N", "NOCLIP", Color3.fromRGB(180, 100, 255))
local NoclipBtn = makeToggle(NoclipSec, 22, "NOCLIP")

-- VIS PAGE
local ESPSec = makeSection(VisPage, 0, "E", "MONSTER ESP", Color3.fromRGB(255, 60, 60))
local ESPBtn = makeToggle(ESPSec, 22, "ESP")
local BossSec = makeSection(VisPage, 52, "B", "BOSS ESP", Color3.fromRGB(255, 150, 0))
local BossBtn = makeToggle(BossSec, 22, "BOSS ESP")
local BrightSec = makeSection(VisPage, 104, "F", "FULLBRIGHT", Color3.fromRGB(255, 200, 0))
local BrightBtn = makeToggle(BrightSec, 22, "FULLBRIGHT")
local FogSec = makeSection(VisPage, 156, "N", "NO FOG", Color3.fromRGB(0, 150, 255))
local FogBtn = makeToggle(FogSec, 22, "NO FOG")

-- TAB SWITCH
local function switchTab(active, page)
    for _, t in ipairs({TabFarm, TabRoll, TabMove, TabVis}) do
        t.BackgroundColor3 = Color3.fromRGB(38, 38, 48)
        t.TextColor3 = Color3.fromRGB(140, 140, 150)
    end
    for _, p in ipairs({FarmPage, RollPage, MovePage, VisPage}) do
        p.Visible = false
    end
    active.BackgroundColor3 = Color3.fromRGB(0, 180, 100)
    active.TextColor3 = Color3.fromRGB(255, 255, 255)
    page.Visible = true
end

TabFarm.MouseButton1Click:Connect(function() switchTab(TabFarm, FarmPage) end)
TabRoll.MouseButton1Click:Connect(function() switchTab(TabRoll, RollPage) end)
TabMove.MouseButton1Click:Connect(function() switchTab(TabMove, MovePage) end)
TabVis.MouseButton1Click:Connect(function() switchTab(TabVis, VisPage) end)
switchTab(TabFarm, FarmPage)
-- DRAG
local dragging, dragStart, startPos
Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
UIS.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local d = input.Position - dragStart
        Main.Position = UDim2.new(0, math.clamp(startPos.X.Offset + d.X, -200, workspace.CurrentCamera.ViewportSize.X - 60), 0, math.clamp(startPos.Y.Offset + d.Y, 0, workspace.CurrentCamera.ViewportSize.Y - 60))
    end
end)

local isMin = false
MinBtn.MouseButton1Click:Connect(function()
    isMin = not isMin
    if isMin then
        Main:TweenSize(UDim2.new(0, 260, 0, 42), "Out", "Quad", 0.25, true)
        MinBtn.Text = "+"
    else
        Main:TweenSize(UDim2.new(0, 260, 0, 380), "Out", "Quad", 0.25, true)
        MinBtn.Text = "−"
    end
end)
CloseBtn.MouseButton1Click:Connect(function()
    Main.Visible = false
    ToggleIcon.Visible = true
    ToggleIcon.Position = Main.Position
end)
ToggleIcon.MouseButton1Click:Connect(function()
    Main.Visible = true
    ToggleIcon.Visible = false
end)

-- MONSTER DETECTION
local monsterNames = {
    common = true, uncommon = true, rare = true, epic = true, legendary = true,
    mythical = true, coin = true, lucky = true, golden = true, aquatic = true,
    tornado = true, lightning = true, inflame = true, ["shadow ant king"] = true,
    ruthless = true, judgment = true, ["shadow vermillion"] = true
}
local bossNames = {
    judgment = true, ["shadow vermillion"] = true, ["shadow ant king"] = true,
    ruthless = true, mythical = true
}
local function isMonster(obj)
    if not obj:IsA("Model") then return false end
    if not obj:FindFirstChildOfClass("Humanoid") then return false end
    if obj == LP.Character then return false end
    if Players:GetPlayerFromCharacter(obj) then return false end
    return monsterNames[obj.Name:lower()] or false
end
local function isBoss(obj)
    return bossNames[obj.Name:lower()] or false
end

local function updateESP()
    for _, v in ipairs(workspace:GetDescendants()) do
        if isMonster(v) then
            local hum = v:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                local boss = isBoss(v)
                if _G.ESP or (boss and _G.BossESP) then
                    local hl = v:FindFirstChild("QuyetESP")
                    if not hl then
                        hl = Instance.new("Highlight")
                        hl.Name = "QuyetESP"
                        hl.FillTransparency = 0.65
                        hl.OutlineTransparency = 0.1
                        hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        hl.Parent = v
                    end
                    hl.FillColor = boss and Color3.fromRGB(255, 60, 0) or Color3.fromRGB(255, 60, 60)
                    hl.OutlineColor = boss and Color3.fromRGB(255, 200, 0) or Color3.fromRGB(255, 255, 255)
                else
                    local hl = v:FindFirstChild("QuyetESP")
                    if hl then hl:Destroy() end
                end
            end
        end
    end
-- BUTTON HANDLERS
FarmBtn.MouseButton1Click:Connect(function()
    _G.FarmAuto = not _G.FarmAuto
    toggleUI(FarmBtn, _G.FarmAuto, "AUTO FARM", Color3.fromRGB(200, 30, 30))
end)
SkillBtn.MouseButton1Click:Connect(function()
    _G.FarmSkill = not _G.FarmSkill
    toggleUI(SkillBtn, _G.FarmSkill, "AUTO SKILL", Color3.fromRGB(200, 150, 0))
end)
M1Btn.MouseButton1Click:Connect(function()
    _G.AutoM1 = not _G.AutoM1
    toggleUI(M1Btn, _G.AutoM1, "AUTO M1", Color3.fromRGB(200, 50, 150))
end)
CollectBtn.MouseButton1Click:Connect(function()
    _G.AutoCollect = not _G.AutoCollect
    toggleUI(CollectBtn, _G.AutoCollect, "COLLECT")
end)
RollBtn.MouseButton1Click:Connect(function()
    _G.RollAuto = not _G.RollAuto
    toggleUI(RollBtn, _G.RollAuto, "AUTO ROLL", Color3.fromRGB(200, 150, 0))
end)
StopBtn.MouseButton1Click:Connect(function()
    _G.RollStopRare = not _G.RollStopRare
    toggleUI(StopBtn, _G.RollStopRare, "STOP RARE", Color3.fromRGB(150, 80, 220))
end)
SprintBtn.MouseButton1Click:Connect(function()
    _G.Sprint = not _G.Sprint
    toggleUI(SprintBtn, _G.Sprint, "SPRINT")
    pcall(function() fire("SprintToggle", _G.Sprint) end)
end)
SpeedBtn.MouseButton1Click:Connect(function()
    _G.Speed = not _G.Speed
    local v = tonumber(SpeedInput.Text)
    if v then _G.SpeedVal = v end
    toggleUI(SpeedBtn, _G.Speed, "SPEED")
end)
JumpBtn.MouseButton1Click:Connect(function()
    _G.Jump = not _G.Jump
    local v = tonumber(JumpInput.Text)
    if v then _G.JumpVal = v end
    toggleUI(JumpBtn, _G.Jump, "JUMP")
end)
NoclipBtn.MouseButton1Click:Connect(function()
    _G.Noclip = not _G.Noclip
    toggleUI(NoclipBtn, _G.Noclip, "NOCLIP", Color3.fromRGB(150, 80, 220))
end)
ESPBtn.MouseButton1Click:Connect(function()
    _G.ESP = not _G.ESP
    toggleUI(ESPBtn, _G.ESP, "ESP", Color3.fromRGB(200, 30, 30))
end)
BossBtn.MouseButton1Click:Connect(function()
    _G.BossESP = not _G.BossESP
    toggleUI(BossBtn, _G.BossESP, "BOSS ESP", Color3.fromRGB(200, 100, 0))
end)
BrightBtn.MouseButton1Click:Connect(function()
    _G.Fullbright = not _G.Fullbright
    toggleUI(BrightBtn, _G.Fullbright, "FULLBRIGHT", Color3.fromRGB(200, 150, 0))
    pcall(function()
        game.Lighting.Brightness = _G.Fullbright and 5 or 2
    end)
end)
FogBtn.MouseButton1Click:Connect(function()
    if not FogBtn:GetAttribute("On") then
        FogBtn:SetAttribute("On", true)
        toggleUI(FogBtn, true, "NO FOG", Color3.fromRGB(0, 100, 200))
        pcall(function() game.Lighting.FogEnd = 1e6; game.Lighting.FogStart = 1e6 end)
    else
        FogBtn:SetAttribute("On", false)
        toggleUI(FogBtn, false, "NO FOG")
        pcall(function() game.Lighting.FogEnd = 1000; game.Lighting.FogStart = 0 end)
    end
end)

-- MAIN LOOP
local rollT, skillT, m1T = 0, 0, 0
RunService.Heartbeat:Connect(function(dt)
    pcall(function()
        local char = LP.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hum or not hrp then return end
        if _G.Speed then hum.WalkSpeed = _G.SpeedVal end
        if _G.Jump then hum.UseJumpPower = true; hum.JumpPower = _G.JumpVal end
        if _G.Noclip then
            for _, v in ipairs(char:GetDescendants()) do
                if v:IsA("BasePart") then v.CanCollide = false end
            end
        end
        if _G.ESP or _G.BossESP then updateESP() end
        if _G.FarmAuto then
            local nearest, short = nil, _G.FarmRange
            for _, v in ipairs(workspace:GetDescendants()) do
                if isMonster(v) then
                    local mh = v:FindFirstChildOfClass("Humanoid")
                    if mh and mh.Health > 0 then
                        local mhrp = v:FindFirstChild("HumanoidRootPart")
                        if mhrp then
                            local dist = (mhrp.Position - hrp.Position).Magnitude
                            if dist < short then short = dist; nearest = mhrp end
                        end
                    end
                end
            end
            if nearest and short > 6 then hrp.CFrame = nearest.CFrame * CFrame.new(0, 0, 4) end
        end
        if _G.FarmSkill then
            skillT = skillT + dt
            if skillT >= 0.15 then
                skillT = 0
                fire("SkillAction", "Z")
                fire("SkillAction", "X")
                fire("SkillAction", "C")
            end
        end
        if _G.AutoM1 then
            m1T = m1T + dt
            if m1T >= 0.1 then m1T = 0; fire("M1Action"); fire("M1Effect") end
        end
        if _G.AutoCollect then
            for _, v in ipairs(workspace:GetDescendants()) do
                if v:IsA("ProximityPrompt") and v.Enabled then
                    pcall(function() fireproximityprompt(v) end)
                end
            end
        end
        if _G.RollAuto then
            rollT = rollT + dt
            if rollT >= _G.RollDelay then rollT = 0; fire("RollAction") end
        end
    end)
end)

task.spawn(function()
    while true do
        task.wait(1)
        pcall(function()
            local data = getData()
            if data then
                local lvF = data:FindFirstChild("Level")
                local lvl = lvF and lvF:FindFirstChild("Level")
                local coin = data:FindFirstChild("Coin")
                local roll = data:FindFirstChild("Roll")
                StatsLbl.Text = "Lv." .. (lvl and lvl.Value or "?") .. " | $" .. (coin and coin.Value or "?") .. " | Roll:" .. (roll and roll.Value or "?")
            end
        end)
    end
end)

print("Quyet Hub v8 Loaded!")
end
