local config = require("barbecue.config")
local theme = require("barbecue.theme")
local utils = require("barbecue.utils")
local Entry = require("barbecue.ui.entry")
local State = require("barbecue.ui.state")
local components = require("barbecue.ui.components")

local M = {}

local visible = true

---Truncate entries keeping the basename.
---
---NOTE: This function mutates the given entries.
---
---@param entries barbecue.Entry[] Entries to be truncated.
---@param length number Visible length of entries' contents.
---@param max_length number Highest length possible.
---@param basename_position number Position of the basename entry.
local function truncate_entries(entries, length, max_length, basename_position)
  local has_ellipsis, i, n = false, 1, 0
  while i <= #entries do
    if length <= max_length then break end
    if n + i == basename_position then
      has_ellipsis = false
      i = i + 1
      goto continue
    end

    length = length - entries[i]:len()
    if has_ellipsis then
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
      if i < #entries then
        length = length
          - (
            vim.api.nvim_eval_statusline(config.user.symbols.separator, {
              use_winbar = true,
            }).width + 2
          )
      end
||||||| parent of f8ca86f (refactoring and adding options)
      if i < #entries then
        length = length - (utils.str_len(config.user.symbols.separator) + 2)
      end
=======
      if i < #entries then length = length - (utils.str_len(config.user.symbols.separators[2]) + 2) end
>>>>>>> f8ca86f (refactoring and adding options)
||||||| parent of 9687462 (merged)
      if i < #entries then length = length - (utils.str_len(config.user.symbols.separators[2]) + 2) end
=======
      if i < #entries then length = length - (vim.api.nvim_eval_statusline(config.user.symbols.separators[2], {
||||||| parent of 4a15252 (merged)
      if i < #entries then length = length - (vim.api.nvim_eval_statusline(config.user.symbols.separators[2], {
=======
      if i < #entries then length = length - (vim.api.nvim_eval_statusline(config.user.symbols.separator, {
>>>>>>> 4a15252 (merged)
        use_winbar = true,
      }).width + 2) end
>>>>>>> 9687462 (merged)

      table.remove(entries, i)
      n = n + 1
    else
<<<<<<< HEAD
      length = length
        + vim.api.nvim_eval_statusline(config.user.symbols.ellipsis, {
          use_winbar = true,
        }).width
      entries[i] = Entry.new({
        config.user.symbols.ellipsis,
        highlight = theme.highlights.ellipsis,
      })
<<<<<<< HEAD
||||||| parent of 5975a2d (fix(utils): remove `str_len` and use `nvim_eval_statusline` instead)
      length = length + utils.str_len(config.user.symbols.ellipsis)
      entries[i] = ENTRY_ELLIPSIS
=======
      length = length
        + vim.api.nvim_eval_statusline(config.user.symbols.ellipsis, {
          use_winbar = true,
        }).width
<<<<<<< HEAD
      entries[i] = ENTRY_ELLIPSIS
>>>>>>> 5975a2d (fix(utils): remove `str_len` and use `nvim_eval_statusline` instead)
||||||| parent of ac2272e (fix(ui): create ellipsis entry every time to respect user config)
      entries[i] = ENTRY_ELLIPSIS
=======
      entries[i] = Entry.new({
        config.user.symbols.ellipsis,
        highlight = theme.highlights.ellipsis,
      })
>>>>>>> ac2272e (fix(ui): create ellipsis entry every time to respect user config)
||||||| parent of 89817d7 (merged)
=======
||||||| parent of 9687462 (merged)
      length = length + utils.str_len(config.user.symbols.ellipsis)
      entries[i] = ENTRY_ELLIPSIS
=======
      length = length + vim.api.nvim_eval_statusline(config.user.symbols.ellipsis, {
        use_winbar = true,
      }).width
      entries[i] = Entry.new({
        config.user.symbols.ellipsis,
        highlight = theme.highlights.ellipsis,
      })
>>>>>>> 9687462 (merged)
>>>>>>> 89817d7 (merged)

      has_ellipsis = true
      i = i + 1 -- manually increment i when not removing anything from entries
    end

    ::continue::
  end
end

