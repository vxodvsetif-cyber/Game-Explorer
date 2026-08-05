local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

if CoreGui:FindFirstChild("ExplorerDeltaUltimateV15") then
	CoreGui.ExplorerDeltaUltimateV15:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "ExplorerDeltaUltimateV15"
gui.ResetOnSpawn = false
gui.Parent = CoreGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 560, 0, 350)
frame.Position = UDim2.new(0.5, -280, 0.5, -175)
frame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
frame.BorderSizePixel = 0
frame.ClipsDescendants = true
frame.Parent = gui

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)

local uiScale = Instance.new("UIScale")
uiScale.Parent = frame

frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
	local currentWidth = frame.AbsoluteSize.X
	local scaleFactor = currentWidth / 750
	uiScale.Scale = math.clamp(scaleFactor, 0.75, 1.25)
end)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 28)
title.Text = "    Explorer & Properties Pro (v15.3)"
title.TextColor3 = Color3.fromRGB(220, 220, 220)
title.TextSize = 12
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
title.BorderSizePixel = 0
title.Parent = frame

local dragging, dragStart, startPos
title.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = frame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 28, 0, 28)
closeBtn.Position = UDim2.new(1, -28, 0, 0)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
closeBtn.TextSize = 12
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
closeBtn.BorderSizePixel = 0
closeBtn.Parent = title
closeBtn.MouseButton1Click:Connect(function() gui:Destroy() end)

local minBtn = Instance.new("TextButton")
minBtn.Size = UDim2.new(0, 28, 0, 28)
minBtn.Position = UDim2.new(1, -56, 0, 0)
minBtn.Text = "-"
minBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
minBtn.TextSize = 13
minBtn.Font = Enum.Font.GothamBold
minBtn.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
minBtn.BorderSizePixel = 0
minBtn.Parent = title

local contentContainer = Instance.new("Frame")
contentContainer.Size = UDim2.new(1, 0, 1, -28)
contentContainer.Position = UDim2.new(0, 0, 0, 28)
contentContainer.BackgroundTransparency = 1
contentContainer.Parent = frame

local isMinimized = false
minBtn.MouseButton1Click:Connect(function()
	isMinimized = not isMinimized
	if isMinimized then
		minBtn.Text = "+"
		contentContainer.Visible = false
		frame:TweenSize(UDim2.new(0, frame.AbsoluteSize.X, 0, 28), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
	else
		minBtn.Text = "-"
		frame:TweenSize(UDim2.new(0, frame.AbsoluteSize.X, 0, 350), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
		task.wait(0.15)
		contentContainer.Visible = true
	end
end)

local resizeHandle = Instance.new("TextButton")
resizeHandle.Size = UDim2.new(0, 16, 0, 16)
resizeHandle.Position = UDim2.new(1, -16, 1, -16)
resizeHandle.Text = "◢"
resizeHandle.TextColor3 = Color3.fromRGB(120, 120, 120)
resizeHandle.TextSize = 10
resizeHandle.BackgroundTransparency = 1
resizeHandle.Parent = frame

local resizing = false
local resizeStart, startSize
resizeHandle.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		resizing = true
		resizeStart = input.Position
		startSize = frame.AbsoluteSize
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				resizing = false
			end
		end)
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if resizing and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - resizeStart
		local newW = math.clamp(startSize.X + delta.X, 450, 1920)
		local newH = math.clamp(startSize.Y + delta.Y, 280, 1080)
		frame.Size = UDim2.new(0, newW, 0, newH)
	end
end)

local searchBox = Instance.new("TextBox")
searchBox.Size = UDim2.new(1, -12, 0, 24)
searchBox.Position = UDim2.new(0, 6, 0, 6)
searchBox.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
searchBox.TextColor3 = Color3.fromRGB(220, 220, 220)
searchBox.PlaceholderText = "Search Explorer..."
searchBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
searchBox.TextSize = 12
searchBox.Font = Enum.Font.Gotham
searchBox.ClearTextOnFocus = false
searchBox.BorderSizePixel = 0
searchBox.Parent = contentContainer
Instance.new("UICorner", searchBox).CornerRadius = UDim.new(0, 4)

