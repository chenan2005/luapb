--[[
local Person={3, 4, 5}
local t={}
local mt={
	__index=function(tbl, key)
		return Person[key]
	end,	
	__newindex=function(tbl, key, value)
		print "__newindex"
	end
}

setmetatable(t, mt)

print(t[1])

io.read("*line")
--]]


local function bin2hex(s)
    s=string.gsub(s,"(.)",function (x) return string.format("%02X ",string.byte(x)) end)
    return s
end

local h2b = {
    ["0"] = 0,
    ["1"] = 1,
    ["2"] = 2,
    ["3"] = 3,
    ["4"] = 4,
    ["5"] = 5,
    ["6"] = 6,
    ["7"] = 7,
    ["8"] = 8,
    ["9"] = 9,
    ["A"] = 10,
    ["B"] = 11,
    ["C"] = 12,
    ["D"] = 13,
    ["E"] = 14,
    ["F"] = 15
}

local function hex2bin( hexstr )
    local s = string.gsub(hexstr, "(.)(.)%s", function ( h, l )
         return string.char(h2b[h]*16+h2b[l])
    end)
    return s
end

require("luapb");

pb.import("test.proto");


local msg = pb.new("lm.test");
msg.uid = 12345;
msg.param = 9876;
msg.param1 = "zjx";
--print("type: " .. type(msg.param2));
msg.param2:add("first");
msg.param2:add("second");
msg.param2:add("three");

print("uid: " .. msg.uid);
print("param: " .. msg.param);
print("param1: " .. msg.param1);

for i = 1, msg.param2:len() do
	local value = msg.param2:get(i);
	print("i: " .. i .. " value: " .. value); 
end

--io.read("*line")
--print(msg.param2[1])

msg.param2[1] = "test"
print("===== param2: " .. msg.param2:get(1))

msg.param2:set(2, "test2")
print("===== param2: " .. msg.param2:get(2))

msg["_test2"].uid = 23456
print("===== _test2 (extension field): " .. pb.tostring(msg._test2))

--io.read("*line")

msg._test3:add().name="test3_first"
msg._test3:add().name="test3_second"
msg._test3:add().name="test3_third"
msg._test3:get(1).name = "test3_modify"
print(msg._test3:get(1).e)
msg._test3:get(1).e = 6
msg._test3:get(2).e = 1
msg._test3:get(3).e = 2
msg._test3:get(1).ee:add(3)
msg._test3:get(1).ee:add(6)
msg._test3:get(1).ee:add(1)
msg._test3:get(1).ee:add(2)
print("msg._test3:get(1).ee:get(2) : " .. msg._test3:get(1).ee:get(2))
--io.read("*line")
--msg._test3:get(1).e = 100

print("msg.tostring: \n" .. pb.tostring(msg));

msgdata = pb.serializeToString(msg);
print("msg.serializeToString:" .. bin2hex(msgdata))

local msg1 = pb.new("lm.test")
pb.parseFromString(msg1, msgdata)
print("msg1.parseFromString:" .. pb.tostring(msg1))
