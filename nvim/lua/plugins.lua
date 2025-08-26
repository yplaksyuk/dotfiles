-- bootstrap Paq if not installed
local install_path = vim.fn.stdpath("data") .. "/site/pack/paqs/start/paq-nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.system({"git", "clone", "--depth=1",
		"https://github.com/savq/paq-nvim.git", install_path})
	vim.cmd "packadd paq-nvim"
end

local plugins = {}

function plugins:load(pkgs)
	local closure = {}

	for _,spec in pairs(pkgs) do
		if type(spec) == 'table' and (spec.enabled == true or spec.enabled == nil) then
			local _,url = next(spec)
			if type(url) == 'string' then
				local deps = spec.dependencies
				if type(deps) == 'table' then
					for _,dep in pairs(deps) do
						if type(dep) == 'string' and not closure[dep] then
							closure[dep] = dep
						end
					end
				end
				closure[url] = spec
			end
		elseif type(spec) == 'string' then
			closure[spec] = spec
		end
	end

	require("paq")(closure)

	for k,spec in pairs(closure) do
		if type (spec.config) == 'function' then
			if not pcall(spec.config) then
				vim.notify('Config failed: ' .. k)
			end
		end
	end
end

setmetatable(plugins, {
	__call = plugins.load
})

return plugins
