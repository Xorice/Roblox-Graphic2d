# Graphic2d for Roblox

A Tool for drawing GUI in scripts

## Main Features

1. Auto manage Instance cache
2. Layered Drawing

## Attention

* Note: This lib does not support creating GUIs with connections.
Otherwise, it will cause an error

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

    local t = self.time
    local pos = UDim2.fromScale(math.cos(t)*0.1 + 0.5, math.sin(t)*0.1 + 0.5);

    Graphic:Draw "Frame"
    :SetProperties {
        AnchorPoint = Vector2.new(0.5, 0.5);
        Position = UDim2.fromScale(0.5, 0.5);
        Size = UDim2.fromScale(0.5,0.5);
    }
    :RenderTo "Frame"
    :SetProperties {
        Size = UDim2.fromScale(0.5,0.5);
    }
    :Draw "TextLabel"
    :SetProperties {
        AnchorPoint = Vector2.new(0.5, 0.5);
        Position = pos;
        Text = "Hello Graphic2d!"
    }

    Graphic:pop()
end
```

* The `Canvas` refers to a manager that contains the created instance. Not a `Regular Canvas`

## APIs for Graphic2d

``` lua
:SetCanvas(canvas)
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
:RenderTo(className:string): Canvas
```

Draw an Instance. (`any`)

* Any drawing after this will be placed under the instance it create

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
```

Getting the instance of the `Canvas` drew above

``` lua
:GetCanvas(): Canvas
```

Getting the canvas last drew

``` lua
:SetProperties(config:{[string]:any})
```

Editing the instance created from last canvas
