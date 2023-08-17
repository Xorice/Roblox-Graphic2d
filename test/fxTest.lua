-- * This script should be place under StartPlayerScript

----------------------------------------
-- # ROBLOX APIs
local Players = game:GetService "Players";
local ReplicatedStorage = game:GetService "ReplicatedStorage";
local RunService = game:GetService "RunService"

----------------------------------------
-- # LIBRARY
local Graphic2d = require(ReplicatedStorage:WaitForChild "Graphic2d")

-- * make sure the playergui was loaded
while not Players.LocalPlayer:FindFirstChild "PlayerGui" do
	task.wait()
end

-- * Create a ScreenGui as a base path
local UI = Instance.new "ScreenGui";
UI.ResetOnSpawn = false;
UI.IgnoreGuiInset = true;

UI.Parent = game:GetService "Players".LocalPlayer.PlayerGui;

local Graphic = Graphic2d.new(UI);

local function draw()
	Graphic:SetCanvas()

	local t = os.clock()
	local pos = UDim2.fromScale(math.cos(t)*0.1 + 0.5, math.sin(t)*0.1 + 0.5);
	local pos2 = UDim2.fromOffset(math.cos(t)*10, math.sin(t)*10)

	local canvas1 = Graphic:Draw "Frame"
		:SetProperties {
			AnchorPoint = Vector2.new(0.5, 0.5);
			Position = UDim2.fromScale(0.5, 0.5);
			Size = UDim2.fromScale(0.5,0.5);
			BackgroundTransparency = 0.5
		};

	local canvas2 = Graphic:SetCanvas(canvas1)
		:Draw "TextLabel"
		:SetProperties {
			AnchorPoint = Vector2.new(0.5, 0.5);
			Position = pos;
			Text = "Hello Graphic2d!";
			
			Rotation = 0; -- initialize
		}

	for i = 1, 10 do
		canvas2 = canvas2:RenderTo "TextLabel"
			:SetProperties {
				AnchorPoint = Vector2.new(0.5, 0.5);
				Position = pos2;
				Text = "Hello Graphic2d!";
				Rotation = os.clock()*10;
			}
	end

	canvas1:RenderTo "Frame"
		:SetProperties {
			Size = UDim2.fromScale(0.4,0.4);
			
			AnchorPoint = Vector2.new(0, 0); -- initialize
			Position = UDim2.fromScale(0, 0); -- initialize
			BackgroundTransparency = 0.0; -- initialize
		}

	Graphic:pop()
end

RunService.RenderStepped:Connect(draw)