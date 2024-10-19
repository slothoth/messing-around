include("InstanceManager")
include("ModalScreen_PlayerYieldsHelper")

-- ================================================================================================================================
--	INSTANCE MANAGER
--	Modified Instance Manager to allow for setable Contexts
-- ================================================================================================================================
Suk_InstanceManager = {}; for k,v in pairs(InstanceManager) do Suk_InstanceManager[k] = v end
--------------------------------------------------------------------------------------------------------
--	Constructor
--------------------------------------------------------------------------------------------------------
Suk_InstanceManager.Base_New = Suk_InstanceManager.new
Suk_InstanceManager.new =
function(self, instanceName, rootControlName, ParentControl, Context)
	local o = Suk_InstanceManager.Base_New(self, instanceName, rootControlName, ParentControl)
	o.m_Context = Context or ContextPtr

	return o
end
--------------------------------------------------------------------------------------------------------
-- Build new instances
--------------------------------------------------------------------------------------------------------
Suk_InstanceManager.BuildInstance = function(self)
	local controlTable = {}

	if(self.m_ParentControl == nil)
	then
		self.m_Context:BuildInstance(self.m_InstanceName, controlTable);
	else
		self.m_Context:BuildInstanceForControl(self.m_InstanceName, controlTable, self.m_ParentControl);
	end

	if(controlTable[self.m_RootControlName] == nil)
	then
		print("Instance Manager built with bad Root Control [" .. self.m_InstanceName .. "] [" .. self.m_RootControlName .. "]");
	end

	controlTable[self.m_RootControlName]:SetHide(true);
	controlTable.m_InstanceManager = self;
	table.insert(self.m_AvailableInstances, controlTable);
	self.m_iAvailableInstances = self.m_iAvailableInstances + 1;

	self.m_iCount = self.m_iCount + 1;
end
--------------------------------------------------------------------------------------------------------
-- Build new instances
--------------------------------------------------------------------------------------------------------
Suk_InstanceManager.DestroyInstances = function(self)

	self:ResetInstances();

	for i = 1, #self.m_AvailableInstances, 1
	do
		local iter = table.remove(self.m_AvailableInstances);
		if(self.m_ParentControl == nil)
		then
			self.m_Context:DestroyChild(iter);
		else
			self.m_ParentControl:DestroyChild(iter[self.m_RootControlName]);
		end
	end

	self.m_iAvailableInstances = 0;

end

-- ================================================================================================================================
--	ADD BUTTON
-- ================================================================================================================================
function RealizeBacking()
	-- The Launch Bar width should accomodate how many hooks are currently in the stack.
	g_.ButtonStack:CalculateSize();
	g_.LaunchBacking:SetSizeX(g_.ButtonStack:GetSizeX()+116);
	g_.LaunchBackingTile:SetSizeX(g_.ButtonStack:GetSizeX()-20);
	g_.LaunchBackingDropShadow:SetSizeX(g_.ButtonStack:GetSizeX());

	-- When we change size of the LaunchBar, we send this LuaEvent to the Diplomacy Ribbon, so that it can change scroll width to accommodate it
	LuaEvents.LaunchBar_Resize(g_.ButtonStack:GetSizeX());
end


function OnLoaded()
	g_.LaunchBar					= 	ContextPtr:LookUpControl("/InGame/LaunchBar")
	g_.ButtonStack					= 	ContextPtr:LookUpControl("/InGame/LaunchBar/ButtonStack")
	g_.LaunchBacking				= 	ContextPtr:LookUpControl("/InGame/LaunchBar/LaunchBacking")
	g_.LaunchBackingDropShadow		= 	ContextPtr:LookUpControl("/InGame/LaunchBar/LaunchBarDropShadow")
	g_.LaunchBackingTile			= 	ContextPtr:LookUpControl("/InGame/LaunchBar/LaunchBackingTile")

	pLaunchBarItemIM				= 	Suk_InstanceManager:new("LaunchBarItem", "LaunchItemButton", g_.ButtonStack, g_.LaunchBar)
	pLaunchBarPinIM					= 	Suk_InstanceManager:new("LaunchBarPinInstance", "Pin", g_.ButtonStack, g_.LaunchBar)

	g_.tButton						=	pLaunchBarItemIM:GetInstance()
										pLaunchBarPinIM:GetInstance()

	----------------------------------------
	g_.tButton.LaunchItemButton:SetTexture("LaunchBar_Hook_GreatWorksButton")
	g_.tButton.LaunchItemButton:SetToolTipString(Locale.Lookup("LOC_SUK_GLOBAL_RELATIONS_SCREEN"))
	g_.tButton.LaunchItemIcon:SetTexture(0, 0, "LaunchBar_Hook_TechTree")
	g_.tButton.LaunchItemButton:RegisterCallback(Mouse.eLClick, OnOpen)
	----------------------------------------

	RealizeBacking()
end

function OnInit(bIsReload)
	Events.LoadScreenClose.Add(OnInit)
	if not ContextPtr:LookUpControl("/InGame/LaunchBar") then return end


	-- Create the Button
	OnLoaded()

	-- Set Vignette size
	m_TopPanelConsideredHeight = Controls.Vignette:GetSizeY() - TOP_PANEL_OFFSET;
	Controls.Vignette:SetSizeY(m_TopPanelConsideredHeight)

	-- Hide the starry BG and set screen title
	Controls.ModalBG:SetHide(true);
	Controls.ModalScreenTitle:SetText(Locale.ToUpper(Locale.Lookup("LOC_SUK_GLOBAL_RELATIONS_SCREEN_TITLE")))

	------------------------------------
	-- Input and Buttons
	------------------------------------
	Controls.ModalScreenClose:RegisterCallback(Mouse.eLClick, OnClose)

	------------------------------------
	------------------------------------
end

------------------------------------------------------------------------------
--	OnShutdown
------------------------------------------------------------------------------
function OnShutdown()
	pLaunchBarItemIM:DestroyInstances()
	pLaunchBarPinIM:DestroyInstances()

	Events.LoadScreenClose.Remove(OnInit)
	Events.InputActionTriggered.Remove(OnInputActionTriggered)
end

function OnInputHandler(pInputStruct)
	local uiMsg = pInputStruct:GetMessageType()
	if (uiMsg == KeyEvents.KeyUp) then return KeyHandler( pInputStruct:GetKey() ) end
	return false
end

function Initialize()
	ContextPtr:SetInitHandler(OnInit)
	ContextPtr:SetShutdown(OnShutdown)
	ContextPtr:SetInputHandler(OnInputHandler, true)
	ContextPtr:SetHide(true)
end
Initialize()