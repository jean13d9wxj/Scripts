-- Universal | jean13d9wxj
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LP = Players.LocalPlayer

local T = {
    InstantGrab=false, SpeedOnSteal=false, KickOnSteal=false,
    InfiniteJump=false, Aimbot=false, AntiRagdoll=false,
    XRay=false, Noclip=false
}

UIS.JumpRequest:Connect(function()
    if T.InfiniteJump then
        local h = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
        if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)

RunService.Stepped:Connect(function()
    local c = LP.Character
    if not c then return end
    if T.AntiRagdoll then
        local h = c:FindFirstChildOfClass("Humanoid")
        if h then
            h:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false)
            h:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)
        end
    end
    if T.Noclip then
        for _,v in pairs(c:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide=false end
        end
    end
    if T.SpeedOnSteal then
        local h = c:FindFirstChildOfClass("Humanoid")
        if h then h.WalkSpeed=32 end
    end
end)

local gui = Instance.new("ScreenGui", LP:WaitForChild("PlayerGui"))
gui.Name="Hub"
local y=10
for name,_ in pairs(T) do
    local b=Instance.new("TextButton",gui)
    b.Size=UDim2.new(0,180,0,30)
    b.Position=UDim2.new(0,10,0,y)
    b.Text=name..": OFF"
    b.MouseButton1Click:Connect(function()
        T[name]=not T[name]
        b.Text=name..": "..(T[name] and "ON" or "OFF")
    end)
    y=y+35
end
