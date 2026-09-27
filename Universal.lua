-- Universal POTENTE | jean13d9wxj FIXED
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local LP = Players.LocalPlayer

local T = {InfiniteJump=false, Speed=false, AntiRagdoll=false, Noclip=false, ESP=false}
local debounce = false

UIS.JumpRequest:Connect(function()
    if T.InfiniteJump and not debounce then
        debounce = true
        local h = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
        if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
        task.wait(0.2) debounce = false
    end
end)

task.spawn(function()
    while true do
        task.wait(0.2)
        local c = LP.Character
        if c and T.AntiRagdoll then
            local h = c:FindFirstChildOfClass("Humanoid")
            if h then
                h:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
                h:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
                h:ChangeState(Enum.HumanoidStateType.GettingUp)
                for _,v in pairs(c:GetDescendants()) do
                    if v:IsA("BallSocketConstraint") then
                        v:Destroy()
                    end
                end
            end
        end
    end
end)
RS.Stepped:Connect(function()
    local c = LP.Character
    if not c then return end
    local h = c:FindFirstChildOfClass("Humanoid")
    local hrp = c:FindFirstChild("HumanoidRootPart")
    if T.Noclip and hrp then
        for _,v in pairs(c:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
    if h then h.WalkSpeed = T.Speed and 32 or 16 end
end)

local function tpBase()
    local c = LP.Character
    local hrp = c and c:FindFirstChild("HumanoidRootPart")
    if hrp then hrp.CFrame = hrp.CFrame + Vector3.new(0,0,-50) end
end

local gui = Instance.new("ScreenGui", LP:WaitForChild("PlayerGui"))
local y = 10
local function mkBtn(txt, cb)
    local b = Instance.new("TextButton", gui)
    b.Size = UDim2.new(0,180,0,32)
    b.Position = UDim2.new(0,10,0,y)
    b.Text = txt
    y = y + 36
    b.MouseButton1Click:Connect(cb)
    return b
end

for k,_ in pairs(T) do
    local b = mkBtn(k..": OFF", function() end)
    b.MouseButton1Click:Connect(function()
        T[k] = not T[k]
        b.Text = k..": "..(T[k] and "ON" or "OFF")
    end)
end

mkBtn("TP TO BASE", tpBase)
