# Graphic2d for Roblox

一个在脚本里绘制 GUI 的工具

## 主要功能

1. 自动管理 Instance 缓存
2. 分层绘制

## 注意事项

* 注：本lib不支持创建带有 connection 的 gui. 否则会引起错误
* 每个画布的属性每次都需要初始化，因为有缓存

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

* 建议切换游戏状态的时候调用它

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
:Clear(): Canvas
```

清空画布

``` lua
:RenderTo(className:string): Canvas
```

绘制一个 Instance. (`any`)

* 在这后面任何的绘制都会放在它所创建的实例之下

``` lua
:GetInstance(): Instance
```

``` lua
-- * 例: 获取所创建的实例
local Frame = Graphic:Draw "Frame"
:SetProperties {
    AnchorPoint = Vector2.new(0.5, 0.5);
    Position = UDim2.fromScale(0.5, 0.5);
    Size = UDim2.fromScale(0.5,0.5);
}
:GetInstance()
print(Frame.AnchorPoint); --> (0.5, 0.5)

-- * 例：获取所绘制的画布
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

``` lua
:Freeze(): Instance
```

```lua
-- * 例：通过 Graphic2d 来创建一个 TextLabel
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

将该 `Canvas` 作为一个 `实例` 从绘制循环中分离出来

* Graphic2d 将不再清除冻结之后的画布. 因此, 这种行为可能导致 `内存泄漏`

* 你不能冻结一个没在使用的画布

* 画布下面的任何实例都会被自动冻结