local function createColumn(xPos, width)
	local scroll = Instance.new("ScrollingFrame")
	scroll.Size = UDim2.new(width, 0, 1, -62)
	scroll.Position = UDim2.new(xPos, 0, 0, 34)
	scroll.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	scroll.BorderSizePixel = 0
	scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
	scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
	scroll.ScrollBarThickness = 5
	scroll.Parent = contentContainer

	local layout = Instance.new("UIListLayout")
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Padding = UDim.new(0, 3)
	layout.Parent = scroll
	return scroll
end

local colExplorer = createColumn(0, 0.28)
local colEditor = createColumn(0.28, 0.44)
local colProperties = createColumn(0.72, 0.28)

local function createDivider(xPos)
	local div = Instance.new("Frame")
	div.Size = UDim2.new(0, 1, 1, -28)
	div.Position = UDim2.new(xPos, 0, 0, 0)
	div.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	div.BorderSizePixel = 0
	div.Parent = contentContainer
end
createDivider(0.28)
createDivider(0.72)

local bottomBar = Instance.new("Frame")
bottomBar.Size = UDim2.new(1, 0, 0, 28)
bottomBar.Position = UDim2.new(0, 0, 1, -28)
bottomBar.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
bottomBar.BorderSizePixel = 0
bottomBar.Parent = contentContainer

local function createBottomButton(xPos, width, text, callback)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(width, -4, 0, 20)
	btn.Position = UDim2.new(xPos, 2, 0.5, -10)
	btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	btn.TextColor3 = Color3.fromRGB(220, 220, 220)
	btn.TextSize = 11
	btn.Font = Enum.Font.GothamBold
	btn.Text = text
	btn.BorderSizePixel = 0
	btn.Parent = bottomBar
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 3)
	btn.MouseButton1Click:Connect(callback)
	return btn
end

local selectedGlobalObject = nil

local function getFullPath(object)
	if not object or object == game then return "game" end
	local parts = {}
	local current = object
	while current and current ~= game do
		local parent = current.Parent
		if parent == game then
			table.insert(parts, 1, string.format('game:GetService("%s")', current.ClassName))
		else
			if current.Name:match("^[%a_][%w_]*$") then
				table.insert(parts, 1, "." .. current.Name)
			else
				table.insert(parts, 1, string.format('["%s"]', current.Name))
			end
		end
		current = parent
	end
	return table.concat(parts)
end

createBottomButton(0, 0.33, "📋 Copy Path", function()
	if selectedGlobalObject then
		pcall(function() setclipboard(getFullPath(selectedGlobalObject)) end)
	end
end)

createBottomButton(0.33, 0.34, "✨ Apply ESP", function()
	if selectedGlobalObject then
		local target = selectedGlobalObject
		pcall(function()
			local descendants = (target:IsA("Model") or target:IsA("Folder")) and target:GetDescendants() or {target}
			for _, obj in ipairs(descendants) do
				if obj:IsA("BasePart") and not obj:FindFirstChild("ExplorerESPBox") then
					local hl = Instance.new("Highlight")
					hl.Name = "ExplorerESPBox"
					hl.Adornee = obj
					hl.FillColor = Color3.fromRGB(255, 50, 50)
					hl.OutlineColor = Color3.fromRGB(255, 255, 255)
					hl.Parent = obj
				end
			end
		end)
	end
end)

local spyActive = false
createBottomButton(0.67, 0.33, "📡 Toggle Spy", function()
	spyActive = not spyActive
end)

local function clearColumn(column)
	for _, child in ipairs(column:GetChildren()) do
		if not child:IsA("UIListLayout") then
			child:Destroy()
		end
	end
end

local showProperties
local showEditor