---Extract custom section and its length from given function.
---
---@param winnr number Window to be used as context.
---@param custom_section barbecue.Config.custom_section User config value to extract the custom section from.
---@return string custom_section Styled custom section.
---@return number length Length of custom section.
local function extract_custom_section(winnr, custom_section)
  local length = 0
  local content = ""

  if type(custom_section) == "string" then
<<<<<<< HEAD
    length = vim.api.nvim_eval_statusline(custom_section, {
      use_winbar = true,
      winid = winnr,
    }).width
||||||| parent of 59f9656 (fix(custom_section): evaluate string to calculate length precisely)
    length = utils.str_len(custom_section)
=======
    length = utils.str_len(vim.api.nvim_eval_statusline(custom_section, {
      use_winbar = true,
      winid = winnr,
    }).str)
>>>>>>> 59f9656 (fix(custom_section): evaluate string to calculate length precisely)
    content = custom_section
  elseif type(custom_section) == "table" then
    for _, part in ipairs(custom_section) do
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
      length = length
        + vim.api.nvim_eval_statusline(part[1], {
          use_winbar = true,
          winid = winnr,
        }).width
||||||| parent of 9687462 (merged)
      length = length + utils.str_len(part[1])
=======
||||||| parent of fcf6dc0 (fix(custom_section): evaluate string to calculate length precisely)
=======
<<<<<<< HEAD
>>>>>>> fcf6dc0 (fix(custom_section): evaluate string to calculate length precisely)
||||||| parent of 4a15252 (merged)
<<<<<<< HEAD
=======
>>>>>>> 4a15252 (merged)
||||||| parent of 49a816a (fix(custom_section): evaluate string to calculate length precisely)
=======
<<<<<<< HEAD
>>>>>>> 49a816a (fix(custom_section): evaluate string to calculate length precisely)
      length = length + vim.api.nvim_eval_statusline(part[1], {
        use_winbar = true,
        winid = winnr,
      }).width
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
>>>>>>> 9687462 (merged)
||||||| parent of fcf6dc0 (fix(custom_section): evaluate string to calculate length precisely)
=======
||||||| parent of 59f9656 (fix(custom_section): evaluate string to calculate length precisely)
      length = length + utils.str_len(part[1])
=======
      length = length
        + utils.str_len(vim.api.nvim_eval_statusline(part[1], {
          use_winbar = true,
          winid = winnr,
        }).str)
>>>>>>> 59f9656 (fix(custom_section): evaluate string to calculate length precisely)
>>>>>>> fcf6dc0 (fix(custom_section): evaluate string to calculate length precisely)
||||||| parent of 4a15252 (merged)
||||||| parent of 59f9656 (fix(custom_section): evaluate string to calculate length precisely)
      length = length + utils.str_len(part[1])
=======
      length = length
        + utils.str_len(vim.api.nvim_eval_statusline(part[1], {
          use_winbar = true,
          winid = winnr,
        }).str)
>>>>>>> 59f9656 (fix(custom_section): evaluate string to calculate length precisely)
=======
>>>>>>> 4a15252 (merged)
||||||| parent of 49a816a (fix(custom_section): evaluate string to calculate length precisely)
=======
||||||| parent of 59f9656 (fix(custom_section): evaluate string to calculate length precisely)
      length = length + utils.str_len(part[1])
=======
      length = length
        + utils.str_len(vim.api.nvim_eval_statusline(part[1], {
          use_winbar = true,
          winid = winnr,
        }).str)
>>>>>>> 59f9656 (fix(custom_section): evaluate string to calculate length precisely)
>>>>>>> 49a816a (fix(custom_section): evaluate string to calculate length precisely)

      if part[2] ~= nil then content = content .. string.format("%%#%s#", part[2]) end
      content = content .. part[1]
    end
  end

  return content, length
end

