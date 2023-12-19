local library = {

}

local utils =
    {}

    utils.create = 
    function(class, prop)
        local obj = Instance.new(class)
    
        for prop, v in next, prop do
            obj[prop] = v
        end
    
        pcall(function()
            obj.AutoButtonColor = false
        end)
    
        obj.Name = utils.random(16)
    
        return obj
    end
    utils.GetTextBounds= function(Text, Font, Size, Resolution)
        local Bounds = game:GetService("TextService"):GetTextSize(Text, Size, Font, Resolution or Vector2.new(1920, 1080))
        return { [1] = Bounds.X, [2] = Bounds.Y }
    end
    
    local Mouse = game.Players.LocalPlayer:GetMouse()
    local UserInputService = game:GetService("UserInputService")
    
    utils.getXY = function(GuiObject)
        local Max, May = GuiObject.AbsoluteSize.X, GuiObject.AbsoluteSize.Y
        local Px, Py = math.clamp(Mouse.X - GuiObject.AbsolutePosition.X, 0, Max), math.clamp(Mouse.Y - GuiObject.AbsolutePosition.Y, 0, May)
        return Px/Max, Py/May
    end
    
    utils.formatNumber = function(number)
        if number >= 1000000000 then
            local formattedNumber = string.format("%.1fB", number / 1000000000)
            if math.floor(number % 1000000000) ~= 0 then
                formattedNumber = formattedNumber .. "+"
            else
                formattedNumber = string.format("%.0fB", number / 1000000000)
            end
            return formattedNumber
        elseif number >= 1000000 then
            local formattedNumber = string.format("%.1fM", number / 1000000)
            if math.floor(number % 1000000) ~= 0 then
                formattedNumber = formattedNumber .. "+"
            else
                formattedNumber = string.format("%.0fM", number / 1000000)
            end
            return formattedNumber
        elseif number >= 1000 then
            local formattedNumber = string.format("%.1fK", number / 1000)
            if math.floor(number % 1000) ~= 0 then
                formattedNumber = formattedNumber .. "+"
            else
                formattedNumber = string.format("%.0fK", number / 1000)
            end
            return formattedNumber
        else
            return tostring(number)
        end
    end
    
    utils.updatesize = 
        function(uil, obj)
            local cS = uil.AbsoluteContentSize
            game.TweenService:Create(obj, TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                CanvasSize = UDim2.new(0, cS.X, 0, cS.Y + 50)
            }):Play()
        end
    
    utils.updatesizeX =
        function(uil, obj)
            local cS = uil.AbsoluteContentSize
    
            game.TweenService:Create(obj, TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                CanvasSize = UDim2.new(0, cS.X, 0, cS.Y)
            }):Play()
        end
    
    utils.scrollXtoFrame =
        function(scrollingFrame, targetObject)
            local objectPosition = targetObject.Position.X.Offset
            local frameWidth = scrollingFrame.AbsoluteSize.X
            local contentWidth = scrollingFrame.CanvasSize.X.Offset
    
            local newCanvasPosition = math.clamp(objectPosition - frameWidth / 2, 0, math.max(0, contentWidth - frameWidth))
    
            game.TweenService:Create(scrollingFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                CanvasPosition = Vector2.new(newCanvasPosition, scrollingFrame.CanvasPosition.Y)
            }):Play()
        end
    
    utils.random = 
        function(_length)
            local characters = "abcdefghijklmnopqrstuvwxyz1234567890"
            characters = string.split(characters, "")
        
            local randomString = ""
        
            for i = 1, _length do
                local randomIndex = math.random(1, #characters)
            
                if not tonumber(characters[randomIndex]) then
                    local uppercase = math.random(1, 2) == 2 and true or false
                    randomString = randomString .. (uppercase and characters[randomIndex]:upper() or characters[randomIndex])
                else
                    randomString = randomString .. characters[randomIndex]
                end
            end
            
            return randomString
        end
utils.smoothscrolling = 
    loadstring(game:HttpGet("https://raw.githubusercontent.com/lug1adev/W-Azure/main/SmoothScroll.lua", true))()
library.theme = {
    BackgroundColor = Color3.fromRGB(249, 249, 251),
    ShadowColor = Color3.fromRGB(30, 30, 30),
    ForegroundColor = Color3.fromRGB(77, 97, 122),
    TitleColor = Color3.fromRGB(42, 42, 42),
    StrokeColor = Color3.fromRGB(132, 143, 154),
    DescriptionColor = Color3.fromRGB(170, 178, 198),
    UnactiveColor = Color3.fromRGB(138, 149, 166),
    ActiveColor = Color3.fromRGB(0, 179, 255),
    MainColor = Color3.fromRGB(0, 179, 255),
    IconColor = Color3.fromRGB(107, 218, 255),
    UltilitiesIconColor = Color3.fromRGB(93, 93, 93),
    ConfirmButtonColor = Color3.fromRGB(107, 218, 255),
    SliderOuterColor = Color3.fromRGB(221, 227, 232),
    SliderInnerColor = Color3.fromRGB(0, 105, 254),
    SliderCircleShadow = Color3.fromRGB(0, 0, 0),
    ColorPickerDotStrokeColor = Color3.fromRGB(0, 0, 0),
    ColorPickerConfirmButtonColor = Color3.fromRGB(200, 200, 200),
    ScrollingFrameColor = Color3.fromRGB(0, 0, 0),
    BackgroundImage = nil,
    LoadingScreenImage = nil
}

    local TweenStyle = Enum.EasingStyle.Sine
    local TweenDirection = Enum.EasingDirection.InOut
    local TweenService = game:GetService("TweenService")
    local UserInputService = game:GetService("UserInputService")
    
    if not game:GetService("CoreGui"):FindFirstChild("NotificationLibrary") then
        local notificationLibrary = Instance.new("ScreenGui")
        notificationLibrary.Name = "NotificationLibrary"
        notificationLibrary.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        notificationLibrary.Parent = game:GetService("CoreGui")
    
        local notificationHolder = Instance.new("Frame")
        notificationHolder.Name = "NotificationHolder"
        notificationHolder.AnchorPoint = Vector2.new(0, 0.5)
        notificationHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        notificationHolder.BackgroundTransparency = 1
        notificationHolder.Position = UDim2.fromScale(0, 0.5)
        notificationHolder.Size = UDim2.fromScale(0.8, 1)
        notificationHolder.Parent = notificationLibrary
    
        local notificationUIListLayout = Instance.new("UIListLayout")
        notificationUIListLayout.Name = "NotificationUIListLayout"
        notificationUIListLayout.FillDirection = Enum.FillDirection.Vertical
        notificationUIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        notificationUIListLayout.Padding = UDim.new(0, 4)
        notificationUIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
        notificationUIListLayout.Parent = notificationHolder
    
        local notificationUIPadding = Instance.new("UIPadding")
        notificationUIPadding.Name = "NotificationUIPadding"
        notificationUIPadding.PaddingBottom = UDim.new(0, 10)
        notificationUIPadding.PaddingLeft = UDim.new(0, 10)
        notificationUIPadding.Parent = notificationHolder
    end
    
    local NotificationLib = game:GetService("CoreGui"):FindFirstChild("NotificationLibrary")
    local Holder = NotificationLib:FindFirstChild("NotificationHolder")
    library.notify = 
        function(...)
            local Text, Duration = unpack({ ... })
            Duration = Duration or 5
        
            local Color = library.theme.MainColor
            local ImageColor = library.theme.IconColor
            local TextColor = library.theme.TitleColor
            local DescriptionColor = library.theme.DescriptionColor
        
            local NotificationFrame = utils.create("Frame", {
                Parent = Holder,
                BackgroundColor3 = Color3.fromRGB(252, 252, 253),
                ClipsDescendants = true,
                Size = UDim2.new(0, 0, 0, 60),
                BackgroundTransparency = 1,
            })
        
            utils.create("UICorner", {
                Parent = NotificationFrame,
                CornerRadius = UDim.new(0, 4),
            })
        
            local OuterFrame = utils.create("Frame", {
                Parent = NotificationFrame,
                AnchorPoint = Vector2.new(0, 1),
                BackgroundColor3 = Color,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 1, 0),
                Size = UDim2.new(1, 0, 0, 3),
                ZIndex = 2,
                BackgroundTransparency = 1,
            })
        
            local NotificationIcon = utils.create("ImageLabel", {
                Parent = NotificationFrame,
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1.000,
                Position = UDim2.new(0, 8, 0, 5),
                Size = UDim2.new(0, 25, 0, 25),
                Image = "http://www.roblox.com/asset/?id=13286125855",
                ImageColor3 = ImageColor,
                ImageTransparency = 1,
            })
        
            local NotificationTitle = utils.create("TextLabel", {
                Parent = NotificationFrame,
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1.000,
                Position = UDim2.new(0, 40, 0, 8),
                Size = UDim2.new(0, 200, 0, 20),
                Font = Enum.Font.Gotham,
                Text = "Acean Hub",
                TextColor3 = TextColor,
                TextSize = 14.000,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextTransparency = 1,
            })
        
            local NotificationText = utils.create("TextLabel", {
                Parent = NotificationFrame,
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1.000,
                Position = UDim2.new(0, 10, 0.5, 0),
                Size = UDim2.new(0, 200, 0, 20),
                Font = Enum.Font.GothamBold,
                Text = Text,
                TextColor3 = DescriptionColor,
                TextSize = 14.000,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextTransparency = 1,
            })
        
            local NotifText = NotificationText
            local TextBounds = NotifText.TextBounds
        
            coroutine.wrap(function()
                local InTween = TweenService:Create(
                    NotificationFrame,
                    TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut),
                    { Size = UDim2.new(0, TextBounds.X + 50, 0, 60) }
                )
                InTween:Play()
        
                spawn(function()
                    task.wait(0.1)
                    TweenService:Create(
                        NotificationFrame,
                        TweenInfo.new(0, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut),
                        { BackgroundTransparency = 0 }
                    ):Play()
                    TweenService:Create(
                        OuterFrame,
                        TweenInfo.new(0, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut),
                        { BackgroundTransparency = 0 }
                    ):Play()
                    TweenService:Create(
                        NotificationText,
                        TweenInfo.new(0, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut),
                        { TextTransparency = 0 }
                    ):Play()
                    TweenService:Create(
                        NotificationTitle,
                        TweenInfo.new(0, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut),
                        { TextTransparency = 0 }
                    ):Play()
                    TweenService:Create(
                        NotificationIcon,
                        TweenInfo.new(0, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut),
                        { ImageTransparency = 0 }
                    ):Play()
                end)
        
                InTween.Completed:Wait()
        
                local LineTween = TweenService:Create(
                    OuterFrame,
                    TweenInfo.new(Duration, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
                    { Size = UDim2.new(0, 0, 0, 3) }
                )
                LineTween:Play()
                LineTween.Completed:Wait()
        
                local OutTween = TweenService:Create(
                    NotificationFrame,
                    TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut),
                    { Size = UDim2.new(0, 0, 0, 60) }
                )
                OutTween:Play()
        
                spawn(function()
                    task.wait(0.175)
                    TweenService:Create(
                        NotificationFrame,
                        TweenInfo.new(0.8, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut),
                        { BackgroundTransparency = 1 }
                    ):Play()
                    TweenService:Create(
                        OuterFrame,
                        TweenInfo.new(0.8, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut),
                        { BackgroundTransparency = 1 }
                    ):Play()
                    TweenService:Create(
                        NotificationText,
                        TweenInfo.new(0.8, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut),
                        { TextTransparency = 1 }
                    ):Play()
                    TweenService:Create(
                        NotificationTitle,
                        TweenInfo.new(0.8, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut),
                        { TextTransparency = 1 }
                    ):Play()
                    TweenService:Create(
                        NotificationIcon,
                        TweenInfo.new(0.8, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut),
                        { ImageTransparency = 1 }
                    ):Play()
                end)
        
                OutTween.Completed:Wait()
                NotificationFrame:Destroy()
            end)()
        end
