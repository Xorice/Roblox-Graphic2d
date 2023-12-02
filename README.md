# Graphic2d for Roblox

A Tool for drawing GUI in scripts

## Main Features

1. Auto manage Instance cache
2. Layered Drawing

## Attention

* Note: This lib does not support creating GUIs with connections.
Otherwise, it will cause an error
* Every canvas's properties must be initialized every time cuz the cache

## Why Use Graphic2d

* Better management of GUI
* Better performance
* Better design of GUI fx

All instances created inside have cache management

So you don't have to worry about the Memory leak

## Basic Usage Example

``` lua
local Graphic = Graphic2d.new(UI);

function state:draw()
    Graphic:SetCanvas();

    local t = os.clock()
    local pos = UDim2.fromScale(math.cos(t)*0.1 + 0.5, math.sin(t)*0.1 + 0.5);

    local canvas1 = Graphic:Draw "Frame"
        :SetProperties {
            AnchorPoint = Vector2.new(0.5, 0.5);
            Position = UDim2.fromScale(0.5, 0.5);
            Size = UDim2.fromScale(0.5,0.5);
        };

    canvas1:RenderTo "Frame"
        :SetProperties {
            Size = UDim2.fromScale(0.6,0.6);
            AnchorPoint = Vector2.new(1,1);
            Position = UDim2.fromScale(1,1);
        }

    canvas1:RenderTo "Frame"
        :SetProperties {
            Size = UDim2.fromScale(0.5,0.5);
            AnchorPoint = Vector2.new(0,0);     -- initialize
            Position = UDim2.fromScale(0,0);    -- initialize
        }
        :Draw "TextLabel"
        :SetProperties {
            AnchorPoint = Vector2.new(0.5, 0.5);
            Position = pos;
            Text = "Hello Graphic2d!"
        }

    Graphic:pop();
end
```

* The `Canvas` refers to a manager that contains the created instance. Not a `Regular Canvas`

## APIs for Graphic2d

``` lua
:SetCanvas(canvas): Canvas
```

Change a new canvas to draw

* Specially, returning to the DEFAULT layer without passing the `target canvas`

``` lua
:Draw(className:string, path:Instance?): Canvas
```

Draw an Instance (`any`)

``` lua
:Clear()
```

Clear everything

``` lua
:ClearCache()
```

Clear Instance cache

* Suggest calling it when changing game state

``` lua
:pop()
```

Renders the drawn content onto the screen

* Remember to call it when render event ended

``` lua
:Destroy()
```

Destroy the object

## API for Canvas

``` lua
:Draw(className:string): Canvas
```

Draw an Instance (`any`)

``` lua
:Clear(): Canvas
```

Clear the canvas

``` lua
:RenderTo(className:string): Canvas
```

Draw an Instance. (`any`)

* Any drawing after this will be placed under the instance it created

``` lua
:GetInstance(): Instance
```

``` lua
-- * Example: Getting the created instance
local Frame = Graphic:Draw "Frame"
:SetProperties {
    AnchorPoint = Vector2.new(0.5, 0.5);
    Position = UDim2.fromScale(0.5, 0.5);
    Size = UDim2.fromScale(0.5,0.5);
}
:GetInstance()
print(Frame.AnchorPoint); --> (0.5, 0.5)

-- * Example: Getting the Canvas
local Canvas = Graphic:Draw "Frame"
:SetProperties {
    AnchorPoint = Vector2.new(0.5, 0.5);
    Position = UDim2.fromScale(0.5, 0.5);
    Size = UDim2.fromScale(0.5,0.5);
}
```

Getting the instance of the `Canvas` drew above

``` lua
:SetProperties(config:{[string]:any})
```

Editing the instance created from last canvas

``` lua
:Freeze(): Instance
```

```lua
-- * Example: Create a TextLabel via Graphic2d
Graphic:SetCanvas()
local MyTextLabel :TextLabel = Graphic:Draw "TextLabel"
    :SetProperties {
        AnchorPoint = Vector2.new(0.5, 0.5);
        Size = UDim2.fromOffset(300, 100);
        Position = UDim2.fromScale(.5, .5);
        Text = "Hello There";
        ZIndex = 10;
    }
    :Freeze();
Graphic:pop()
MyTextLabel.Text = "I'm Free"
```

Separate the `Canvas` from Drawing Cycle as an `Instance`

* The Forzen canvas won't be clear by Graphic2d anymore. So this behaviour may lead to `Memory Leak`

* You can't freeze a Canvas that isn't using.

* Every Instances under it will be auto froze
