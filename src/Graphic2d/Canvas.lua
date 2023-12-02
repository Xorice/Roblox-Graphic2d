
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
        for i, v in next, Graphic2d:_get_initialize_map(ins) do
            if config[i] then continue end
            ins[i] = v;
        end
        for i, v in next, config do
            Graphic2d:_record_property(ins, i) -- * record the original value
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

    function Canvas:Clear()
        for _, v in next, self.ins:GetDescendants() do
            Graphic2d:_remove_instance(v)
        end
        return self
    end

    function Canvas:Freeze()
        local ins = self.ins :: Instance;
        Graphic2d:_pop_instance(ins)
        for _, v in next, ins:GetDescendants() do
            Graphic2d:_pop_instance(v);
        end
        return ins;
    end

    function Canvas:RenderTo(className:string)
        local canvas = Graphic2d:Draw(className, self.ins)
        Graphic2d.CURRENT_CANVAS = canvas

        return canvas
    end

    return new
end