---Gathers all the entries and combines them, then truncates the less useful
---parts if there's shortage of room.
---
---@param winnr number Window to be passed to components.
---@param bufnr number Buffer to be passed to components.
---@param extra_length number Additional length to consider when truncating.
---@return barbecue.Entry[]|nil
local function create_entries(winnr, bufnr, extra_length)
  if vim.api.nvim_buf_get_name(bufnr) == "" then return nil end

  local dirname = components.dirname(bufnr)
  local basename = components.basename(winnr, bufnr)
  local context = components.context(winnr, bufnr)

  ---@type barbecue.Entry[]
  local entries = {}
  utils.tbl_merge(entries, dirname, { basename }, context)

  local length = extra_length
  for i, entry in ipairs(entries) do
    length = length + entry:len()
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
    if i < #entries then
      length = length
        + vim.api.nvim_eval_statusline(config.user.symbols.separator, {
          use_winbar = true,
          winid = winnr,
        }).width
        + 2
    end
||||||| parent of f8ca86f (refactoring and adding options)
    if i < #entries then
      length = length + utils.str_len(config.user.symbols.separator) + 2
    end
=======
    if i < #entries then length = length + utils.str_len(config.user.symbols.separators[2]) + 2 end
>>>>>>> f8ca86f (refactoring and adding options)
||||||| parent of 9687462 (merged)
    if i < #entries then length = length + utils.str_len(config.user.symbols.separators[2]) + 2 end
=======
    if i < #entries then length = length + vim.api.nvim_eval_statusline(config.user.symbols.separators[2], {
||||||| parent of 4a15252 (merged)
    if i < #entries then length = length + vim.api.nvim_eval_statusline(config.user.symbols.separators[2], {
=======
    if i < #entries then length = length + vim.api.nvim_eval_statusline(config.user.symbols.separator, {
>>>>>>> 4a15252 (merged)
      use_winbar = true,
      winid = winnr,
    }).width + 2 end