local function getIconId(obj)
	if obj:IsA("Workspace") then return "rbxassetid://72386107792960"
	elseif obj:IsA("Players") then return "rbxassetid://97316569310298"
	elseif obj:IsA("Lighting") then return "rbxassetid://92657675120068"
	elseif obj:IsA("ReplicatedFirst") then return "rbxassetid://77328857147849"
	elseif obj:IsA("ReplicatedStorage") then return "rbxassetid://116501773412039"
	elseif obj:IsA("ServerScriptService") then return "rbxassetid://99565058012566"
	elseif obj:IsA("ServerStorage") then return "rbxassetid://137609517073409"
	elseif obj:IsA("StarterGui") then return "rbxassetid://115447200870950"
	elseif obj:IsA("StarterPack") then return "rbxassetid://70730745997890"
	elseif obj:IsA("StarterPlayer") then return "rbxassetid://81827178254183"
	elseif obj:IsA("SoundService") then return "rbxassetid://115336328074629"
	elseif obj:IsA("Script") then return "rbxassetid://93674949897735"
	elseif obj:IsA("LocalScript") then return "rbxassetid://106141637847375"
	elseif obj:IsA("ModuleScript") then return "rbxassetid://135641679621448"
	elseif obj:IsA("Folder") then return "rbxassetid://103287739014356"
	elseif obj:IsA("Model") then return "rbxassetid://71563959490893"
	elseif obj:IsA("ScreenGui") then return "rbxassetid://93826980329066"
	elseif obj:IsA("RemoteEvent") then return "rbxassetid://87478552378372"
	elseif obj:IsA("RemoteFunction") then return "rbxassetid://73334522536128"
	elseif obj:IsA("BasePart") then return "rbxassetid://133548230368906"
	end
	return "rbxassetid://103287739014356"
end

local function hasRealChildren(obj)
	local success, children = pcall(function() return obj:GetChildren() end)
	if not success then return false end
	for _, child in ipairs(children) do
		if not (child:IsA("UICorner") or child:IsA("UIStroke") or child:IsA("UIPadding") or child:IsA("UIListLayout") or child:IsA("UIGridLayout")) then
			return true
		end
	end
	return false
end

local function renderTree(parentObj, parentContainer, depth)
	local children = {}
	pcall(function() children = parentObj:GetChildren() end)

	for _, child in ipairs(children) do
		if not (child:IsA("UICorner") or child:IsA("UIStroke") or child:IsA("UIPadding") or child:IsA("UIListLayout") or child:IsA("UIGridLayout")) then
			local nodeFrame = Instance.new("Frame")
			nodeFrame.Size = UDim2.new(1, 0, 0, 22)
			nodeFrame.BackgroundTransparency = 1
			nodeFrame.AutomaticSize = Enum.AutomaticSize.Y
			nodeFrame.Parent = parentContainer

			local nodeLayout = Instance.new("UIListLayout")
			nodeLayout.SortOrder = Enum.SortOrder.LayoutOrder
			nodeLayout.Padding = UDim.new(0, 3)
			nodeLayout.Parent = nodeFrame

			local mainBtn = Instance.new("TextButton")
			mainBtn.Size = UDim2.new(1, 0, 0, 22)
			mainBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
			mainBtn.BorderSizePixel = 0
			mainBtn.Text = ""
			mainBtn.LayoutOrder = 1
			mainBtn.Parent = nodeFrame
			Instance.new("UICorner", mainBtn).CornerRadius = UDim.new(0, 4)

			local indent = depth * 12

			local arrow = Instance.new("TextLabel")
			arrow.Size = UDim2.new(0, 14, 0, 22)
			arrow.Position = UDim2.new(0, indent, 0, 0)
			arrow.BackgroundTransparency = 1
			arrow.Text = hasRealChildren(child) and "▶" or ""
			arrow.TextColor3 = Color3.fromRGB(150, 150, 150)
			arrow.TextSize = 9
			arrow.Parent = mainBtn

			local iconImg = Instance.new("ImageLabel")
			iconImg.Size = UDim2.new(0, 14, 0, 14)
			iconImg.Position = UDim2.new(0, indent + 14, 0.5, -7)
			iconImg.BackgroundTransparency = 1
			iconImg.Image = getIconId(child)
			iconImg.Parent = mainBtn

			local nameLbl = Instance.new("TextLabel")
			nameLbl.Size = UDim2.new(1, -(indent + 32), 1, 0)
			nameLbl.Position = UDim2.new(0, indent + 32, 0, 0)
			nameLbl.BackgroundTransparency = 1
			nameLbl.Text = " " .. child.Name
			nameLbl.TextColor3 = Color3.fromRGB(210, 210, 210)
			nameLbl.TextSize = 11
			nameLbl.Font = Enum.Font.Gotham
			nameLbl.TextXAlignment = Enum.TextXAlignment.Left
			nameLbl.Parent = mainBtn

			local subContainer = Instance.new("Frame")
			subContainer.Size = UDim2.new(1, -8, 0, 0)
			subContainer.Position = UDim2.new(0, 8, 0, 0)
			subContainer.BackgroundTransparency = 1
			subContainer.AutomaticSize = Enum.AutomaticSize.Y
			subContainer.Visible = false
			subContainer.LayoutOrder = 2
			subContainer.Parent = nodeFrame

			local subLayout = Instance.new("UIListLayout")
			subLayout.SortOrder = Enum.SortOrder.LayoutOrder
			subLayout.Padding = UDim.new(0, 3)
			subLayout.Parent = subContainer

			local isOpen = false
			local isLoaded = false

			local function toggle()
				isOpen = not isOpen
				TweenService:Create(arrow, TweenInfo.new(0.15), { Rotation = isOpen and 90 or 0 }):Play()

				if isOpen then
					if not isLoaded then
						isLoaded = true
						renderTree(child, subContainer, depth + 1)
					end
					subContainer.Visible = true
				else
					subContainer.Visible = false
				end
			end

			mainBtn.MouseButton1Click:Connect(function()
				selectedGlobalObject = child
				showProperties(child)
				showEditor(child)
				if hasRealChildren(child) then
					toggle()
				end
			end)
		end
	end
