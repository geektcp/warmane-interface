 local BOO_dbdf11f5b07258936fb1c5a31eaa969c = 1; local BOO_1b5523f0adb45c4b8ee51f89ebf6f2b2 = 0; local BOO = {}; local NULLFUNC = function() end function BOO:Class(BOO_3fcf916ab67e012f741dba0eb24bc399, ...) BOO_3fcf916ab67e012f741dba0eb24bc399 = type(BOO_3fcf916ab67e012f741dba0eb24bc399) == "table" and BOO_3fcf916ab67e012f741dba0eb24bc399 or BLibrary:GetClass(tostring(BOO_3fcf916ab67e012f741dba0eb24bc399)) or {}; local BOO_a5f0d6c24168a66c668ab42a2b53b846 = {}; BOO_a5f0d6c24168a66c668ab42a2b53b846.super = BOO_3fcf916ab67e012f741dba0eb24bc399; function BOO_a5f0d6c24168a66c668ab42a2b53b846:New(...) local BOO_3bef88216cef4f812159f2017456f8dd = {}; setmetatable(BOO_3bef88216cef4f812159f2017456f8dd, {__index = BOO_a5f0d6c24168a66c668ab42a2b53b846}); BOO_3bef88216cef4f812159f2017456f8dd.class = BOO_a5f0d6c24168a66c668ab42a2b53b846; BOO_3bef88216cef4f812159f2017456f8dd.New = NULLFUNC; if (BOO_3fcf916ab67e012f741dba0eb24bc399 and BOO_3fcf916ab67e012f741dba0eb24bc399["_TYPE"] and BOO_3fcf916ab67e012f741dba0eb24bc399["_TYPE"] == "interface") then for k, v in pairs(BOO_3fcf916ab67e012f741dba0eb24bc399) do if (k ~= "_TYPE") then assert(type(BOO_a5f0d6c24168a66c668ab42a2b53b846[k]) == "function", format("error! Interface method (%s) must be implementd", tostring(k))); end end end BOO_3bef88216cef4f812159f2017456f8dd["_TYPE"] = nil; assert(BOO_a5f0d6c24168a66c668ab42a2b53b846.constructor, "The method <constructor> must be defined."); BOO_3bef88216cef4f812159f2017456f8dd.constructor(BOO_3bef88216cef4f812159f2017456f8dd, ...); return BOO_3bef88216cef4f812159f2017456f8dd; end setmetatable(BOO_a5f0d6c24168a66c668ab42a2b53b846, {__index = BOO_3fcf916ab67e012f741dba0eb24bc399}); if (BOO_3fcf916ab67e012f741dba0eb24bc399.constructor) then BOO_a5f0d6c24168a66c668ab42a2b53b846.constructor(BOO_a5f0d6c24168a66c668ab42a2b53b846, ...); end return BOO_a5f0d6c24168a66c668ab42a2b53b846; end function BOO:Interface(BOO_b4d3314490a868cf61f5fbd057900b0b, BOO_ce6f396c2ced211a8b6fbac1d07bcabe) assert(type(BOO_b4d3314490a868cf61f5fbd057900b0b)=="table", "Invalid argument #1. The type of argument #1 must be a table value."); BOO_ce6f396c2ced211a8b6fbac1d07bcabe = type(BOO_ce6f396c2ced211a8b6fbac1d07bcabe) == "table" and BOO_ce6f396c2ced211a8b6fbac1d07bcabe or {}; local BOO_a95e7552096a57823b372b9b166f9032 = {}; BOO_a95e7552096a57823b372b9b166f9032.super = BOO_ce6f396c2ced211a8b6fbac1d07bcabe; setmetatable(BOO_a95e7552096a57823b372b9b166f9032, {__index = BOO_ce6f396c2ced211a8b6fbac1d07bcabe}); for BOO_63a9ce6f1eeac72ef41293b7d0303335, BOO_8d0644c92128c1ff68223fd74ba63b56 in pairs(BOO_b4d3314490a868cf61f5fbd057900b0b) do assert(type(BOO_8d0644c92128c1ff68223fd74ba63b56)=="string", "Invalid interface. The type of the interface must be string"); end if (not BOO_a95e7552096a57823b372b9b166f9032.interface) then BOO_a95e7552096a57823b372b9b166f9032.interface = {}; end for BOO_63a9ce6f1eeac72ef41293b7d0303335, BOO_8d0644c92128c1ff68223fd74ba63b56 in pairs(BOO_b4d3314490a868cf61f5fbd057900b0b) do if (BOO_8d0644c92128c1ff68223fd74ba63b56) then table.insert(BOO_a95e7552096a57823b372b9b166f9032.interface, BOO_8d0644c92128c1ff68223fd74ba63b56); end end for BOO_e914904fab9d05d3f54d52bfc31a0f3f=1, #(BOO_a95e7552096a57823b372b9b166f9032.interface), 1 do if (type(BOO_a95e7552096a57823b372b9b166f9032.interface[BOO_e914904fab9d05d3f54d52bfc31a0f3f])=="string") then local BOO_2361bab8b48b1041ad740bb561b21aee = BOO_a95e7552096a57823b372b9b166f9032.interface[BOO_e914904fab9d05d3f54d52bfc31a0f3f]; BOO_a95e7552096a57823b372b9b166f9032.interface[BOO_e914904fab9d05d3f54d52bfc31a0f3f] = nil; BOO_a95e7552096a57823b372b9b166f9032.interface[BOO_2361bab8b48b1041ad740bb561b21aee] = true; end end BOO_a95e7552096a57823b372b9b166f9032.interface["_TYPE"] = "interface"; return BOO_a95e7552096a57823b372b9b166f9032.interface; end function BOO:constructor() end BLibrary:Register(BOO, "BOO", BOO_dbdf11f5b07258936fb1c5a31eaa969c, BOO_1b5523f0adb45c4b8ee51f89ebf6f2b2); 
