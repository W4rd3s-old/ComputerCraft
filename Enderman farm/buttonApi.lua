local _locales = {
	mon = nil
}

--button class
function create(text)
	local this = {
		x = 1,
		y = 1,
		w = 0,
		h = 1,
		text = tostring(text) or "None",
		defaultColor = colors.red,
		activeColor = colors.green,
		align = "c",
    state = false,
		disable = false,
		callback = nil,
		textColor = colors.black
	}

	if text ~= nil then
		this.w = #tostring(text)
	end

	--setters, return this object
	function this.setText(text, resize)
		this.text = tostring(text)
		if resize and this.w < #this.text then
			this.w = #this.text
		end
		return this
	end

	function this.setTextColor(color)
		this.textColor = color
		return this
	end

	function this.setAlign(align)
		if align == "center" then
			this.align = "c"
		elseif align == "left" then
			this.align = "l"
		elseif align == "right" then
			this.align = "r"
		else
			print("Incorrect slign set! ")
			error()
		end
		return this
	end

	function this.setPos(x, y)
		this.x = x
		this.y = y
		return this
	end

	function this.setSize(w, h)
		this.w = w
		this.h = h
		return this
	end

	function this.setDefaultColor(color)
		this.defaultColor = color
		return this
	end

	function this.setActiveColoror(color)
		this.activeColor = color
		return this
	end

  function this.setState(state)
		this.state = state
		return this
	end

	function this.setDisable(state)
		this.disable = state
		return this
	end

	function this.wasClicked(x,y)
		if
			x >= this.x and
			x < this.x+this.w and
			y >= this.y and
			y < this.y+this.h and
			not this.disable
		then
			return true
		end
		return false
	end

	function this.onClick(callback)
		this.callback = callback
		return this
	end

	function this.fireEvent()
		if this.callback ~= nil then
			this.callback(this.state)
		end
	end

	function this.draw()
		if _locales.mon == nil then
			print("Monitor not set!")
			error()
		end
		local xpos = this.x+(this.w/2-#this.text/2)
		local t = this.text
		local bg = _locales.mon.getBackgroundColor()
		local tc = _locales.mon.getTextColor()
		if this.align == "l" then
			xpos = this.x
		end
		if this.align == "r" then
			xpos = this.x+this.w-#this.text
		end
		if #this.text > this.w then
			xpos = this.x
			t = string.sub(t,1,this.w-3)..".."..string.sub(t,-1)
		end
		_locales.mon.setTextColor(this.textColor)
		local f = string.rep(" ", this.w)
		if this.disable then
      _locales.mon.setBackgroundColor(colors.gray)
		else
      mDisplayColor = this.defaultColor
      if this.state then
        mDisplayColor = this.activeColor
      end
			_locales.mon.setBackgroundColor(mDisplayColor)
		end
		for i = 1, this.h do
			_locales.mon.setCursorPos(this.x, this.y+(i-1))
			_locales.mon.write(f)
		end
		_locales.mon.setCursorPos(xpos,this.y+this.h/2)
		_locales.mon.write(t)
		_locales.mon.setBackgroundColor(bg)
		_locales.mon.setTextColor(tc)
	end

	function this.changeState()
    this.state = not this.state
		this.draw()
	end

	return this
end

--set Monitor handle to draw on
function setMonitor(mon)
	_locales.mon = mon
	--MON = mon
end

function clearMon()
	_locales.mon.clear()
end

local function isTable(element)
	return type(element) == "table"
end

local function isButton(element)
	if isTable(element) and element.text ~= nil then
		return true
	end
	return false
end

local function mergeTables(tab1, tab2)
	for i in pairs(tab2) do
		tab1[#tab1+1] = tab2[i]
	end
end

--manage button checks
function await(...)
	array = {}
	for i in pairs(arg) do
		if i ~= "n" then
			if isTable(arg[i]) and not isButton(arg[i]) then --table of buttons
				mergeTables(array, arg[i])
			else --single button
				array[#array+1] = arg[i]
			end
		end
	end

	for i in pairs(array) do
			array[i].draw()
	end
	e, s, x, y = os.pullEvent("monitor_touch")
	for i in pairs(array) do
		if array[i].wasClicked(x,y) then
			array[i].changeState()
			array[i].fireEvent()
		end
	end
end
