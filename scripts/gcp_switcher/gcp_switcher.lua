#!/usr/bin/env lua

local uv = vim and vim.loop or require('luv')  -- use LuaJIT's luv or nvim's uv if available
local HOME = os.getenv("HOME") or assert(false, "HOME environment variable not set")
local CACHE_DIR = HOME .. "/.cache/gcp_switcher"
local CACHE_FILE = CACHE_DIR .. "/projects.txt"

-- Execute a command and capture output
local function exec(cmd)
  local handle = io.popen(cmd)
  local result = handle:read('*a')
  local success, exit_type, code = handle:close()
  if not success then
    return nil, string.format("Command '%s' failed (%s, code %d)", cmd, exit_type, code)
  end
  return result
end

local function ensure_cmd(cmd)
  local path = exec('command -v ' .. cmd .. ' 2>/dev/null')
  if not path or #path == 0 then
    io.stderr:write(string.format("Error: '%s' not found in PATH. Install it and retry.\n", cmd))
    os.exit(1)
  end
end

local function parse_args()
  local opts = { refresh = false }
  for _, v in ipairs(arg) do
    if v == '--refresh' then
      opts.refresh = true
    elseif v == '-h' or v == '--help' then
      io.write([[
Usage: gcp_switcher [--refresh]

Options:
  --refresh   Force refresh of cached project list
  -h, --help  Show this message
]])
      os.exit(0)
    else
      io.stderr:write(string.format("Unknown option: %s\n", v))
      os.exit(1)
    end
  end
  return opts
end

local function ensure_cache_dir()
  local ok, err = uv.fs_mkdir(CACHE_DIR, 448)  -- 0700 permissions
  if not ok and err:match("EEXIST") == nil then
    io.stderr:write("Could not create cache directory: " .. err .. "\n")
    os.exit(1)
  end
end

local function read_cache()
  local projects = {}
  local f = io.open(CACHE_FILE, 'r')
  if f then
    for line in f:lines() do
      if line:match('%S') then
        projects[#projects + 1] = line
      end
    end
    f:close()
  end
  return projects
end

local function write_cache(projects)
  local f, err = io.open(CACHE_FILE, 'w')
  if not f then
    io.stderr:write("Failed to write cache: " .. err .. "\n")
    return
  end
  f:write(table.concat(projects, '\n'))
  f:close()
end

local function fetch_projects()
  local output, err = exec('gcloud projects list --format="value(projectId)"')
  if not output then
    io.stderr:write("Error fetching GCP projects: " .. err .. "\n")
    os.exit(1)
  end
  local projects = {}
  for id in output:gmatch('[^\r\n]+') do
    projects[#projects + 1] = id
  end
  return projects
end

-- Launch fzf and return selected line
local function pick_with_fzf(lines)
  -- Escape quotes safely
  for i, v in ipairs(lines) do
    lines[i] = v:gsub('"', '\\"')
  end
  local cmd = string.format('printf "%s" | fzf', table.concat(lines, '\n'))
  local choice, err = exec(cmd)
  if not choice then
    io.stderr:write("Error during selection: " .. err .. "\n")
    os.exit(1)
  end
  choice = choice:match('^%s*(.-)%s*$')
  return choice
end

-- Main
local function main()
  local opts = parse_args()
  ensure_cmd('gcloud')
  ensure_cmd('fzf')
  ensure_cache_dir()

  local projects = {}
  if not opts.refresh then
    projects = read_cache()
  end
  if opts.refresh or #projects == 0 then
    projects = fetch_projects()
    if #projects > 0 then
      write_cache(projects)
    else
      io.stderr:write("No GCP projects found.\n")
      os.exit(1)
    end
  end

  local selection = pick_with_fzf(projects)
  if selection == '' then
    io.stderr:write("No project selected.\n")
    os.exit(1)
  end

  local output, err = exec('gcloud config set project ' .. selection)
  if not output then
    io.stderr:write("Error setting project " .. err .. "\n")
    os.exit(1)
  end
end

main()