end

local function loadExplorer()
	clearColumn(colExplorer)
	local containers = {
		"Workspace", "Players", "Lighting", "MaterialService", "NetworkClient",
		"ReplicatedFirst", "ReplicatedStorage", "ServerScriptService", "ServerStorage",
		"StarterGui", "StarterPack", "StarterPlayer", "Teams", "SoundService", "TextChatService"
	}

	for _, name in ipairs(containers) do
		local service = game:FindFirstChild(name)
		if service then
			local nodeFrame = Instance.new("Frame")
			nodeFrame.Size = UDim2.new(1, 0, 0, 22)
			nodeFrame.BackgroundTransparency = 1
			nodeFrame.AutomaticSize = Enum.AutomaticSize.Y
			nodeFrame.Parent = colExplorer

			local nodeLayout = Instance.new("UIListLayout")
			nodeLayout.SortOrder = Enum.SortOrder.LayoutOrder
			nodeLayout.Padding = UDim.new(0, 3)
			nodeLayout.Parent = nodeFrame

			local mainBtn = Instance.new("TextButton")
			mainBtn.Size = UDim2.new(1, 0, 0, 22)
			mainBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
			mainBtn.BorderSizePixel = 0
			mainBtn.Text = ""
			mainBtn.LayoutOrder = 1
			mainBtn.Parent = nodeFrame
			Instance.new("UICorner", mainBtn).CornerRadius = UDim.new(0, 4)

			local arrow = Instance.new("TextLabel")
			arrow.Size = UDim2.new(0, 14, 0, 22)
			arrow.Position = UDim2.new(0, 4, 0, 0)
			arrow.BackgroundTransparency = 1
			arrow.Text = hasRealChildren(service) and "▶" or ""
			arrow.TextColor3 = Color3.fromRGB(150, 150, 150)
			arrow.TextSize = 9
			arrow.Parent = mainBtn

			local iconImg = Instance.new("ImageLabel")
			iconImg.Size = UDim2.new(0, 14, 0, 14)
			iconImg.Position = UDim2.new(0, 18, 0.5, -7)
			iconImg.BackgroundTransparency = 1
			iconImg.Image = getIconId(service)
			iconImg.Parent = mainBtn

			local nameLbl = Instance.new("TextLabel")
			nameLbl.Size = UDim2.new(1, -34, 1, 0)
			nameLbl.Position = UDim2.new(0, 34, 0, 0)
			nameLbl.BackgroundTransparency = 1
			nameLbl.Text = " " .. service.Name
			nameLbl.TextColor3 = Color3.fromRGB(230, 230, 230)
			nameLbl.TextSize = 11
			nameLbl.Font = Enum.Font.Gotham
			nameLbl.TextXAlignment = Enum.TextXAlignment.Left
			nameLbl.Parent = mainBtn

			local subContainer = Instance.new("Frame")
			subContainer.Size = UDim2.new(1, -8, 0, 0)
			subContainer.Position = UDim2.new(0, 8, 0, 0)
			subContainer.BackgroundTransparency = 1
			subContainer.AutomaticSize = Enum.AutomaticSize.Y
			subContainer.Visible = false
			subContainer.LayoutOrder = 2
			subContainer.Parent = nodeFrame

			local subLayout = Instance.new("UIListLayout")
			subLayout.SortOrder = Enum.SortOrder.LayoutOrder
			subLayout.Padding = UDim.new(0, 3)
			subLayout.Parent = subContainer

			local isOpen = false
			local isLoaded = false

			local function toggle()
				isOpen = not isOpen
				TweenService:Create(arrow, TweenInfo.new(0.15), { Rotation = isOpen and 90 or 0 }):Play()

				if isOpen then
					if not isLoaded then
						isLoaded = true
						renderTree(service, subContainer, 1)
					end
					subContainer.Visible = true
				else
					subContainer.Visible = false
				end
			end

			mainBtn.MouseButton1Click:Connect(function()
				selectedGlobalObject = service
				showProperties(service)
				showEditor(service)
				if hasRealChildren(service) then
					toggle()
				end
			end)
		end
	end
