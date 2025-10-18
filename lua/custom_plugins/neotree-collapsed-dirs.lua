local M = {}

-- Configure which path prefixes to strip from labels (optional).
-- Any node whose real path lives under one of these will display the grouped
-- portion as a dot-separated package path.
M.package_roots = {
  "/src/main/java/",
  "/src/test/java/",
  "/src/main/scala/",
  "/src/test/scala/",
  "/src/main/kotlin/",
  "/src/test/kotlin/",
}

-- Helper: is path under any configured root?
local function under_package_root(abs_path)
  -- normalize to forward slashes
  local p = abs_path:gsub("\\", "/")
  for _, root in ipairs(M.package_roots) do
    local r = root:gsub("\\", "/")
    -- allow both with and without leading project dir
    if p:find(r, 1, true) then
      return true
    end
  end
  return false
end

function M.setup(user_opts)
  user_opts = user_opts or {}
  if user_opts.package_roots then
    M.package_roots = user_opts.package_roots
  end

  local components = require("neo-tree.sources.common.components")
  local ok, _ = pcall(require, "neo-tree")
  if not ok then
    vim.notify("neo-tree not found (neo-tree-package-groups)", vim.log.levels.ERROR)
    return
  end

  require("neo-tree").setup({
    filesystem = {
      -- collapse chains of single-child folders
      group_empty_dirs = true,

      -- rewrite grouped directory labels
      components = {
        name = function(config, node, state)
          -- use the default 'name' first to preserve icons, highlights, truncation
          local out = components.name(config, node, state)

          if node.type == "directory" and type(out.text) == "string" then
            -- If this directory is a grouped chain, Neo-tree shows slashes in the label.
            -- Convert to dots for IntelliJ-like package display.
            local label = out.text:gsub("/", ".")

            -- Optional: only do the dot-style when the real path is under a package root,
            -- so ordinary grouped dirs elsewhere keep slashes if you prefer.
            if under_package_root(node.path) then
              out.text = label
            else
              -- comment the next line in if you want dots everywhere
              -- out.text = label
            end
          end

          return out
        end,
      },
    },
  })
end

return M
