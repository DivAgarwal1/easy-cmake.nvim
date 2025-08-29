local M = {}

parseConfigFile = function(file)
	local config_table = vim.json.decode(file)
	local cmake_configs = {}

	if config_table.cmakeExe then
		cmake_configs.exe = config_table.cmakeExe
	else
		cmake_configs.exe = "cmake"
	end

	if config_table.generator then
		cmake_configs.generator = config_table.generator
	else
		cmake_configs.generator = "Unix Makefiles"
	end

	if config_table.buildDirectory then
		cmake_configs.build = config_table.buildDirectory
	else
		cmake_configs.build = "build"
	end

	if config_table.variables then
		cmake_configs.variables = config_table.variables
	else
		cmake_configs.variables = {}
	end

	return cmake_configs
end

getConfigFile = function()
	return "./easy-cmake/config.json"
end

M.generate = function()
	local cmake_configs = parseConfigFile(getConfigFile())
	local cmd = ""

	cmd = cmd .. cmake_configs.exe

	cmd = cmd .. " -G " .. cmake_configs.generator

	for index, value in ipairs(cmake_configs.variables) do
		cmd = cmd .. " -D " .. value
	end

	cmd = cmd .. " -B" .. cmake_configs.build

	print(vim.fn.system(cmd))
end

M.build = function()
	local cmake_config = parseConfigFile(getConfigFile())

	local cd_cmd = "cd " .. cmake_config.build
	local undocd_cmd = "cd " .. " .."

	local cmd = ""
	cmd = cmd .. cmake_config.exe
	cmd = cmd .. " --build ."

	vim.fn.system(cd_cmd)
	print(vim.fn.system(cmd))
	vim.fn.system(undocd_cmd)
end

M.install = function()
	local cmake_config = parseConfigFile(getConfigFile())

	local cd_cmd = "cd " .. cmake_config.build
	local undocd_cmd = "cd " .. " .."

	local cmd = ""
	cmd = cmd .. cmake_config.exe
	cmd = cmd .. " --install ."

	vim.fn.system(cd_cmd)
	print(vim.fn.system(cmd))
	vim.fn.system(undocd_cmd)
end

M.setup = function()
	vim.api.nvim_create_user_command("CMakeGenerate", M.generate, {})
	vim.api.nvim_create_user_command("CMakeBuild", M.build, {})
	vim.api.nvim_create_user_command("CMakeInstall", M.install, {})
end

return M
