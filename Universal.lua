-- Universal POTENTE | jean13d9wxj
local Players=game:GetService("Players") local UIS=game:GetService("UserInputService") local RS=game:GetService("RunService")
local LP=Players.LocalPlayer local debounce=false
local T={InfiniteJump=false,SpeedOnSteal=false,AntiRagdoll=false,Noclip=false,ESP=false}
-- Infinite Jump alto
UIS.JumpRequest:Connect(function()
if T.InfiniteJump and not debounce then debounce=true
local h=LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
if h and h.Health>0 then h.JumpPower=100 h:ChangeState(Enum.HumanoidStateType.Jumping) end
task.wait(0.15) debounce=false end end)
-- Anti Ragdoll + Speed + Noclip loop
RS.Stepped:Connect(function()
local c=LP.Character if not c then return end local h=c:FindFirstChildOfClass("Humanoid")
if T.Noclip then for _,v in pairs(c:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide=false end end end
if h then h.WalkSpeed=T.SpeedOnSteal and 32 or 16 end
if T.AntiRagdoll then for _,v in pairs(c:GetDescendants()) do if v.Name=="Ragdoll" or v.Name=="Ragdolled" then v:Destroy() end end
if h then h.PlatformStand=false end end
end)
-- TP A TU BASE
local function tpBase()
local c=LP.Character local hrp=c and c:FindFirstChild("HumanoidRootPart")
if hrp then -- busca tu base por el plot tuyo
for _,p in pairs(workspace:GetDescendants()) do if p.Name=="Owner" and p.Value==LP.Name then
local base=p.Parent:FindFirstChild("Spawn") or p.Parent:FindFirstChildWhichIsA("BasePart")
if base then hrp.CFrame=base.CFrame+Vector3.new(0,5,0) break end end end end
-- ESP simple
local function toggleESP(on)
for _,plr in pairs(Players:GetPlayers()) do if plr~=LP and plr.Character then
local hl=plr.Character:FindFirstChild("ESP_HL")
if on and not hl then local h=Instance.new("Highlight",plr.Character) h.Name="ESP_HL" h.FillColor=Color3.new(1,0,0)
elseif not on and hl then hl:Destroy() end end end end
-- GUI
local gui=Instance.new("ScreenGui",LP:WaitForChild("PlayerGui")) local y=10
local function btn(txt,fn) local b=Instance.new("TextButton",gui) b.Size=UDim2.new(0,180,0,30) b.Position=UDim2.new(0,10,0,y) b.Text=txt y=y+35 return b,fn end
for n,_ in pairs(T) do local b=btn(n..": OFF") b.MouseButton1Click:Connect(function() T[n]=not T[n] b.Text=n..": "..(T[n] and "ON" or "OFF") if n=="ESP" then toggleESP(T[n]) end end) end
local tb=btn("TP TO BASE") tb.MouseButton1Click:Connect(tpBase)