end

showEditor = function(obj)
	clearColumn(colEditor)
	if obj:IsA("Script") or obj:IsA("LocalScript") or obj:IsA("ModuleScript") then
		local topBar = Instance.new("Frame")
		topBar.Size = UDim2.new(1, 0, 0, 26)
		topBar.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
		topBar.BorderSizePixel = 0
		topBar.Parent = colEditor

		local copyBtn = Instance.new("TextButton")
		copyBtn.Size = UDim2.new(0, 75, 0, 20)
		copyBtn.Position = UDim2.new(1, -79, 0, 3)
		copyBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
		copyBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
		copyBtn.TextSize = 11
		copyBtn.Font = Enum.Font.GothamBold
		copyBtn.Text = "Copy"
		copyBtn.BorderSizePixel = 0
		copyBtn.Parent = topBar
		Instance.new("UICorner", copyBtn).CornerRadius = UDim.new(0, 3)

		local sourceBox = Instance.new("TextBox")
		sourceBox.Size = UDim2.new(1, -6, 1, -30)
		sourceBox.Position = UDim2.new(0, 3, 0, 28)
		sourceBox.BackgroundTransparency = 1
		sourceBox.TextColor3 = Color3.fromRGB(204, 204, 204)
		sourceBox.TextSize = 12
		sourceBox.Font = Enum.Font.Code
		sourceBox.TextXAlignment = Enum.TextXAlignment.Left
		sourceBox.TextYAlignment = Enum.TextYAlignment.Top
		sourceBox.MultiLine = true
		sourceBox.ClearTextOnFocus = false
		sourceBox.Parent = colEditor

		local success, code = pcall(function() return decompile(obj) end)
		if not success or not code or code == "" then
			success, code = pcall(function() return obj.Source end)
		end

		if success and code and code ~= "" then
			sourceBox.Text = code
		else
			sourceBox.Text = "-- [!] Source hidden."
		end

		copyBtn.MouseButton1Click:Connect(function()
			pcall(function()
				setclipboard(sourceBox.Text)
				copyBtn.Text = "OK"
				task.wait(1)
				copyBtn.Text = "Copy"
			end)
		end)
	else
		local emptyLbl = Instance.new("TextLabel")
		emptyLbl.Size = UDim2.new(1, 0, 1, 0)
		emptyLbl.BackgroundTransparency = 1
		emptyLbl.TextColor3 = Color3.fromRGB(120, 120, 120)
		emptyLbl.TextSize = 12
		emptyLbl.Font = Enum.Font.Gotham
		emptyLbl.Text = "Select a script"
		emptyLbl.Parent = colEditor
	end
end