>>>>>>> 9687462 (merged)
  end
  truncate_entries(entries, length, vim.api.nvim_win_get_width(winnr), #dirname + 1)

  return entries
end

---Builds a specialized string to be shown at winbar.
---
---@param entries barbecue.Entry[] Entries to create the string from.
---@param lead_custom_section string Additional section to be prepended at the very beginning.
---@param custom_section string Additional section to be appended at the very end.
---@return string
local function build_winbar(entries, lead_custom_section, custom_section)
  local entries_str = ""
  for i, entry in ipairs(entries) do
    entries_str = entries_str .. entry:to_string()
    if i < #entries then entries_str = entries_str .. string.format("%%#%s# %%#%s#", theme.highlights.normal, theme.highlights.separator) .. config.user.symbols.separator .. string.format("%%#%s# ", theme.highlights.normal) end
  end

  return string.format("%%#%s#%s%s%%#%s#%%=%%#%s#%s", theme.highlights.normal, lead_custom_section, entries_str, theme.highlights.normal, theme.highlights.normal, custom_section)
end

---Gathers up-to-date data and updates the winbar unless the window or the
---buffer contained by it is excluded.
---
---@async
---@param winnr number? Window to update the winbar of or `nil` for the current window.
function M.update(winnr)
  winnr = winnr or vim.api.nvim_get_current_win()
  local bufnr = vim.api.nvim_win_get_buf(winnr)
  local state = State.new(winnr)

<<<<<<< HEAD
<<<<<<< HEAD
  if
    not vim.tbl_contains(config.user.include_buftypes, vim.bo[bufnr].buftype)
    or vim.tbl_contains(config.user.exclude_filetypes, vim.bo[bufnr].filetype)
    or vim.api.nvim_win_get_config(winnr).relative ~= ""
    or (
      not config.user.show_dirname
      and not config.user.show_basename
      and vim.b[bufnr].navic_client_id == nil
    )
  then
||||||| parent of f8ca86f (refactoring and adding options)
  if
    not vim.tbl_contains(config.user.include_buftypes, vim.bo[bufnr].buftype)
    or vim.tbl_contains(config.user.exclude_filetypes, vim.bo[bufnr].filetype)
    or vim.api.nvim_win_get_config(winnr).relative ~= ""
  then
=======
  if not vim.tbl_contains(config.user.include_buftypes, vim.bo[bufnr].buftype) or vim.tbl_contains(config.user.exclude_filetypes, vim.bo[bufnr].filetype) or vim.api.nvim_win_get_config(winnr).relative ~= "" then
>>>>>>> f8ca86f (refactoring and adding options)
||||||| parent of 9687462 (merged)
  if not vim.tbl_contains(config.user.include_buftypes, vim.bo[bufnr].buftype) or vim.tbl_contains(config.user.exclude_filetypes, vim.bo[bufnr].filetype) or vim.api.nvim_win_get_config(winnr).relative ~= "" then
=======
  if not vim.tbl_contains(config.user.include_buftypes, vim.bo[bufnr].buftype) or vim.tbl_contains(config.user.exclude_filetypes, vim.bo[bufnr].filetype) or vim.api.nvim_win_get_config(winnr).relative ~= "" or (not config.user.show_dirname and not config.user.show_basename and vim.b[bufnr].navic_client_id == nil) then
>>>>>>> 9687462 (merged)
    local last_winbar = state:get_last_winbar()
    if last_winbar ~= nil then
      -- HACK: this exists because of Vim:E36 error. See neovim/neovim#19464
      pcall(function() vim.wo[winnr].winbar = last_winbar end)
    end

    state:clear()
    return
  end

  if not visible then
    vim.wo[winnr].winbar = ""
    return
  end

  vim.schedule(function()
    if not vim.api.nvim_buf_is_valid(bufnr) or not vim.api.nvim_win_is_valid(winnr) or bufnr ~= vim.api.nvim_win_get_buf(winnr) then return end

<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
    local lead_custom_section, lead_custom_section_length =
      extract_custom_section(
        winnr,
        config.user.lead_custom_section(bufnr, winnr)
      )
    local custom_section, custom_section_length =
      extract_custom_section(winnr, config.user.custom_section(bufnr, winnr))
    local entries = create_entries(
      winnr,
      bufnr,
      lead_custom_section_length + custom_section_length
    )
||||||| parent of f8ca86f (refactoring and adding options)
    local lead_custom_section, lead_custom_section_length =
      extract_custom_section(config.user.lead_custom_section(bufnr, winnr))
    local custom_section, custom_section_length =
      extract_custom_section(config.user.custom_section(bufnr, winnr))
    local entries = create_entries(
      winnr,
      bufnr,
      lead_custom_section_length + custom_section_length
    )
=======
    local lead_custom_section, lead_custom_section_length = extract_custom_section(config.user.lead_custom_section(bufnr, winnr))
    local custom_section, custom_section_length = extract_custom_section(config.user.custom_section(bufnr, winnr))
||||||| parent of 9687462 (merged)
    local lead_custom_section, lead_custom_section_length = extract_custom_section(config.user.lead_custom_section(bufnr, winnr))
    local custom_section, custom_section_length = extract_custom_section(config.user.custom_section(bufnr, winnr))
=======
||||||| parent of fcf6dc0 (fix(custom_section): evaluate string to calculate length precisely)
=======
<<<<<<< HEAD
>>>>>>> fcf6dc0 (fix(custom_section): evaluate string to calculate length precisely)
||||||| parent of 4a15252 (merged)
<<<<<<< HEAD
=======
>>>>>>> 4a15252 (merged)
||||||| parent of 49a816a (fix(custom_section): evaluate string to calculate length precisely)
=======
<<<<<<< HEAD
>>>>>>> 49a816a (fix(custom_section): evaluate string to calculate length precisely)
    local lead_custom_section, lead_custom_section_length = extract_custom_section(winnr, config.user.lead_custom_section(bufnr, winnr))
    local custom_section, custom_section_length = extract_custom_section(winnr, config.user.custom_section(bufnr, winnr))
>>>>>>> 9687462 (merged)
    local entries = create_entries(winnr, bufnr, lead_custom_section_length + custom_section_length)
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
>>>>>>> f8ca86f (refactoring and adding options)
||||||| parent of fcf6dc0 (fix(custom_section): evaluate string to calculate length precisely)
=======
||||||| parent of 59f9656 (fix(custom_section): evaluate string to calculate length precisely)
    local lead_custom_section, lead_custom_section_length =
      extract_custom_section(config.user.lead_custom_section(bufnr, winnr))
    local custom_section, custom_section_length =
      extract_custom_section(config.user.custom_section(bufnr, winnr))
    local entries = create_entries(
      winnr,
      bufnr,
      lead_custom_section_length + custom_section_length
    )
=======
    local lead_custom_section, lead_custom_section_length =
      extract_custom_section(
        winnr,
        config.user.lead_custom_section(bufnr, winnr)
      )
    local custom_section, custom_section_length =
      extract_custom_section(winnr, config.user.custom_section(bufnr, winnr))
    local entries = create_entries(
      winnr,
      bufnr,
      lead_custom_section_length + custom_section_length
    )
>>>>>>> 59f9656 (fix(custom_section): evaluate string to calculate length precisely)
>>>>>>> fcf6dc0 (fix(custom_section): evaluate string to calculate length precisely)
||||||| parent of 4a15252 (merged)
||||||| parent of 59f9656 (fix(custom_section): evaluate string to calculate length precisely)
    local lead_custom_section, lead_custom_section_length =
      extract_custom_section(config.user.lead_custom_section(bufnr, winnr))
    local custom_section, custom_section_length =
      extract_custom_section(config.user.custom_section(bufnr, winnr))
    local entries = create_entries(
      winnr,
      bufnr,
      lead_custom_section_length + custom_section_length
    )
=======
    local lead_custom_section, lead_custom_section_length =
      extract_custom_section(
        winnr,
        config.user.lead_custom_section(bufnr, winnr)
      )
    local custom_section, custom_section_length =
      extract_custom_section(winnr, config.user.custom_section(bufnr, winnr))
    local entries = create_entries(
      winnr,
      bufnr,
      lead_custom_section_length + custom_section_length
    )
>>>>>>> 59f9656 (fix(custom_section): evaluate string to calculate length precisely)
=======
>>>>>>> 4a15252 (merged)
||||||| parent of 49a816a (fix(custom_section): evaluate string to calculate length precisely)
=======
||||||| parent of 59f9656 (fix(custom_section): evaluate string to calculate length precisely)
    local lead_custom_section, lead_custom_section_length =
      extract_custom_section(config.user.lead_custom_section(bufnr, winnr))
    local custom_section, custom_section_length =
      extract_custom_section(config.user.custom_section(bufnr, winnr))
    local entries = create_entries(
      winnr,
      bufnr,
      lead_custom_section_length + custom_section_length
    )
=======
    local lead_custom_section, lead_custom_section_length =
      extract_custom_section(
        winnr,
        config.user.lead_custom_section(bufnr, winnr)
      )
    local custom_section, custom_section_length =
      extract_custom_section(winnr, config.user.custom_section(bufnr, winnr))
    local entries = create_entries(
      winnr,
      bufnr,
      lead_custom_section_length + custom_section_length
    )
>>>>>>> 59f9656 (fix(custom_section): evaluate string to calculate length precisely)
>>>>>>> 49a816a (fix(custom_section): evaluate string to calculate length precisely)
    if entries == nil then return end

    state:save(entries)
    vim.wo[winnr].winbar = build_winbar(entries, lead_custom_section, custom_section)
  end)
end

---Toggles the visibility globally.
---
---@param shown boolean? New visibility state or `nil` to toggle.
function M.toggle(shown)
  if shown == nil then shown = not visible end

  visible = shown --[[ @as boolean ]]
  for _, winnr in ipairs(vim.api.nvim_list_wins()) do
    M.update(winnr)
  end
end

---Navigate to a specific entry.
---
---@param index number Index of the desired entry.
---@param winnr number? Window that contains the entry or `nil` for the current window.
function M.navigate(index, winnr)
  if index == 0 then error("expected non-zero index", 2) end
  winnr = winnr or vim.api.nvim_get_current_win()

  local entries = State.new(winnr):get_entries()
  if entries == nil then return end

  ---@type barbecue.Entry[]
  local clickable_entries = vim.tbl_filter(function(entry) return entry.to ~= nil end, entries)
  if index < -#clickable_entries or index > #clickable_entries then error("index out of range", 2) end

  if index < 0 then index = #clickable_entries + index + 1 end
  local clickable_entry = Entry.from(clickable_entries[index])
  clickable_entry:navigate()
end

return M
