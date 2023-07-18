-- # 2023/7/18 Xorice
--------------------------------------------------------
-- MIT License

-- Copyright (c) 2023 Xorice

-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.
--------------------------------------------------------
-- More Information: https://github.com/Xorice/Roblox-Graphic2d/
--------------------------------------------------------
-- HELPER
local Maid  = require(script:WaitForChild "Maid");
local Cache = require(script:WaitForChild "Cache");

local Canvas;
local EMPTY = {};
----------------------------------------
-- OBJECT

local Graphic2d = {};
Graphic2d.__index = Graphic2d;

function Graphic2d.new(path:Instance)
    local self = setmetatable({}, Graphic2d);
    self.Cache          = Cache;
    self.Maid           = Maid.new();
    self.Path           = path;
    self.CURRENT_CANVAS = nil;

    self.inUse      = {};
    self.removed    = {};

    Canvas = require(script:WaitForChild "Canvas")(self)
    self.Maid:GiveTask(Cache);
    return self
end

function Graphic2d:SetCanvas(canvas)
    self.CURRENT_CANVAS = canvas;
    return Canvas
end

function Graphic2d:Draw(className:string, path:Instance?)
    local canvas    = Canvas(className);
    local PATH      = path or (self.CURRENT_CANVAS or EMPTY).ins or self.Path

    canvas.ins.Parent = PATH;
    self.inUse[canvas.ins] = true;

    return canvas;
end

function Graphic2d:Clear()
    for ins in next, self.inUse do
        ins.Parent = nil;
    end
    local pooled = Cache.pooled;

    self.inUse = table.create(pooled);
    self.removed = table.create(pooled);
end

function Graphic2d:pop()
    local inUse     = self.inUse;
    local removed   = self.removed;

    for ins in next, removed do
        if not inUse[ins] then
            ins.Parent = nil;
        end
    end
    self.removed    = inUse;
    self.inUse      = table.create(Cache.pooled);
end

function Graphic2d:Destroy()
    self.CURRENT_CANVAS = nil;
    self.Maid:DoCleaning()
end

return Graphic2d;