showProperties = function(obj)
	clearColumn(colProperties)
	if not obj then return end

	local function addCategory(name)
		local cat = Instance.new("TextButton")
		cat.Size = UDim2.new(1, 0, 0, 24)
		cat.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
		cat.TextColor3 = Color3.fromRGB(240, 240, 240)
		cat.TextSize = 11
		cat.Font = Enum.Font.GothamBold
		cat.Text = " ▼    " .. name
		cat.TextXAlignment = Enum.TextXAlignment.Left
		cat.BorderSizePixel = 0
		cat.Parent = colProperties
	end

	local function addPropertyRow(propName, val)
		local row = Instance.new("Frame")
		row.Size = UDim2.new(1, 0, 0, 22)
		row.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
		row.BorderSizePixel = 0
		row.Parent = colProperties

		local nameLbl = Instance.new("TextLabel")
		nameLbl.Size = UDim2.new(0.45, 0, 1, 0)
		nameLbl.Position = UDim2.new(0, 6, 0, 0)
		nameLbl.BackgroundTransparency = 1
		nameLbl.TextColor3 = Color3.fromRGB(170, 170, 170)
		nameLbl.TextSize = 11
		nameLbl.Font = Enum.Font.Code
		nameLbl.TextXAlignment = Enum.TextXAlignment.Left
		nameLbl.Text = propName
		nameLbl.Parent = row

		local valLbl = Instance.new("TextLabel")
		valLbl.Size = UDim2.new(0.5, 0, 1, 0)
		valLbl.Position = UDim2.new(0.48, 0, 0, 0)
		valLbl.BackgroundTransparency = 1
		valLbl.TextColor3 = Color3.fromRGB(220, 220, 220)
		valLbl.TextSize = 11
		valLbl.Font = Enum.Font.Code
		valLbl.TextXAlignment = Enum.TextXAlignment.Left
		valLbl.Text = tostring(val)
		valLbl.Parent = row
	end

	addCategory("Data")
	addPropertyRow("Name", obj.Name)
	addPropertyRow("ClassName", obj.ClassName)
	addPropertyRow("Parent", obj.Parent and obj.Parent.Name or "nil")

	if obj:IsA("BasePart") then
		addCategory("Part")
		addPropertyRow("Anchored", tostring(obj.Anchored))
		addPropertyRow("CanCollide", tostring(obj.CanCollide))
		addPropertyRow("Transparency", tostring(obj.Transparency))
	end
end

loadExplorer()

searchBox:GetPropertyChangedSignal("Text"):Connect(function()
	local query = searchBox.Text:lower():match("^%s*(.-)%s*$")
	if query == "" then
		loadExplorer()
		return
	end

	clearColumn(colExplorer)
	local function searchRecursive(parent)
		pcall(function()
			for _, child in ipairs(parent:GetChildren()) do
				if child.Name:lower():find(query) then
					local itemFrame = Instance.new("Frame")
					itemFrame.Size = UDim2.new(1, 0, 0, 22)
					itemFrame.BackgroundTransparency = 1
					itemFrame.Parent = colExplorer

					local nameBtn = Instance.new("TextButton")
					nameBtn.Size = UDim2.new(1, 0, 1, 0)
					nameBtn.BackgroundTransparency = 1
					nameBtn.Text = ""
					nameBtn.Parent = itemFrame

					local iconImg = Instance.new("ImageLabel")
					iconImg.Size = UDim2.new(0, 14, 0, 14)
					iconImg.Position = UDim2.new(0, 4, 0.5, -7)
					iconImg.BackgroundTransparency = 1
					iconImg.Image = getIconId(child)
					iconImg.Parent = nameBtn

					local nameLbl = Instance.new("TextLabel")
					nameLbl.Size = UDim2.new(1, -22, 1, 0)
					nameLbl.Position = UDim2.new(0, 22, 0, 0)
					nameLbl.BackgroundTransparency = 1
					nameLbl.Text = " " .. child.Name
					nameLbl.TextColor3 = Color3.fromRGB(230, 230, 230)
					nameLbl.TextSize = 11
					nameLbl.Font = Enum.Font.Gotham
					nameLbl.TextXAlignment = Enum.TextXAlignment.Left
					nameLbl.Parent = nameBtn

					nameBtn.MouseButton1Click:Connect(function()
						selectedGlobalObject = child
						showProperties(child)
						showEditor(child)
					end)
				end
				searchRecursive(child)
			end
		end)
	end

	local containers = {"Workspace", "ReplicatedStorage", "ServerScriptService", "ServerStorage", "StarterGui", "Players", "Lighting"}
	for _, name in ipairs(containers) do
		local s = game:FindFirstChild(name)
		if s then searchRecursive(s) end
	end
end)
