local M = {}

local parseConfigFile = function(file)
	local config_table
	if vim.fn.filereadable(file) == 1 then
		config_table = vim.json.decode(table.concat(vim.fn.readfile(file), "\n"))
	else
		config_table = {}
	end

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

local getConfigFile = function()
	return "./.easy-cmake/config.json"
end

M.generate = function()
	local cmake_configs = parseConfigFile(getConfigFile())

	local cmd = string.format('"%s" -G "%s"', cmake_configs.exe, cmake_configs.generator)

	for key, value in pairs(cmake_configs.variables) do
		cmd = cmd .. string.format(" -D%s=%s", key, value)
	end

	cmd = cmd .. string.format(' -B "%s"', cmake_configs.build)

	print(vim.fn.system(cmd))
end

M.build = function()
	local cmake_config = parseConfigFile(getConfigFile())

	local cmd = string.format('"%s" --build "%s"', cmake_config.exe, cmake_config.build)

	print(vim.fn.system(cmd))
end

M.install = function()
	local cmake_config = parseConfigFile(getConfigFile())

	local cmd = string.format('"%s" --install "%s"', cmake_config.exe, cmake_config.build)

	print(vim.fn.system(cmd))
end

M.setup = function(opts)
	vim.api.nvim_create_user_command("CMakeGenerate", M.generate, {})
	vim.api.nvim_create_user_command("CMakeBuild", M.build, {})
	vim.api.nvim_create_user_command("CMakeInstall", M.install, {})
end

return M
