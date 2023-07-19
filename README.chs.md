# Graphic2d for Roblox

一个在脚本里绘制 GUI 的工具

## 主要功能

1. 自动管理 Instance 缓存
2. 分层绘制

## 注意事项

* 注：本lib不支持创建带有connection的gui. 否则会引起错误

## 为什么使用 Graphic2d

* 更好地管理 GUI
* 更高的性能表现
* 更好地让你设计 GUI 东西

所有在这里创建的 Instance 都有缓存管理

因此你不必担心内存泄漏的问题

## 基础使用示例

``` lua
local Graphic = Graphic2d.new(UI);

function state:draw()
    Graphic:SetCanvas();

    local t = self.time
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

* 这里的 `Canvas` 指的是一个包含所创建 Instance 的管理器. 并不是 `真正意义上的 Canvas`

## APIs for Graphic2d

``` lua
:SetCanvas(canvas): Canvas
```

切换用来绘制的 Canvas

* 特别地, 如果没有传递 `目标 canvas` 的话会切换到默认层

``` lua
:Draw(className:string, path:Instance?): Canvas
```

绘制一个 Instance (`any`)

``` lua
:Clear()
```

清除画布

``` lua
:ClearCache()
```

清除 Instance 缓存

``` lua
:pop()
```

将结果绘制到屏幕上

* 记得在绘制事件结束的时候调用它

``` lua
:Destroy()
```

删除对象

## API for Canvas

``` lua
:Draw(className:string): Canvas
```

绘制一个 Instance (`any`)

``` lua
:RenderTo(className:string): Canvas
```

绘制一个 Instance. (`any`)

* 在这后面任何的绘制都会放在它所创建的实例之下

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
-- * Example: Getting the Canvas
local Canvas = Graphic:Draw "Frame"
:SetProperties {
    AnchorPoint = Vector2.new(0.5, 0.5);
    Position = UDim2.fromScale(0.5, 0.5);
    Size = UDim2.fromScale(0.5,0.5);
}
```

获取 `刚由 Canvas 绘制` 的 Instance

``` lua
:SetProperties(config:{[string]:any})
```

编辑 Canvas 所创建的实例
