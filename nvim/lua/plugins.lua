-- bootstrap Paq if not installed
local install_path = vim.fn.stdpath("data") .. "/site/pack/paqs/start/paq-nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.system({"git", "clone", "--depth=1",
		"https://github.com/savq/paq-nvim.git", install_path})
	vim.cmd "packadd paq-nvim"
end

local pkgs_has = function (pkgs, uri)
	for _,spec in ipairs(pkgs) do
		if type(spec) == 'table' then
			local _, head = next(spec)
			if head == uri then return true end
		else
			if spec == uri then return true end
		end
	end
	return false
end


return setmetatable({}, {
	__call = function (_, pkgs)
		for _, spec in ipairs(pkgs) do
			if type(spec) == 'table' then
				if type(spec.dependencies) == 'table' then
					for _,uri in ipairs(spec.dependencies) do
						if not pkgs_has(pkgs, uri) then
							table.insert(pkgs, uri)
						end
					end
				end
			end
		end

		require("paq")(pkgs)

		for _,spec in pairs(pkgs) do
			if type (spec.config) == 'function' then
				if not pcall(spec.config) then
					local _, head = next(spec)
					vim.notify('Config failed for ' .. head)
				end
			end
		end
	end
})
