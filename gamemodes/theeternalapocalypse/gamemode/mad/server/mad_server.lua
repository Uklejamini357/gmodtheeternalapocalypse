local PlayerMeta = FindMetaTable("Player")

-- Why does this exist?!?!?

function PlayerMeta:SendMessage(text, duration, color)

	local duration = duration or 3
	local color = color or Color(255, 255, 255, 255)

	umsg.Start("rp_sendmessage", self)
	umsg.String(text)
	umsg.Short(duration)
	umsg.String(color.r .. ", " .. color.g .. ", " .. color.b .. ", " .. color.a)
	umsg.End()
end

function SendMessageAll(text, duration, color)

	for k, v in pairs(player.GetAll()) do
		v:SendMessage(text, duration, color)
	end
end