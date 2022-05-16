-- Psudar aka Parker
-- 16 May 2022
-- TypeWriter Class
-- Incrementally sets the text of a given GuiObject

--\\ Constant //--

local DEFAULT_RATE = 1/12
local DEFAULT_STEP = 1

local SOUND_FOLDER = Instance.new("Folder")
SOUND_FOLDER.Name = "DefaultTypeWriterSounds"
SOUND_FOLDER.Parent = workspace

local SOUND_A = Instance.new("Sound")
SOUND_A.SoundId = "rbxassetid://9119983674"
SOUND_A.Parent = SOUND_FOLDER

local SOUND_B = Instance.new("Sound")
SOUND_B.SoundId = "rbxassetid://9119982758"
SOUND_B.Parent = SOUND_FOLDER

local DEFAULT_SOUNDS = {SOUND_A, SOUND_B}

--\\ Module //--

local TypeWriter = {}
TypeWriter.__index = TypeWriter

--\\ Public //--

function TypeWriter.new(textGui, sounds, rate, step)
	local writer = {}
	writer._textGui = textGui or Instance.new("TextLabel")
	writer._rate = rate or DEFAULT_RATE
	writer._step = step or DEFAULT_STEP
	writer._sounds = sounds or DEFAULT_SOUNDS
	return setmetatable(writer, TypeWriter)
end

function TypeWriter:ParseText(text)
	local textGui = self._textGui
	local sounds = self._sounds
	for index = 1, string.len(text), self._step do
		local parsedText = string.sub(text, 1, index)
		local randomSound = sounds[math.random(1, #sounds)]
		if randomSound then
			randomSound:Play()
		end
		textGui.Text = parsedText
		task.wait(self._rate)
	end
end

function TypeWriter:SetSounds(sounds)
	self._sounds = sounds
end

function TypeWriter:SetRate(rate)
	self._rate = rate
end

function TypeWriter:SetStep(step)
	self._step = step	
end

function TypeWriter:SetTextGui(textGui)
	self._textGui = textGui
end

function TypeWriter:GetRate()
	return self._rate	
end

function TypeWriter:GetStep()
	return self._step	
end

function TypeWriter:GetTextGui()
	return self._textGui
end

--\\ Return //--

return TypeWriter
