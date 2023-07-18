
local Cache = {};
Cache.__index = Cache

function Cache.new()
    local self  = setmetatable({}, Cache);
    self._cache = {};

    self.pooled = 0;
    self.active  = 0;
    self.stored = 0;

    return self;
end

function Cache:Get(className:string)
    local set = self:_safe_get_set(className);

    local ins = next(set);
    if not ins then
        ins = Instance.new(className);
        self.pooled += 1;
    end

    self.active += 1;
    self.stored -= 1;

    rawset(set, ins, nil);
    return ins;
end

function Cache:Initialize(className:string, amount:number)
    local set = self:_safe_get_set(className);

    for _ = 1, amount do
        local ins = Instance.new(className);
        rawset(set, ins, true)
    end

    self.pooled += amount;
    self.stored += amount;
end

function Cache:Return(ins:Instance)
    local className = ins.ClassName;
    local set = self:_safe_get_set(className);

    self.active -= 1;
    self.stored += 1;

    ins.Parent = nil;
    rawset(set, ins, true);
end

function Cache:Destroy()
    for _, set in next, self._cache do
        for ins in next, set do
            ins:Destroy()
        end
    end
end

function Cache:_safe_get_set(className:string)
    local set = self._cache[className];
    if not set then
        set = {};
        self._cache[className] = set;
    end
    return set;
end

return Cache.new()