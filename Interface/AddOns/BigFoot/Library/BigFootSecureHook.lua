 local BSH_dbdf11f5b07258936fb1c5a31eaa969c = 1; local BSH_1b5523f0adb45c4b8ee51f89ebf6f2b2 = 0; local BSH_6dc50cf393baa8395c3f8b6cd575c5d9 = { _F = {}, }; function BSH_6dc50cf393baa8395c3f8b6cd575c5d9:Hook(BSH_89d99bb0d06dd535e6d6f6d9b3f04006, BSH_c31af5fd9021206e921af3d99e5a90af, BSH_9ed8bd8a19b94f73925daece17a05623) if (BSH_9ed8bd8a19b94f73925daece17a05623) then assert(BSH_89d99bb0d06dd535e6d6f6d9b3f04006 and type(BSH_89d99bb0d06dd535e6d6f6d9b3f04006) == "table", "BSecureHook: Invalid ui object"); assert(BSH_c31af5fd9021206e921af3d99e5a90af and type(BSH_c31af5fd9021206e921af3d99e5a90af) == "string", "BSecureHook: Invalid function to hook"); assert(BSH_9ed8bd8a19b94f73925daece17a05623 and type(BSH_9ed8bd8a19b94f73925daece17a05623) == "function", "BSecureHook: Invalid hookfunc"); self._E[BSH_89d99bb0d06dd535e6d6f6d9b3f04006] = self._E[BSH_89d99bb0d06dd535e6d6f6d9b3f04006] or {}; self._E[BSH_89d99bb0d06dd535e6d6f6d9b3f04006][BSH_c31af5fd9021206e921af3d99e5a90af] = true; if (BSH_6dc50cf393baa8395c3f8b6cd575c5d9._F[BSH_89d99bb0d06dd535e6d6f6d9b3f04006] and BSH_6dc50cf393baa8395c3f8b6cd575c5d9._F[BSH_89d99bb0d06dd535e6d6f6d9b3f04006][BSH_c31af5fd9021206e921af3d99e5a90af] and BSH_6dc50cf393baa8395c3f8b6cd575c5d9._F[BSH_89d99bb0d06dd535e6d6f6d9b3f04006][BSH_c31af5fd9021206e921af3d99e5a90af][BSH_9ed8bd8a19b94f73925daece17a05623]) then else hooksecurefunc(BSH_89d99bb0d06dd535e6d6f6d9b3f04006, BSH_c31af5fd9021206e921af3d99e5a90af, function(...) if (self.enable and self._E[BSH_89d99bb0d06dd535e6d6f6d9b3f04006][BSH_c31af5fd9021206e921af3d99e5a90af]) then BSH_9ed8bd8a19b94f73925daece17a05623(...) end end); BSH_6dc50cf393baa8395c3f8b6cd575c5d9._F[BSH_89d99bb0d06dd535e6d6f6d9b3f04006] = BSH_6dc50cf393baa8395c3f8b6cd575c5d9._F[BSH_89d99bb0d06dd535e6d6f6d9b3f04006] or {}; BSH_6dc50cf393baa8395c3f8b6cd575c5d9._F[BSH_89d99bb0d06dd535e6d6f6d9b3f04006][BSH_c31af5fd9021206e921af3d99e5a90af] = BSH_6dc50cf393baa8395c3f8b6cd575c5d9._F[BSH_89d99bb0d06dd535e6d6f6d9b3f04006][BSH_c31af5fd9021206e921af3d99e5a90af] or {}; BSH_6dc50cf393baa8395c3f8b6cd575c5d9._F[BSH_89d99bb0d06dd535e6d6f6d9b3f04006][BSH_c31af5fd9021206e921af3d99e5a90af][BSH_9ed8bd8a19b94f73925daece17a05623] = true; end else BSH_9ed8bd8a19b94f73925daece17a05623 = BSH_c31af5fd9021206e921af3d99e5a90af; BSH_c31af5fd9021206e921af3d99e5a90af = BSH_89d99bb0d06dd535e6d6f6d9b3f04006; self._E[BSH_c31af5fd9021206e921af3d99e5a90af] = true; assert(BSH_c31af5fd9021206e921af3d99e5a90af and type(BSH_c31af5fd9021206e921af3d99e5a90af) == "string", "BSecureHook: Invalid function to hook"); assert(BSH_9ed8bd8a19b94f73925daece17a05623 and type(BSH_9ed8bd8a19b94f73925daece17a05623) == "function", "BSecureHook: Invalid hookfunc"); if (BSH_6dc50cf393baa8395c3f8b6cd575c5d9._F[BSH_c31af5fd9021206e921af3d99e5a90af] and BSH_6dc50cf393baa8395c3f8b6cd575c5d9._F[BSH_c31af5fd9021206e921af3d99e5a90af][BSH_9ed8bd8a19b94f73925daece17a05623]) then else hooksecurefunc(BSH_c31af5fd9021206e921af3d99e5a90af, function(...) if (self.enable and self._E[BSH_c31af5fd9021206e921af3d99e5a90af]) then BSH_9ed8bd8a19b94f73925daece17a05623(...) end end); BSH_6dc50cf393baa8395c3f8b6cd575c5d9._F[BSH_c31af5fd9021206e921af3d99e5a90af] = BSH_6dc50cf393baa8395c3f8b6cd575c5d9._F[BSH_c31af5fd9021206e921af3d99e5a90af] or {}; BSH_6dc50cf393baa8395c3f8b6cd575c5d9._F[BSH_c31af5fd9021206e921af3d99e5a90af][BSH_9ed8bd8a19b94f73925daece17a05623] = true; end end end function BSH_6dc50cf393baa8395c3f8b6cd575c5d9:Unhook(BSH_89d99bb0d06dd535e6d6f6d9b3f04006, BSH_c31af5fd9021206e921af3d99e5a90af) if (BSH_c31af5fd9021206e921af3d99e5a90af) then if (self._E[BSH_89d99bb0d06dd535e6d6f6d9b3f04006] and self._E[BSH_89d99bb0d06dd535e6d6f6d9b3f04006][BSH_c31af5fd9021206e921af3d99e5a90af]) then self._E[BSH_89d99bb0d06dd535e6d6f6d9b3f04006][BSH_c31af5fd9021206e921af3d99e5a90af] = false; end else BSH_c31af5fd9021206e921af3d99e5a90af = BSH_89d99bb0d06dd535e6d6f6d9b3f04006; if (self._E[BSH_c31af5fd9021206e921af3d99e5a90af]) then self._E[BSH_c31af5fd9021206e921af3d99e5a90af] = false; end end end function BSH_6dc50cf393baa8395c3f8b6cd575c5d9:HookScript(BSH_89d99bb0d06dd535e6d6f6d9b3f04006, BSH_57ad665d0e8800ab56a0e07f8ae9c063, BSH_9ed8bd8a19b94f73925daece17a05623) assert(BSH_89d99bb0d06dd535e6d6f6d9b3f04006 and type(BSH_89d99bb0d06dd535e6d6f6d9b3f04006) == "table", "BSecureHook: Invalid ui object"); assert(BSH_57ad665d0e8800ab56a0e07f8ae9c063 and type(BSH_57ad665d0e8800ab56a0e07f8ae9c063) == "string", "BSecureHook: Invalid handler"); assert(BSH_9ed8bd8a19b94f73925daece17a05623 and type(BSH_9ed8bd8a19b94f73925daece17a05623) == "function", "BSecureHook: Invalid hookfunc"); self._E[BSH_89d99bb0d06dd535e6d6f6d9b3f04006] = self._E[BSH_89d99bb0d06dd535e6d6f6d9b3f04006] or {}; self._E[BSH_89d99bb0d06dd535e6d6f6d9b3f04006][BSH_57ad665d0e8800ab56a0e07f8ae9c063] = true; if (BSH_89d99bb0d06dd535e6d6f6d9b3f04006:GetScript(BSH_57ad665d0e8800ab56a0e07f8ae9c063)) then if (BSH_6dc50cf393baa8395c3f8b6cd575c5d9._F[BSH_89d99bb0d06dd535e6d6f6d9b3f04006] and BSH_6dc50cf393baa8395c3f8b6cd575c5d9._F[BSH_89d99bb0d06dd535e6d6f6d9b3f04006][BSH_57ad665d0e8800ab56a0e07f8ae9c063] and BSH_6dc50cf393baa8395c3f8b6cd575c5d9._F[BSH_89d99bb0d06dd535e6d6f6d9b3f04006][BSH_57ad665d0e8800ab56a0e07f8ae9c063][BSH_9ed8bd8a19b94f73925daece17a05623]) then else BSH_89d99bb0d06dd535e6d6f6d9b3f04006:HookScript(BSH_57ad665d0e8800ab56a0e07f8ae9c063, function(...) if (self.enable and self._E[BSH_89d99bb0d06dd535e6d6f6d9b3f04006][BSH_57ad665d0e8800ab56a0e07f8ae9c063]) then BSH_9ed8bd8a19b94f73925daece17a05623(...) end end); BSH_6dc50cf393baa8395c3f8b6cd575c5d9._F[BSH_89d99bb0d06dd535e6d6f6d9b3f04006] = BSH_6dc50cf393baa8395c3f8b6cd575c5d9._F[BSH_89d99bb0d06dd535e6d6f6d9b3f04006] or {}; BSH_6dc50cf393baa8395c3f8b6cd575c5d9._F[BSH_89d99bb0d06dd535e6d6f6d9b3f04006][BSH_57ad665d0e8800ab56a0e07f8ae9c063] = BSH_6dc50cf393baa8395c3f8b6cd575c5d9._F[BSH_89d99bb0d06dd535e6d6f6d9b3f04006][BSH_57ad665d0e8800ab56a0e07f8ae9c063] or {}; BSH_6dc50cf393baa8395c3f8b6cd575c5d9._F[BSH_89d99bb0d06dd535e6d6f6d9b3f04006][BSH_57ad665d0e8800ab56a0e07f8ae9c063][BSH_9ed8bd8a19b94f73925daece17a05623] = true; end else BSH_89d99bb0d06dd535e6d6f6d9b3f04006:SetScript(BSH_57ad665d0e8800ab56a0e07f8ae9c063, function(...) if (self.enable and self._E[BSH_89d99bb0d06dd535e6d6f6d9b3f04006][BSH_57ad665d0e8800ab56a0e07f8ae9c063]) then BSH_9ed8bd8a19b94f73925daece17a05623(...) end end); BSH_6dc50cf393baa8395c3f8b6cd575c5d9._F[BSH_89d99bb0d06dd535e6d6f6d9b3f04006] = BSH_6dc50cf393baa8395c3f8b6cd575c5d9._F[BSH_89d99bb0d06dd535e6d6f6d9b3f04006] or {}; BSH_6dc50cf393baa8395c3f8b6cd575c5d9._F[BSH_89d99bb0d06dd535e6d6f6d9b3f04006][BSH_57ad665d0e8800ab56a0e07f8ae9c063] = BSH_6dc50cf393baa8395c3f8b6cd575c5d9._F[BSH_89d99bb0d06dd535e6d6f6d9b3f04006][BSH_57ad665d0e8800ab56a0e07f8ae9c063] or {}; BSH_6dc50cf393baa8395c3f8b6cd575c5d9._F[BSH_89d99bb0d06dd535e6d6f6d9b3f04006][BSH_57ad665d0e8800ab56a0e07f8ae9c063][BSH_9ed8bd8a19b94f73925daece17a05623] = true; end end function BSH_6dc50cf393baa8395c3f8b6cd575c5d9:UnhookScript(BSH_89d99bb0d06dd535e6d6f6d9b3f04006, BSH_57ad665d0e8800ab56a0e07f8ae9c063) if (self._E[BSH_89d99bb0d06dd535e6d6f6d9b3f04006] and self._E[BSH_89d99bb0d06dd535e6d6f6d9b3f04006][BSH_57ad665d0e8800ab56a0e07f8ae9c063]) then self._E[BSH_89d99bb0d06dd535e6d6f6d9b3f04006][BSH_57ad665d0e8800ab56a0e07f8ae9c063] = false; end end function BSH_6dc50cf393baa8395c3f8b6cd575c5d9:Enable() self.enable = true; end function BSH_6dc50cf393baa8395c3f8b6cd575c5d9:Disable() self.enable = false; end function BSH_6dc50cf393baa8395c3f8b6cd575c5d9:constructor() self.enable = true; self._E = {}; end BLibrary:Register(BSH_6dc50cf393baa8395c3f8b6cd575c5d9, "BSecureHook", BSH_dbdf11f5b07258936fb1c5a31eaa969c, BSH_1b5523f0adb45c4b8ee51f89ebf6f2b2); --[[ SECURE = BLibrary("BSecureHook"); local echoHook = function (...) local msg = ""; for k, v in pairs({...}) do msg = msg .. "[" .. k .. "] =" .. tostring(v) .. "\n"; end DEFAULT_CHAT_FRAME:AddMessage("[BF Secure Hook]: " .. msg); end SECURE:Hook("UnitName", echoHook); SECURE:Unhook("UnitName"); SECURE:Hook(GameTooltip, "SetUnitBuff", echoHook); SECURE:Unhook(GameTooltip, "SetUnitBuff"); SECURE:HookScript(TargetofTargetFrame, "OnEvent", echoHook); ]]