-------------------------------- tasks Menu --------------------------------
-- THIS IS STILL UNFINISHED

net.Receive("tea_opentasksmenu", function()
	GAMEMODE:OpenTasksMenu()
end)

local DoTasksList

function GM:OpenTasksMenu()
	if IsValid(self.TasksPanel) then self.TasksPanel:Remove() end
	local tasks = vgui.Create("DFrame")
	tasks:SetSize(600, 700)
	tasks:Center()
	tasks:SetTitle("Your Tasks")
	tasks:SetDraggable(false)
	tasks:SetVisible(true)
	tasks:SetAlpha(0)
	tasks:AlphaTo(255, 1, 0)
	tasks:ShowCloseButton(true)
	tasks:MakePopup()
	tasks.Paint = function(self)
		draw.RoundedBox(2, 0, 0, self:GetWide(), self:GetTall(), Color(0, 0, 0, 200))
		surface.SetDrawColor(150, 150, 0,255)
		surface.DrawOutlinedRect(0, 0, self:GetWide(), self:GetTall())
	end
	tasks.Think = function(self)
		if input.IsKeyDown(KEY_ESCAPE) and gui.IsGameUIVisible() then
			timer.Simple(0, function()
				self:Remove()
			end)
			gui.HideGameUI()
		end
	end
	
	self.TasksPanel = tasks

	local PropertySheet = vgui.Create("DPropertySheet", tasks)
	PropertySheet:SetPos(5, 25)
	PropertySheet:SetSize(tasks:GetWide() - 10, tasks:GetTall() - 35)
	PropertySheet.Paint = function()
		surface.SetDrawColor(0, 0, 0, 100)
		surface.DrawRect(0, 0, PropertySheet:GetWide(), PropertySheet:GetTall())
		for k, v in pairs(PropertySheet.Items) do
			if (!v.Tab) then continue end
			v.Tab.Paint = function(self,w,h)
				draw.RoundedBox(0, 0, 0, w, h, Color(50,50,25))
			end
		end
	end

	local tasklist = vgui.Create("DPanelList", PropertySheet)
	tasklist:SetSize(PropertySheet:GetWide() - 10, PropertySheet:GetTall() - 35)
	tasklist:SetPos(5, 30)
	tasklist:EnableVerticalScrollbar(true)
	tasklist:EnableHorizontal(true)
	tasklist:SetSpacing(10)

	DoTasksList = function(parent)
		for k, v in pairs(GAMEMODE.Tasks) do
			local selected = GAMEMODE.CurrentTask == k
			local completed = selected and LocalPlayer():HasCompletedTask()

			local taskpanel = vgui.Create("DPanel")
			parent:AddItem(taskpanel)
			taskpanel:SetPos(5, 5)
			taskpanel:SetSize(570, 85)
			taskpanel.Paint = function() -- Paint function
				draw.RoundedBoxEx(8,1,1,taskpanel:GetWide()-2,taskpanel:GetTall()-2,Color(0, 0, 0, 50), false, false, false, false)
				surface.SetDrawColor(50, 50, 50,255)
				surface.DrawOutlinedRect(0, 0, taskpanel:GetWide(), taskpanel:GetTall())
			end
			taskpanel.Task = k

			local ItemName = vgui.Create("DLabel", taskpanel)
			ItemName:SetFont("TargetID")
			ItemName:SetPos(10, 10)
			ItemName:SetText("Task: "..v.Name)
			ItemName:SizeToContents()

			local ItemCost = vgui.Create("DLabel", taskpanel)
			ItemCost:SetFont("TargetIDSmall")
			ItemCost:SetPos(10, 30)
			ItemCost:SetColor(Color(155,255,155,255))
			ItemCost:SetText(v.Description)
			ItemCost:SizeToContents()

			local ItemWeight = vgui.Create("DLabel", taskpanel)
			ItemWeight:SetFont("TargetIDSmall")
			ItemWeight:SetPos(10, 47)
			ItemWeight:SetColor(Color(155,155,255,255))
			ItemWeight:SetText("Reward: "..v.RewardText)
			ItemWeight:SizeToContents()

			local ItemSupply = vgui.Create("DLabel", taskpanel)
			ItemSupply:SetFont("TargetIDSmall")
			ItemSupply:SetPos(10, 64)
			ItemSupply:SetText("Cooldown: ".. v.Cooldown / 3600 .." hours ; Level requirement: "..v.LevelReq)
			ItemSupply:SetColor(Color(255,155,155,255))
			ItemSupply:SizeToContents()


			local viewb = vgui.Create("DButton", taskpanel)
			viewb:SetSize(80, 40)
			viewb:SetPos(450, 30)
			viewb:SetText(completed and "Finish" or selected and "Cancel" or "Accept")
			viewb:SetTextColor(Color(255, 255, 255, 255))
			viewb.Paint = function(panel)
				surface.SetDrawColor(0, 150, 0,255)
				surface.DrawOutlinedRect(0, 0, viewb:GetWide(), viewb:GetTall())
				draw.RoundedBox(2, 0, 0, viewb:GetWide(), viewb:GetTall(), Color(0, 50, 0, 130))
			end
			viewb.DoClick = function()
				if completed then
					net.Start("tea_taskfinish")
					net.WriteString(taskpanel.Task)
					net.SendToServer()
				elseif selected then
					net.Start("tea_taskcancel")
					net.WriteString(taskpanel.Task)
					net.SendToServer()
				else
					net.Start("tea_taskassign")
					net.WriteString(taskpanel.Task)
					net.SendToServer()
				end

			end
		end
	end
	DoTasksList(tasklist)


	PropertySheet:AddSheet("Tasks list", tasklist, "icon16/briefcase.png", false, false, "List of tasks that can be done")
end

