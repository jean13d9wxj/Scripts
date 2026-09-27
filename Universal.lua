-- Universal FIXED | jean13d9wxj
local Players=game:GetService("Players")
local UIS=game:GetService("UserInputService")
local LP=Players.LocalPlayer
local debounce=false
local T={InfiniteJump=false,Noclip=false,AntiRagdoll=false,SpeedOnSteal=false}
UIS.JumpRequest:Connect(function()
if T.InfiniteJump and not debounce then
debounce=true
local h=LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
if h and h.Health>0 then h:ChangeState(Enum.HumanoidStateType.Jumping) end
task.wait(0.2) debounce=false end end)
game:GetService("RunService").Stepped:Connect(function()
local c=LP.Character if not c then return end
local h=c:FindFirstChildOfClass("Humanoid")
if T.Noclip then for _,v in pairs(c:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide=false end end end
if h then h.WalkSpeed=T.SpeedOnSteal and 32 or 16 end end)
local gui=Instance.new("ScreenGui",LP:WaitForChild("PlayerGui"))
local y=10 for n,_ in pairs(T) do
local b=Instance.new("TextButton",gui)
b.Size=UDim2.new(0,180,0,30) b.Position=UDim2.new(0,10,0,y)
b.Text=n..": OFF"
b.MouseButton1Click:Connect(function() T[n]=not T[n] b.Text=n..": "..(T[n] and "ON" or "OFF") end)
y=y+35 end
