local logger = {}

local log_stream = io.open(scriptPath() .. "log.txt", "a+")

---log_message
---
---Log a message.
---
---Automatically attaches the newline character for ``message``.
---
---@param message string message to be logged
function logger.log_message(message)
	log_stream:write(string.format("[%s] %s\n", os.date("%Y-%m-%d %H:%M:%S"), message))
end

---screenshot_message
---
---Take a screenshot and save it with a log message.
---
---Automatically attaches the newline character for ``message``.
---
---@param message string message to be logged
function logger.screenshot_message(message)
	logger.screenshot_message_file_suffix(message, "")
end

---screenshot_message_file_suffix
---
---Take a screenshot and save it with a log message.
---The screenshot file name will have a ``file_suffix`` at the end.
---
---Automatically attaches the newline character for ``message``.
---
---@param message string message to be logged
---@param file_suffix string file name suffix to be attached
function logger.screenshot_message_file_suffix(message, file_suffix)
	setImagePath(scriptPath() .. "log")

	local fileName = string.format("%s-%s.png", os.date("%y%m%d-%H%M%S"), file_suffix)

	logger.log_message(string.format("Screenshot saved at %s. Message: %s\n", fileName, message))

	local screen = getAppUsableScreenSize()
	local reg = Region(0, 0, screen:getX(), screen:getY())
	reg:save(fileName)

	setImagePath(scriptPath() .. "image")
end

--region Initialize
logger.log_message("\n===============")
logger.log_message(string.format("Starts at %s", os.date("%Y-%m-%d %H:%M:%S")))
--endregion

return logger