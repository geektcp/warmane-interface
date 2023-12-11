MiDKP=MiDKP or {} local M = MiDKP M.UI = M.UI or {} M.UI.Frame = {} function M.UI.Frame:Init(frame) setmetatable(self,{__index=M.E.H}) frame:RegisterEvent("ADDON_LOADED") end function M.UI.Frame:Update(frame, elapsed) if not frame.time or frame.time >=0.2 then frame.time = 0 M.UI.NotifyList:UpdateGlow() local k, v for k, v in pairs(MiDKP_AFKDND) do if (GetTime() - v > 0.5) then MiDKP_AFKDND[k] = nil end end else frame.time = frame.time + elapsed end end function M.UI.Frame:OnEvent(event, ...) if (event == "ADDON_LOADED") then local addon = ... if addon ~= "MiDKP" then return end self:AddonLoaded(...) elseif (event == "CHAT_MSG_WHISPER") then self:ChatMessage(...) elseif (event == "PLAYER_LEAVING_WORLD") then local saved,errormessage= pcall(M.DO.Raid.SaveAll) if not saved then M.S.SaveError(errormessage) end self:ZoneChange() elseif M and M.DO and M.DO.Raid and M.DO.Raid:IsRunning() then if (event == "CHAT_MSG_LOOT") then self:ChatMsgLoot(...) elseif (event == "RAID_ROSTER_UPDATE") then self:RaidUpdate() elseif (event == "COMBAT_LOG_EVENT_UNFILTERED") then self:CombatLog(...) elseif (event == "CHAT_MSG_MONSTER_EMOTE" or event == "CHAT_MSG_MONSTER_YELL") then self:MonsterEmote(...) elseif (event == "PLAYER_REGEN_DISABLED" or event == "PLAYER_REGEN_ENABLED") then self:StartEndFight() elseif (event=="INSTANCE_ENCOUNTER_ENGAGE_UNIT") then self:StartSpecicalBoss() end end end function M.UI.Frame:OnAddOnLoaded() M.Errored = false local function callAndRecord(func,arg1) local result, errorLog = pcall(func,arg1) if not result then M.Errored = true M.S.SaveError(errorLog) end end callAndRecord(M.DO.DKP.Init,M.DO.DKP) callAndRecord(M.U.Init,M.U) callAndRecord(M.DO.Config.Init,M.DO.Config) callAndRecord(M.E.Init,M.E) callAndRecord(M.UI.NotifyList.Init,M.UI.NotifyList) callAndRecord(M.OO.Zone.Load,M.OO.Zone) callAndRecord(M.OO.Boss.Load,M.OO.Boss) callAndRecord(M.DO.Alt.Init,M.DO.Alt) callAndRecord(M.DO.Raid.Init,M.DO.Raid) if M.Errored then M.U:Print("error",M.L.ERROR_LOADING) end end function M.UI.Frame:Toggle() if not _G.MiDKP3MainFrame:IsShown() then ShowUIPanel(MiDKP3MainFrame) else HideUIPanel(MiDKP3MainFrame) end end M.UI.NotifyList = {} function M.UI.NotifyList:AddButton(_i) local button =CreateFrame("Button", "MiDKP3NotifyButton".._i, UIParent, "MiDKP3NotifyButtonTemplate"); button:RegisterForClicks("LeftButtonUp", "RightButtonUp") button:SetScript("OnEnter",function(ui) if (ui.entity) then GameTooltip:SetOwner(ui, "TOPLEFT") GameTooltip:SetText(ui.entity:GetName()) GameTooltip:Show() end end) button:SetScript("OnLeave",function(ui) GameTooltip:Hide() end) button:SetScript("OnClick",function(ui,button) if button =="LeftButton" and ui.entity then M.UI.EditPanel:SetEntity(ui.entity) M.UI.EditPanel:Show() M.UI.EditPanel:SetFocus(2) else if ui.entity then M.UI.NotifyList:DeleteNotify(ui.entity) end end GameTooltip:Hide() end) return button end function M.UI.NotifyList:Init() M.U:Debug("NotifyList Inited") self.anchor = _G.MiDKP3NotifyAnchor self.anchor:SetPoint(M.DO.Config:GetConfig("anchor_position")); self.buttonList = {} self.entityList = M.OO.List:Create() end function M.UI.NotifyList:Show() self.anchor:Hide() local setTexture=function(_texture,left,right,top,bottom) _texture:SetTexCoord(left,right,top,bottom) _texture:SetWidth(128) _texture:SetHeight(128) end local setButtonTexture = function(_btn, _type) local path="Interface\\AddOns\\MiDKP\\img\\"..string.lower(_type).."_notify" _btn:SetNormalTexture(path) setTexture(_btn:GetNormalTexture(),0.5,1,0,0.5) _btn:SetPushedTexture(path) setTexture(_btn:GetPushedTexture(),0,0.5,0,0.5) _btn:SetDisabledTexture(path) setTexture(_btn:GetDisabledTexture(),0,0.5,0.5,1) _btn:SetHighlightTexture(path) setTexture(_btn:GetHighlightTexture(),0.5,1,0,0.5) _G[_btn:GetName().."Glow"]:SetTexture(path) setTexture(_G[_btn:GetName().."Glow"],0.5,1,0.5,1) end self:SetLocation() for _i = 1 ,getn(self.buttonList) do local button = self.buttonList[_i] if button.entity then if button.entity:GetType() =='Item' then setButtonTexture(button,"Item") elseif button.entity:GetType() =='Event' then setButtonTexture(button,"Boss") end if not self.anchor:IsVisible()then self.anchor:Show() end button:Show() else button:Hide() end end end function M.UI.NotifyList:Hide() self.anchor:Show() for _i = 1 ,getn(self.buttonList) do self.buttonList[_i]:Hide() end end function M.UI.NotifyList:UpdateGlow() local getGlowAlpha=function() if (not self.GlowAlpha) then self.GlowAlpha = 1; self.step = -0.025; end local getCurrentAlpha=function(MiDKP_e13a96a0ad2aafbc4af618967d6c0dc1) if (MiDKP_e13a96a0ad2aafbc4af618967d6c0dc1 < 0.1) then MiDKP_e13a96a0ad2aafbc4af618967d6c0dc1 = 0.1; self.step = 0.01; end if (MiDKP_e13a96a0ad2aafbc4af618967d6c0dc1 > 1) then MiDKP_e13a96a0ad2aafbc4af618967d6c0dc1 = 1; self.step = -0.01; end return MiDKP_e13a96a0ad2aafbc4af618967d6c0dc1 end self.GlowAlpha =getCurrentAlpha(self.GlowAlpha + self.step) return self.GlowAlpha end if not self.buttonList then return end for _i = 1, getn(self.buttonList) do local button = self.buttonList[_i] if button:IsVisible() then _G[button:GetName().."Glow"]:SetAlpha(getGlowAlpha()); end end end function M.UI.NotifyList:Update() for _i = 1 ,getn(self.buttonList) do self.buttonList[_i].entity = nil end self.entityList:RunList(function(entity,i) self.buttonList[i] = self.buttonList[i] or self:AddButton(i) self.buttonList[i].entity = entity end) self:Show() end function M.UI.NotifyList:AddNotify(entity) self.entityList:Add(entity) self:Update() end function M.UI.NotifyList:DeleteNotify(entity) self.entityList:Delete(entity) self:Update() end function M.UI.NotifyList:SetLocation() if #self.buttonList ==0 then return end for _i = 1 ,getn(self.buttonList) do self.buttonList[_i]:ClearAllPoints() end self.buttonList[1]:SetPoint("BOTTOMRIGHT", self.anchor, "BOTTOMRIGHT", -10, 10) for _i = 2 , self.entityList:Count() do self.buttonList[_i]:SetPoint("RIGHT",self.buttonList[_i-1], "LEFT", 0, 0) end end function M.UI.NotifyList.OnNewEvent(event) if M.DO.Config:GetConfig("event_action")==2 or M.UI.EditPanel.ui:IsShown() then M.UI.NotifyList:AddNotify(event) elseif (M.DO.Config:GetConfig("event_action") == 3) then M.UI.EditPanel:SetEntity(event) M.UI.EditPanel:Show() M.UI.EditPanel:SetFocus(2) end end function M.UI.NotifyList.OnNewItem(item) if M.DO.Config:GetConfig("event_action")==2 or M.UI.EditPanel.ui:IsShown() then M.UI.NotifyList:AddNotify(item) elseif (M.DO.Config:GetConfig("event_action") == 3) then M.UI.EditPanel:SetEntity(item) M.UI.EditPanel:Show() M.UI.EditPanel:SetFocus(2) end end M.UI.Page = {} function M.UI.Page:new() local new_inst={} setmetatable(new_inst,{__index=M.UI.Page}) return new_inst end function M.UI.Page:Init(parent) self.ui = _G["MiDKP3"..self.pageType.."Page"] self.ui:ClearAllPoints(); self.ui:SetParent(parent); self.ui:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, 0); self.ui:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", 0, 0); end function M.UI.Page:Show() self.ui:Show() end function M.UI.Page:Hide() self.ui:Hide() end function M.UI.Page:Load() if self.pageType == "Option" then return end self.panel = M.Widget.Panel:Create(self.pageType) self.panel:BindUI(self.ui) self.panel:SetParent(self) self:SetSort("ctime",true) self.menu = M.Widget.Menu:Create(self.pageType,self.panel) self:BindButtons() end function M.UI.Page:GetPanel() return self.panel end function M.UI.Page:OnLoad() self:Load() end function M.UI.Page:CheckData() if not M.Data[self.pageType.."s"] then return false end if self.pageType ~="Raid" then if M.DO.Raid:IsStarted() then return true else return false end end return true end function M.UI.Page:OnShowCheckData() if not self:CheckData() then self.panel:SetList() self.panel:Update() return false else return true end end function M.UI.Page:ResetPage() self.panel.offset = 0 end function M.UI.Page:SetSort(sortby,asc) self.sort = sortby self.asc = asc end function M.UI.Page:SetDKP(dkp) self.dkp = dkp end function M.UI.Page:SetClassFilter(classFilter) self.classFilter = classFilter end function M.UI.Page:Update() if self.pageType == "Option" then return end local rawList = M.Data[self.pageType.."s"] rawList = rawList and rawList:GetUndeleted() rawList = self:DoFilter(rawList) if self.sort and rawList then rawList:Sort(self.sort,self.asc) end self.panel:SetList(rawList) self.panel:Update() end function M.UI.Page:DoFilter(list) return list end function M.UI.Page:GetCurrentEntity() if self.pageType =="Option" then return end local current = self.panel:GetCurrent() if current then assert(current:GetType() == self.pageType or (current:GetType()=='DKPMember' or current:GetType()=='Member' and self.pageType =='DKP')) return current end end function M.UI.Page:SetCurrentEntity(e) self.panel:SetCurrent(e) end function M.UI.Page:OnDeleteButtonClick() if self.pageType =="Option" then return end if self:GetCurrentEntity() then M.U:SafePopup_Show(_G["MiDKP_DIALOG_CONFIRM_DELETE_"..string.upper(self.pageType)],self:GetCurrentEntity():GetName()) end end function M.UI.Page:OnModifyButtonClick() if self.pageType =="Option" then return end if not self:GetCurrentEntity() then return end M.UI.EditPanel:SetEntity(self:GetCurrentEntity()) M.UI.EditPanel:Show() M.UI.EditPanel:SetFocus(1) end function M.UI.Page:OnButtonDeleted() if self.pageType == 'Raid' and self.panel:GetCurrent():IsActivated() then M.DO.Raid:Deactivate() end self.panel:OnButtonDeleted() end function M.UI.Page:BindButtons() self.actionButton = _G[self.ui:GetName().."Action"] self.deleteButton = _G[self.ui:GetName().."Delete"] self.modifyButton = _G[self.ui:GetName().."Modify"] if self.pageType ~='Raid' then self.createButton = _G[self.ui:GetName().."Create"] end self.createEventButton = _G[self.ui:GetName().."CreateEvent"] self.iitemButton = _G[self.ui:GetName().."AddToIItem"] end function M.UI.Page:ToggleActivateButtons(tog) local toggle = function(but,tog) if but then if tog then but:Enable() else but:Disable() end end end toggle(self.actionButton,tog) toggle(self.deleteButton,tog) toggle(self.modifyButton,tog) toggle(self.createButton,tog) toggle(self.createEventButton,tog) toggle(self.iitemButton,tog) end function M.UI.Page:ToggleEntityButtons(tog) local toggle = function(but,tog) if but then if tog then but:Enable() else but:Disable() end end end toggle(self.actionButton,tog) toggle(self.deleteButton,tog) toggle(self.modifyButton,tog) toggle(self.createEventButton,tog) toggle(self.iitemButton,tog) end function M.UI.Page.EntityToggle(page,tag) page:ToggleEntityButtons(tag) end function M.UI.Page:CheckButtons() if not self:CheckData() then self:ToggleActivateButtons(false) return end self:ToggleActivateButtons(true) if self:GetCurrentEntity() then self:ToggleEntityButtons(true) else self:ToggleEntityButtons(false) end end function M.UI.Page.OnRaidActivated() M.UI.Member.panel:ClearCurrent() M.UI.Item.panel:ClearCurrent() M.UI.Event.panel:ClearCurrent() end M.UI.Raid = inheri(M.UI.Page,"Raid") function M.UI.Raid:OnShow() self.panel:Collapse() self:ResetPage() self:Update() self:CheckButtons() end function M.UI.Raid:OnCreateButtonClick() M.UI.RaidEditPanel:NewRaid() M.UI.RaidEditPanel:Show() end function M.UI.Raid:OnModifyButtonClick() if not self:GetCurrentEntity() then return end M.UI.RaidEditPanel:SetRaid(M.UI.Raid:GetCurrentEntity()) M.UI.RaidEditPanel:Show() end function M.UI.Raid:OnActionButtonClick() if not self:GetCurrentEntity() then return end local raid = self:GetCurrentEntity() if raid:GetStatus() == MIDKP_STAT_INITED then M.DO.Raid:StartRaid(raid) elseif raid:GetStatus() == MIDKP_STAT_STARTED then M.U:SafePopup_Show(_G["MiDKP_DIALOG_CONFIRM_RAID_END"],self:GetCurrentEntity():GetName()) elseif raid:GetStatus() == MIDKP_STAT_ENDED then M.UI.ExportFrame:SetText(raid:Export()) M.UI.ExportFrame:Show() else end M.E:FireEvent("RAID_SELECTED",raid) self:Update() end function M.UI.Raid:OnActiveButtonClick(ui) local raid = ui:GetParent().widget:GetEntity() if raid then M.DO.Raid:ActivateRaid(raid) end self:Update() end function M.UI.Raid.OnSelectedRaidChange(raid) local actionButton = _G[M.UI.Raid.ui:GetName().."Action"] if not actionButton then end if not raid then return end if raid:GetStatus() == MIDKP_STAT_INITED then actionButton:SetText(M.L.RAID_PAGE_BTN_START ) elseif raid:GetStatus() == MIDKP_STAT_STARTED then actionButton:SetText(M.L.RAID_PAGE_BTN_END) elseif raid:GetStatus() == MIDKP_STAT_ENDED then actionButton:SetText(M.L.RAID_PAGE_BTN_EXPORT) end end function M.UI.Raid.OnMenuModifyButtonClick() M.UI.Raid:OnModifyButtonClick() end function M.UI.Raid.OnMenuDeleteButtonClick() M.UI.Raid:OnDeleteButtonClick() end M.UI.Member = inheri(M.UI.Page, "Member") function M.UI.Member:OnShow() self:CheckButtons() if not self:OnShowCheckData() then return end self.panel:Collapse() self:SetClassFilter(self.classDD:GetVal()) self:Update() end function M.UI.Member:OnAddMemberButtonClick() if not self:CheckData() then return end M.UI.MemberEditPanel:NewMember() M.UI.MemberEditPanel:Show() end function M.UI.Member:OnCreateEventButtonClick() if not self:CheckData() then return end M.UI.EditPanel:NewEvent(self:GetCurrentEntity()) M.UI.EditPanel.fromMemberPage = true M.UI.EditPanel:Show() M.UI.EditPanel:SetFocus(1) end function M.UI.Member.OnColumnHeaderClick(sortType,asc) M.UI.Member:SetSort(sortType,asc) M.UI.Member:Update() end function M.UI.Member:OnLoad() self:Load() self.classDD = _G[self.ui:GetName().."ColumnHeader2"].widget self.classDD:SetParent(self) self.classDD:SetSingle(false) self:SetSort('totaldkp',true) end function M.UI.Member.OnMenuCreateEventButtonClick() M.UI.Member:OnCreateEventButtonClick() end function M.UI.Member.OnMenuDeleteButtonClick() M.UI.Member:OnDeleteButtonClick() end function M.UI.Member.CancelMainMenuFuc() local main = M.UI.Member:GetCurrentEntity():GetMain() M.DO.Member:CancelMinor(M.UI.Member:GetCurrentEntity()) M.UI.Member:SetCurrentEntity(main) M.DO.Raid:UpdateMembers() if not main:GetInRaid() then M.U:SafePopup_Show(_G["MiDKP_DIALOG_CONFIRM_DELETE_MAIN"],M.UI.Member:GetCurrentEntity():GetName()) else M.UI.Member:Update() end end function M.UI.Member.SetMainMenuFunc(button) if not M.UI.Member:GetCurrentEntity() then return end if not button.value then return end M.DO.Member:SetMain(M.UI.Member:GetCurrentEntity(),button.value) M.UI.Member:Update() end function M.UI.Member:DoFilter(list) if self.classFilter and list then list = list:FilterClass(self.classFilter) end return list end M.UI.Event = inheri(M.UI.Page,"Event") function M.UI.Event:OnShow() self:CheckButtons() if not self:OnShowCheckData() then return end self:Update() end function M.UI.Event:OnCreateButtonClick() if not self:CheckData() then return end M.UI.EditPanel:NewEvent() M.UI.EditPanel:Show() M.UI.EditPanel:SetFocus(1) end function M.UI.Event.OnMenuModifyButtonClick() M.UI.Event:OnModifyButtonClick() end function M.UI.Event.OnMenuDeleteButtonClick() M.UI.Event:OnDeleteButtonClick() end M.UI.Item = inheri(M.UI.Page, "Item") function M.UI.Item:OnShow() self:CheckButtons() if not self:OnShowCheckData() then return end self:ResetPage() self:Update() end function M.UI.Item:OnCreateButtonClick() if not self:CheckData() then return end M.UI.EditPanel:NewItem() M.UI.EditPanel:Show() M.UI.EditPanel:SetFocus(1) end function M.UI.Item:OnAddToIIListClick() if self:GetCurrentEntity() then local iitem = M.OO.IItem:Create(self:GetCurrentEntity():GetPlainName()) M.DO.Config:AddIgnoredItem(iitem) M.E:FireEvent("ITEM_ADDED_TO_IITEM",iitem) end end function M.UI.Item.OnMenuModifyButtonClick() M.UI.Item:OnModifyButtonClick() end function M.UI.Item.OnMenuDeleteButtonClick() M.UI.Item:OnDeleteButtonClick() end function M.UI.Item.OnMenuAddToIIListClick() M.U:SafePopup_Show(_G["MiDKP_DIALOG_CONFIRM_ITEM_ADD_IGNORE_ITEM"],M.UI.Item:GetCurrentEntity():GetName()) end M.UI.Option = inheri(M.UI.Page,"Option") function M.UI.Option:OnLoad() self.itemQualityCheck = M.Widget.CheckButtonGroup:Create( M.Widget.CheckButtonGroup:ArrayToCheckListFormat(MIDKP_OPTION_ITEM_QUALITY), true, self.ui, "Quality") self.eventActionCheck = M.Widget.CheckButtonGroup:Create( M.Widget.CheckButtonGroup:ArrayToCheckListFormat(MIDKP_OPTION_EVENT_ACTIONS), true, self.ui, "EventAction") self.defaultGroupCheck = M.Widget.CheckButtonGroup:Create( M.Widget.CheckButtonGroup:ArrayToCheckListFormat(MIDKP_OPTION_GROUP_DEFAULT), true, self.ui, "DefaultGroup") self.eventNotifyCheck = M.Widget.CheckButtonGroup:Create( M.Widget.CheckButtonGroup:ArrayToCheckListFormat(MIDKP_OPTION_EVENT_NOTIFY), true, self.ui, "EventNotify") self.itemQualityCheck:SetPoint(self.ui,50,-90,80,4) self.eventActionCheck:SetPoint(self.ui,50,-220,110,3) self.defaultGroupCheck:SetPoint(self.ui,50,-280,110,3) self.eventNotifyCheck:SetPoint(self.ui,50,-393,110,3) self.whisperCheck = M.Widget.SingleCheckButton:Create(_G[self.ui:GetName().."Whisper"]) self.whisperHideCheck = M.Widget.SingleCheckButton:Create(_G[self.ui:GetName().."HideWhisper"]) self.disconnectedCheck = M.Widget.SingleCheckButton:Create(_G[self.ui:GetName().."EventMemberDisconnected"]) self.splitCheck = M.Widget.SingleCheckButton:Create(_G[self.ui:GetName().."PointsSplit"]) self.useHistoryCheck = M.Widget.SingleCheckButton:Create(_G[self.ui:GetName().."UseHistoryPoint"]) self.whisperEdit = _G[self.ui:GetName().."WhisperEditBox"] self.itemQualityCheck:SetClickScript(function(ui) M.DO.Config:SetConfig("item_quality",ui.id) end) self.eventActionCheck:SetClickScript(function (ui) M.DO.Config:SetConfig("event_action",ui.id) end) self.defaultGroupCheck:SetClickScript(function(ui) M.DO.Config:SetConfig("default_group",ui.id) if ui.id == 3 then self.disconnectedCheck:Disable() else self.disconnectedCheck:Enable() end end) self.eventNotifyCheck:SetClickScript(function(ui) M.DO.Config:SetConfig("event_notify",ui.id) end) self.useHistoryCheck:HookConfig("use_history") self.whisperCheck:HookConfig("whisper_enable") self.whisperHideCheck:HookConfig("hide_whisper_reply") self.disconnectedCheck:HookConfig("member_record_disconnected") self.splitCheck:HookConfig("default_split") end function M.UI.Option:OnShow() self.itemQualityCheck:SetCheckButtons(M.DO.Config:GetConfig("item_quality")) self.eventActionCheck:SetCheckButtons(M.DO.Config:GetConfig("event_action")) self.defaultGroupCheck:SetCheckButtons(M.DO.Config:GetConfig("default_group")) self.eventNotifyCheck:SetCheckButtons(M.DO.Config:GetConfig("event_notify")) self.whisperEdit:SetText(M.DO.Config:GetConfig('whisper_command')) self.itemQualityCheck:Show() self.eventActionCheck:Show() self.defaultGroupCheck:Show() self.eventNotifyCheck:Show() self.whisperCheck:Show() self.whisperHideCheck:Show() self.disconnectedCheck:Show() self.splitCheck:Show() self.useHistoryCheck:Show() end function M.UI.Option:OnIgnoreItemsButtonClick() M.UI.IgnoreItem:Show() end function M.UI.Option:OnWhisperEditBoxLostFocus(ui) local text = ui:GetText() local matched = string.match(text, "^ *([a-zA-Z0-9]+) *$") if matched then ui.text = matched M.DO.Config:SetConfig('whisper_command',ui.text) else ui:SetText(M.DO.Config:GetConfig('whisper_command')) end end M.UI.DKP = inheri(M.UI.Page,"DKP") M.UI.DKP.CHANNEL_LIST = { 'RAID', 'GUILD', 'OFFICER', 'PARTY', } function M.UI.DKP:CheckRaidOnly() if not self.dkp or self.dkp ==0 then self.raidOnlyCheck:Hide() else self.raidOnlyCheck:Show() end end function M.UI.DKP:DoFilter(list) self:CheckRaidOnly() local rawList = M.DO.DKP:GetSuite(self.dkp) if M.DO.Config:GetConfig("show_raid_only") and rawList then rawList = rawList:FilterMember(M.Data.Members) end if self.classFilter then if rawList then rawList = rawList:FilterClass(self.classFilter) end end return rawList end function M.UI.DKP:OnShow() self:CheckRaidOnly() if not self:OnShowCheckData() and self.dkp ==0 then return end self:ResetPage() self:Update() end function M.UI.DKP:OnConfigButtonClick() self.announce:Show() end function M.UI.DKP:OnAnnounceButtonClick() if not(self.dkp) or self.dkp ==0 then M.DO.Chat:DoSend( 'Members', self.CHANNEL_LIST[M.DO.Config:GetConfig('announce_to_channel')], false, self:GetPanel():GetList() ) else M.DO.Chat:DoSend( 'MembersHistory', self.CHANNEL_LIST[M.DO.Config:GetConfig('announce_to_channel')], false, self:GetPanel():GetList(), self.dkp ) end end function M.UI.DKP.OnColumnHeaderClick(headerType,asc) M.UI.DKP:SetSort(headerType,asc) M.UI.DKP:Update() end function M.UI.DKP:OnAnnounceLoad() self.announce = _G.MiDKP3AnnounceConfigFrame self.announceContentCheck = M.Widget.CheckButtonGroup:Create( M.Widget.CheckButtonGroup:ArrayToCheckListFormat(MIDKP_DKP_ANNOUNCE_CONTENT), false, self.announce, "Content") self.announceWhisperCheck = M.Widget.CheckButtonGroup:Create( M.Widget.CheckButtonGroup:ArrayToCheckListFormat(MIDKP_DKP_ANNOUNCE_CONTENT), false, self.announce, "Whisper") self.announceTargetCheck = M.Widget.CheckButtonGroup:Create( M.Widget.CheckButtonGroup:ArrayToCheckListFormat(MIDKP_DKP_ANNOUNCE_CHANNEL), true, self.announce, "Target") self.announceTargetCheck:SetPoint(self.announce,50,-75,100,4) self.announceContentCheck:SetPoint(self.announce,50,-140,120,1) self.announceWhisperCheck:SetPoint(self.announce, 305,-140,120,1) end function M.UI.DKP:OnAnnounceShow() self.announceHistoryCheck = M.Widget.CheckButtonGroup:Create( M.Widget.CheckButtonGroup:ArrayToCheckListFormat(M.DO.DKP:GetNameArray():ToArray()), false, self.announce, "Suites") self.announceContentCheck:SetCheckButtons({M.DO.Config:GetConfig("announce_content")}) self.announceWhisperCheck:SetCheckButtons({M.DO.Config:GetConfig("whisper_content")}) self.announceTargetCheck:SetCheckButtons(M.DO.Config:GetConfig("announce_to_channel")) self.announceHistoryCheck:SetCheckButtons({M.DO.Config:GetConfig("dkpsuite_announced")}) self.announceHistoryCheck:SetPoint(self.announce,50,-255,150,3) self.announceContentCheck:Show() self.announceWhisperCheck:Show() self.announceTargetCheck:Show() self.announceHistoryCheck:Show() end function M.UI.DKP:OnAnnounceOK() local getContentTable=function(t) local newt = {} for _i,_v in pairs(t) do newt[_i] = _v[1] end return newt end M.DO.Config:SetConfig("announce_to_channel",self.announceTargetCheck:GetVal()) M.DO.Config:SetConfig("announce_content",getContentTable(self.announceContentCheck:GetVal())) M.DO.Config:SetConfig("whisper_content",getContentTable(self.announceWhisperCheck:GetVal())) M.DO.Config:SetConfig("dkpsuite_announced",getContentTable(self.announceHistoryCheck:GetVal())) self.announce:Hide() end function M.UI.DKP:OnAnnounceCancel() self.announce:Hide() end function M.UI.DKP:OnLoad() self:Load() self.raidOnlyCheck =M.Widget.SingleCheckButton:Create(_G[self.ui:GetName().."OnlyRaid"]) self.raidOnlyCheck:HookConfig("show_raid_only") self.raidOnlyCheck:HookScript(function(ui) self:ResetPage() self:Update() end) self.classDD = _G[self.ui:GetName().."ColumnHeader2"].widget self.classDD:SetParent(self) self.classDD:SetSingle(false) self.dkpDD = _G[self.ui:GetName().."ColumnHeader3"].widget self.dkpDD:SetParent(self) self.dkpDD:SetSingle(true) if M.DO.Config:GetConfig("use_history") then self:SetSort("leftPoint",true) else self:SetSort("totaldkp",true) end end function M.UI.DKP:OnSendClick(target,rtype,showReply) if not(self.dkp) or self.dkp ==0 then M.DO.Chat:DoSend( rtype..'Current', target, showReply, M.UI.DKP:GetCurrentEntity() ) else M.DO.Chat:DoSend( rtype..'History', target, showReply, M.UI.DKP:GetCurrentEntity(), self.dkp ) end end function M.UI.DKP.OnSendToPersonClick() M.UI.DKP:OnSendClick(M.UI.DKP:GetCurrentEntity(),'Self',true) end function M.UI.DKP.OnSendToPartyClick() M.UI.DKP:OnSendClick('PARTY','Member') end function M.UI.DKP.OnSendToGuildClick() M.UI.DKP:OnSendClick('GUILD','Member') end function M.UI.DKP.OnSendToRaidClick() M.UI.DKP:OnSendClick('RAID','Member') end M.UI.EditPanel = {} function M.UI.EditPanel:Show() if self.entity then M.UI.NotifyList:DeleteNotify(self.entity) end M.DO.Raid:UpdateMembers() local membersList = M.Data.Members:GetUndeleted() self.memberCheck = M.Widget.CheckButtonGroup:Create( M.Widget.CheckButtonGroup:ArrayToCheckListFormat(membersList:ToArray()), self.entity:GetType() == 'Item', self.innerFrame, "Member" ) self.line = ceil(membersList:Count() /3) self.nameBox:SetText(self.entity:GetName()) self.pointBox:SetText(self.entity:GetPoint()) self.innerFrame:SetHeight(30 + self.line * 30); self.ui:SetHeight(270 + self.line * 30); if self.entity:GetType() =='Item' then self.splitCheck:SetChecked(nil) if self.isNew then self.splitCheck:SetChecked(M.DO.Config:GetConfig("default_split") and true) else self.splitCheck:SetChecked(self.entity:GetEvent() and true) end self.memberCheck:SetCheckButtons(membersList,true) self.splitCheck:Show() self.memberCheck:SetCheckButtons(self.entity:GetMember()) self.groupCheck:Hide() self.bossCheck:Hide() self.nameBox:EnableKeyboard(true) self.pointBox:EnableKeyboard(true) elseif self.entity:GetType() =='Event' then self.splitCheck:Hide() self.memberCheck:SetCheckButtons(self.entity:GetRealMemberList()) self.memberCheck:SetCheckButtons(membersList:GetMainMemberList(),true) self.groupCheck:SetCheckButtons(M.DO.Config:GetConfig('default_group')) self.groupCheck:Show() self.bossCheck:Show() self.bossCheck:SetChecked(false) self.bossCheck:Enable() self.nameBox:EnableKeyboard(true) self.pointBox:EnableKeyboard(true) if self.entity:IsEventDrive() then self.bossCheck:SetChecked(true) self.bossCheck:Disable() elseif self.entity:GetBoss() then self.bossCheck:SetChecked(true) end if self.entity:IsItemDrive() then self.bossCheck:Hide() self.memberCheck:SetClickScript(function() local memberList = M.OO.MemberList:Create() memberList : SetData(self.memberCheck:GetVal()) if memberList:Count() >0 then self.pointBox:SetText(string.twodigitfloat(self.entity:GetItem():GetPoint()/memberList:Count())) end end) self.nameBox:EnableKeyboard(false) self.pointBox:EnableKeyboard(false) else self.nameBox:EnableKeyboard(true) self.pointBox:EnableKeyboard(true) end end self.memberCheck:SetPoint(self.innerFrame, 15,-10,150,3) self.memberCheck:Show() self.ui:Show() end function M.UI.EditPanel:SetFocus(index) if index == 1 then self.nameBox:SetFocus() elseif index ==2 then self.pointBox:SetFocus() end end function M.UI.EditPanel:NewEvent(member) self.isNew = true self.nameHeader:SetText(M.L.EDIT_ADD_EVENT) self.entity = M.OO.Event:Create(false,false,0,"") local memberList = M.OO.MemberList:Create() if member then memberList:Add(member) else memberList = M.DO.Member:GetDefaultMemberList() end self.entity:SetMemberList(memberList) end function M.UI.EditPanel:NewItem() self.isNew = true self.nameHeader:SetText(M.L.EDIT_ADD_ITEM ) self.entity = M.OO.Item:Create("",0) end function M.UI.EditPanel:SetEntity(entity) self.isNew = false if not entity then return end self.entity = entity if self.entity:GetType() == 'Item' then self.nameHeader:SetText(M.L.EDIT_MODIFY_ITEM) elseif self.entity:GetType() == 'Event' then self.nameHeader:SetText(M.L.EDIT_MODIFY_EVENT) end end function M.UI.EditPanel:OnHide() if self.memberCheck then self.memberCheck:Hide() end end function M.UI.EditPanel:OnOkClick() local memberList,member local point = M.U:ParsePoint(self.pointBox:GetText()) M.E:Assert(string.len(self.nameBox:GetText())>0,string.upper(self.entity:GetType()).."_INVALID") if self.entity:GetType() == 'Item' then M.E:Assert(point>=0,"ITEM_INVALIDPOINT") _,_,member = self.memberCheck:GetVal() M.DO.Item:ModifyItem(self.entity, self.nameBox:GetText(), point, member, self.splitCheck:GetChecked()) M.DO.Item:AddItem(self.entity) self.ui:Hide() M.UI.Item:GetPanel():SetCurrent(self.entity) M.UI.Item:Update() M.UI.Item:CheckButtons() return elseif self.entity:GetType() == 'Event' then if self.bossCheck:GetChecked() then M.E:Assert(point>=0,"EVENT_INVALIDPOINT") end memberList = M.OO.MemberList:Create() memberList : SetData(self.memberCheck:GetVal()) M.DO.Event:ModifyEvent(self.entity, self.nameBox:GetText(), memberList, self.bossCheck:GetChecked(), point) if self.bossCheck:GetChecked() then M.OO.Event.tempScore = point end M.DO.Event:AddEvent(self.entity) self.ui:Hide() M.UI.Event:GetPanel():SetCurrent(self.entity) M.UI.Event:Update() M.UI.Event:CheckButtons() M.DO.Chat:OnEventModified(self.entity) if self.fromMemberPage then M.UI.Member:Update() M.UI.Member:CheckButtons() self.fromMemberPage = false end end end function M.UI.EditPanel:OnLoad() self.ui = _G.MiDKP3EditPanel self.nameHeader = _G[self.ui:GetName().."Header"] self.nameBox = _G[self.ui:GetName().."Text"] self.pointBox = _G[self.ui:GetName().."Point"] self.innerFrame = _G[self.ui:GetName().."InnerFrame"] self.bossCheck = _G[self.ui:GetName().."BossEvent"] self.splitCheck = _G[self.ui:GetName().."SplitPoints"] self.groupCheck = M.Widget.CheckButtonGroup:Create( M.Widget.CheckButtonGroup:ArrayToCheckListFormat(MIDKP_GROUP_OPIONS), true, self.ui, "Group" ) self.groupCheck:SetPoint(self.ui, 30,-155,80,5) self.groupCheck:SetClickScript(function(ui) if (ui.id == 1) then self.memberCheck:SetCheckButtons(M.Data.Members:GetInFirstFive(M.DO.Config:GetConfig("member_record_disconnected"))) elseif (ui.id == 2) then self.memberCheck:SetCheckButtons(M.Data.Members:GetInRaid(M.DO.Config:GetConfig("member_record_disconnected"))) elseif(ui.id == 3) then self.memberCheck:SetCheckButtons(M.Data.Members:GetMainMemberList()) elseif(ui.id == 4) then self.memberCheck:SetCheckButtons(M.Data.Members:GetLastThree(M.DO.Config:GetConfig("member_record_disconnected"))) elseif(ui.id ==5) then self.memberCheck:ReverseChecks() end end) self.innerFrame = _G[self.ui:GetName().."InnerFrame"] end function M.UI.EditPanel:OnEditBoxEnter() end function M.UI.EditPanel:OnEditBoxLeave() end M.UI.RaidEditPanel = {} function M.UI.RaidEditPanel:Show() self.checkbox = M.Widget.CheckButtonGroup:Create( M.Widget.CheckButtonGroup:ArrayToCheckListFormat(M.DO.DKP:GetNameArray():ToArray()), true, self.innerFrame, "Raid" ) self.line = ceil(M.Data.Suites:Count() /3) self.editbox:SetText(self.raid:GetName()) self.editbox:SetFocus() self.editbox:HighlightText() if self.line > 0 then self.innerFrame:SetHeight(30 + self.line * 30); self.ui:SetHeight(205 + self.line * 30); self.suiteHeader:Show(); self.innerFrame:Show() self.checkbox:SetCheckButtons(self.raid:GetDKP() and self.raid:GetDKP():GetName()) self.checkbox:SetPoint(self.innerFrame, 15,-10,150,3) self.checkbox:Show() else self.suiteHeader:Hide(); self.innerFrame:Hide() self.ui:SetHeight(180); end self.ui:Show() end function M.UI.RaidEditPanel:NewRaid() self.nameHeader:SetText(M.L.RAID_CREATE) self.raid = M.OO.Raid:Create() self.raid:Modify(self.raid:GetName(),M.Data.Suites:Get(1)) end function M.UI.RaidEditPanel:SetRaid(raid) self.nameHeader:SetText(M.L.RAID_MODIFY) self.raid = raid end function M.UI.RaidEditPanel:GetRaid() return self.raid end function M.UI.RaidEditPanel:OnOkClick() self.raid:Modify(self.editbox:GetText(),select(3,self.checkbox:GetVal())) M.DO.Raid:AddRaid(self.raid) self.ui:Hide() M.UI.Raid:GetPanel():SetCurrent(self.raid) M.UI.Raid:CheckButtons() M.E:FireEvent("RAID_SELECTED",self.raid) M.UI.Raid:Update() end function M.UI.RaidEditPanel:OnLoad() self.ui = _G.MiDKP3RaidEditFrame self.editbox = _G[self.ui:GetName().."Text"] self.nameHeader = _G[self.ui:GetName().."Header"] self.suiteHeader = _G[self.ui:GetName().."SetHeader"] self.innerFrame = _G[self.ui:GetName().."InnerFrame"] end M.UI.MemberEditPanel = {} function M.UI.MemberEditPanel:Show() self.line = 4 self.editbox:SetText("") self.editbox:SetFocus() self.editbox:HighlightText() self.innerFrame:SetHeight(30 + self.line * 30); self.ui:SetHeight(205 + self.line * 30); self.classHeader:Show(); self.innerFrame:Show() self.checkbox:SetCheckButtons(1) self.checkbox:SetPoint(self.innerFrame, 15,-10,150,3) self.checkbox:Show() self.ui:Show() end function M.UI.MemberEditPanel:NewMember() self.nameHeader:SetText(M.L.MEMBER_PAGE_ADDMEMBER) self.member = M.OO.Member:Create("",M.OO.Class.UNKNOWN ) end function M.UI.MemberEditPanel:SetMember(member) self.member = member end function M.UI.MemberEditPanel:GetMember() return self.member end function M.UI.MemberEditPanel:OnOkClick() local _,_,class = self.checkbox:GetVal() M.E:Assert(M.U:IsValidName(self.editbox:GetText()),"MEMBER_INVALIDNAME") local player =M.DO.Member:FindPlayer(self.editbox:GetText()) if player and class==M.OO.Class.UNKNOWN then self.member:Modify(self.editbox:GetText(),player:GetClass()) else self.member:Modify(self.editbox:GetText(),class) end local member = M.Data.Members:Find(self.member) M.E:Assert(not member or member:IsDeleted() ,"MEMBER_INLIST",self.member) M.DO.Member:AddMember(self.member,true) self.ui:Hide() M.UI.Member:GetPanel():SetCurrent(self.member) M.UI.Member:Update() end function M.UI.MemberEditPanel:OnLoad() self.ui = _G.MiDKP3MemberEditFrame self.editbox = _G[self.ui:GetName().."Text"] self.nameHeader = _G[self.ui:GetName().."Header"] self.classHeader = _G[self.ui:GetName().."SetHeader"] self.innerFrame = _G[self.ui:GetName().."InnerFrame"] self.checkbox = M.Widget.CheckButtonGroup:Create( M.Widget.CheckButtonGroup:ArrayToCheckListFormat(M.OO.Class.ClassTable), true, self.innerFrame, "Class" ) end M.UI.ExportFrame = {} function M.UI.ExportFrame:SetText(text) self.textEdit.text = text end function M.UI.ExportFrame:Show() self.ui:Show() end function M.UI.ExportFrame:Load() self.textEdit = _G.MiDKP3ExportFrameText self.ui = _G.MiDKP3ExportFrame end M.UI.IgnoreItem = {} function M.UI.IgnoreItem:Show() self.ui:Show() end function M.UI.IgnoreItem:Hide() self.ui:Hide() end function M.UI.IgnoreItem:Load() self.ui = _G['MiDKP3IgnoreItemsFrame'] self.pageType = "IItem" self.panel = M.Widget.Panel:Create(self.pageType) self.panel:BindUI(self.ui) self.panel:SetParent(self) self.sort = 'name' self.asc = false end function M.UI.IgnoreItem:ResetPage() self.panel.offset = 0 end function M.UI.IgnoreItem:OnShow() self:ResetPage() self:Update() end function M.UI.IgnoreItem:Update() self.panel:SetList(M.DO.Config:GetIgnoredItems()) self.panel:Update() end function M.UI.IgnoreItem:OnNewItemClick() M.U:SafePopup_Show(_G["MiDKP_DIALOG_CREATE_IGNORE_ITEM"]) end function M.UI.IgnoreItem:OnDeleteItemClick() local current = self.panel:GetCurrent() if current then M.U:SafePopup_Show(_G["MiDKP_DIALOG_CONFIRM_DELETE_IGNORE_ITEM"],current:GetName()) end end function M.UI.IgnoreItem:OnDefaultItemClick() M.U:SafePopup_Show(_G["MiDKP_DIALOG_CONFIRM_RESTORE_IGNORE_ITEMS"]) end M.UI.Pages={ [1] = M.UI.Raid, [2] = M.UI.Member, [3] = M.UI.Event, [4] = M.UI.Item, [5] = M.UI.Option, [6] = M.UI.DKP, } M.UI.Util = {} function M.UI.Util:OnMiniButtonClick(ui) M.UI.Frame:Toggle() end function M.UI.Util:OnMiniButtonUpdate(ui,elapsed) end function M.UI.Util:SetMainFrameEnable(t) if (t) then MiDKP3MainFrameDisableMask:Hide(); else MiDKP3MainFrameDisableMask:Show(); end end M.UI.TabGroup = {} function M.UI.TabGroup:OnTabClick(id) self:OnTabSelected(id) for _i = 1, 6 do if id == _i then M.UI.Pages[_i]:Show() else M.UI.Pages[_i]:Hide() end end end function M.UI.TabGroup:OnInit() self.tab={} for i =1 , 6 do local newTab = M.Widget.Tab:Create() newTab:Bind(_G["MiDKP3MainFrameTab"..i]) self.tab[i] = newTab end self:OnTabClick(1) end function M.UI.TabGroup:OnTabSelected(id) for i = 1, 6 do if (i == id) then self.tab[i]:SetRaise() else self.tab[i]:SetLower() end end end 
