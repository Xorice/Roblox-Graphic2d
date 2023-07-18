
local EMPTY = {}

return function(Graphic2d)

    local Canvas = {};
    Canvas.__index      = Canvas;
    Canvas.ClassName    = "Canvas2d"

    local function new(className:string)
        local self  = {};
        self.ins = Graphic2d.Cache:Get(className);

        return setmetatable(self,Canvas);
    end

    function Canvas:SetProperties(config)
        local ins = self.ins;
        for i, v in next, config do
            ins[i] = v;
        end
        return self
    end

    function Canvas:GetInstance()
        return self.ins
    end

    function Canvas:Draw(className:string)
        return Graphic2d:Draw(className, (Graphic2d.CURRENT_CANVAS or EMPTY).ins)
    end

    function Canvas:RenderTo(className:string)
        local canvas = Graphic2d:Draw(className, self.ins)
        Graphic2d.CURRENT_CANVAS = canvas

        return canvas
    end

    return new
end