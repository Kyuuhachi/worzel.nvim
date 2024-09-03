-- vim: set define=colorscheme :
local M = {}

local function scheme(body)
	local colors = setmetatable({}, {
		__index = function(self, k)
			if rawget(self, k) then
				return setmetatable({ link = k }, { __index = rawget(self, k) })
			end
			return _G[k]
		end,
	})
	assert(getfenv(body) == _G)
	setfenv(body, colors)
	body(colors)
	setfenv(body, _G)
	return setmetatable(colors, nil)
end

local C = {
	night0  = "#2E3440", -- nord0
	night1  = "#3B4252", -- nord1
	night2  = "#434C5E", -- nord2
	night3  = "#4C566A", -- nord3
	night4  = "#616E88", -- nord3bright
	snow0   = "#D8DEE9", -- nord4
	snow1   = "#E5E9F0", -- nord5
	snow2   = "#ECEFF4", -- nord6
	frost0  = "#8FBCBB", -- nord7
	frost1  = "#88C0D0", -- nord8
	frost2  = "#81A1C1", -- nord9
	frost3  = "#5E81AC", -- nord10
	aurora0 = "#BF616A", -- nord11
	aurora1 = "#D08770", -- nord12
	aurora2 = "#EBCB8B", -- nord13
	aurora3 = "#A3BE8C", -- nord14
	aurora4 = "#B48EAD", -- nord15
}

---@diagnostic disable: lowercase-global
M.colors = scheme(function(c)
	local has_hipa, hipa = pcall(require, "mini.hipatterns")
	if has_hipa then
		for k, v in pairs(C) do
			c[k] = { link = hipa.compute_hex_color_group(v, 'bg') }
		end
	end

	--- Basic text

	Normal         = { fg = C.snow1 }

	Comment        = { fg = C.night4 }

	String         = { fg = C.aurora3 }
	Character      = String
	Number         = { fg = C.aurora4 }
	Boolean        = Number

	Identifier     = { fg = C.snow0, italic = true }
	Constant       = { fg = C.snow0, bold = true, italic = true }
	Function       = { fg = C.frost1, italic = true }

	Statement      = { fg = C.frost2 }
	PreProc        = { fg = C.aurora2 } -- docs say frost3, but I like this better
	Type           = { fg = C.frost0 }

	Special        = { fg = C.snow2 }
	Delimiter      = { fg = C.frost2 }
	SpecialChar    = { fg = C.aurora2 }
	SpecialComment = { fg = C.frost1 }
	Debug          = { fg = C.aurora0 }

	Underlined     = { underline = true }
	Ignore         = { fg = C.night2 }
	Error          = { fg = C.aurora0, bold = true }
	Todo           = { fg = C.aurora2, bold = true, italic = true }

	--- UI stuff

	CursorLine   = { bg = C.night1 } -- docs say to use night2, but night1 looks better
	LineNr        = { fg = C.night4 }
	FoldColumn    = { fg = C.frost0 }
	SignColumn    = { fg = C.snow0 }
	CursorLineNr  = { fg = C.snow0, bg = CursorLine.bg }
	CursorLineFold  = { fg = FoldColumn.fg, bg = CursorLine.bg }
	CursorLineSign  = { fg = SignColumn.fg, bg = CursorLine.bg }

	CursorColumn = CursorLine
	ColorColumn  = CursorColumn
	Visual       = { bg = C.night2 }

	Conceal      = { fg = C.night3 }
	NonText      = { fg = C.night3 }
	SpecialKey   = NonText

	Cursor       = { fg = C.snow0, reverse = true }
	CursorIM     = { fg = C.snow1, reverse = true }
	Search       = { fg = C.snow2, bg = C.frost2 }
	IncSearch    = { fg = C.snow2, bg = C.frost3 }

	MsgArea      = { bg = nil }
	Question     = { fg = C.frost1 }
	ErrorMsg     = { fg = C.aurora0 }
	WarningMsg   = { fg = C.aurora2 }
	MoreMsg      = { fg = C.frost3 }

	WinSeparator = { fg = C.night0, bg = C.night1 }

	Directory    = { fg = C.frost0 }
	Folded       = { fg = C.night4, italic = true }
	MatchParen   = { fg = C.aurora4, bold = true }
	ModeMsg      = { fg = C.snow0 }

	Pmenu        = { fg = C.snow0, bg = C.night2 }
	PmenuSel     = IncSearch
	PmenuSbar    = Pmenu
	PmenuThumb   = { bg = C.snow0 }

	QuickFixLine = { fg = C.snow0, reverse = true }

	StatusLine       = { fg = C.snow0, bg = C.night2 }
	StatusLineNC     = { fg = C.snow0, bg = C.night1 }
	StatusLineTerm   = { fg = C.snow0, bg = C.night2 }
	StatusLineTermNC = { fg = C.snow0, bg = C.night1 }
	TabLineFill      = { fg = C.snow0 }
	TablineSel       = { fg = C.night1, bg = C.frost2 }
	Tabline          = { fg = C.snow0, bg = C.night1 }

	Title         = { fg = C.aurora3, bold = true }
	WildMenu      = { fg = C.aurora1, bold = true }
	ToolbarLine   = { fg = C.snow0, bg = C.night1 }
	ToolbarButton = { fg = C.snow0, bold = true }
	NormalFloat   = { fg = C.snow0, bg = C.night1 }
	FloatBorder   = { fg = C.snow0, bg = C.night1 }

	DiffAdd    = { fg = C.night0, bg = C.aurora3, nocombine = true }
	DiffChange = { fg = C.night0, bg = C.aurora2, nocombine = true }
	DiffDelete = { fg = C.night0, bg = C.aurora0, nocombine = true }
	DiffText   = { fg = C.night0, bg = C.aurora4, nocombine = true }

	SpellLocal = { undercurl = true, sp = C.frost1 }
	SpellCap   = { undercurl = true, sp = C.frost2 }
	SpellRare  = { undercurl = true, sp = C.frost3 }
	SpellBad   = { undercurl = true, sp = C.aurora4 }

	healthError   = { fg = C.aurora0 }
	healthWarning = { fg = C.aurora2 }
	healthSuccess = { fg = C.aurora3 }

	--- File types
	helpURL = { fg = C.frost2, underline = true, sp = C.frost2 }
	helpHyperTextJump = helpURL

	--- Plugins
	NvimInternalError = Error

	TSNamespace       = Identifier
	TSInclude         = { fg = C.frost2 }
	TSConstBuiltin    = Number
	TSConstMacro      = TSConstBuiltin
	TSVariableBuiltin = { fg = C.snow2, italic = true }
	TSURI             = helpURL
	TSStrong    = { bold = true }
	TSEmphasis  = { italic = true }
	TSUnderline = { underline = true }
	TSStrike    = { strikethrough = true }

	DiagnosticHint  = { fg = C.frost2 }
	DiagnosticInfo  = { fg = C.frost3 }
	DiagnosticOk    = { fg = C.aurora3 }
	DiagnosticWarn  = { fg = C.aurora2 }
	DiagnosticError = { fg = C.aurora0 }
	DiagnosticUnderlineHint  = { undercurl = true, sp = DiagnosticHint.fg }
	DiagnosticUnderlineInfo  = { undercurl = true, sp = DiagnosticInfo.fg }
	DiagnosticUnderlineOk    = { undercurl = true, sp = DiagnosticOk.fg }
	DiagnosticUnderlineWarn  = { undercurl = true, sp = DiagnosticWarn.fg }
	DiagnosticUnderlineError = { undercurl = true, sp = DiagnosticError.fg }

	LspReferenceText  = { bg = C.night2 }
	LspReferenceRead  = { bg = C.night2 }
	LspReferenceWrite = { bg = C.night2 }
	LspInlayHint      = { fg = C.night4, italic = true }
	LspCodeLens       = { fg = C.night4, italic = true }
	LspCodeLensSeparator = LspCodeLens

	BufferlineAuto       = { fg = C.snow1, bg = C.night1 }
	BufferlineAutoSeparator = { fg = C.snow1, bg = C.night0 }

	GitSignsAdd      = { fg = C.aurora3 }
	GitSignsChange   = { fg = C.aurora2 }
	GitSignsDelete   = { fg = C.aurora0 }

	diffAdded        = GitSignsAdd
	diffRemoved      = GitSignsDelete

	Knob   = { fg = C.snow0 }
	KnobNC = { fg = C.night1 }

	MkdirQuestion   = { fg = C.frost1 }
	MkdirPrefix     = { fg = C.frost3 }
	MkdirDirname    = { fg = C.frost2, bold = true }
	MkdirSuffix     = MkdirPrefix

	TelescopePromptBorder  = { fg = C.frost1 }
	TelescopeResultsBorder = { fg = C.frost2 }
	TelescopePreviewBorder = { fg = C.aurora3 }
	TelescopeSelection     = { fg = C.frost2 }
	TelescopeMatching      = { fg = C.frost1 }

	CmpItemAbbr           = { fg = C.snow0 }
	CmpItemAbbrMatch      = { fg = C.snow1, bold = true }
	CmpItemAbbrMatchFuzzy = CmpItemAbbrMatch
	CmpItemMenu           = { fg = C.aurora3 }
	CmpItemKind           = { fg = C.aurora4 }
	CmpGhostText          = { fg = C.night3 }

	NotifyTRACEBorder = DiagnosticHint
	NotifyDEBUGBorder = DiagnosticInfo
	NotifyINFOBorder  = DiagnosticOk
	NotifyWARNBorder  = DiagnosticWarn
	NotifyERRORBorder = DiagnosticError
	NotifyTRACEIcon = DiagnosticHint
	NotifyDEBUGIcon = DiagnosticInfo
	NotifyINFOIcon  = DiagnosticOk
	NotifyWARNIcon  = DiagnosticWarn
	NotifyERRORIcon = DiagnosticError
	NotifyTRACETitle = DiagnosticHint
	NotifyDEBUGTitle = DiagnosticInfo
	NotifyINFOTitle  = DiagnosticOk
	NotifyWARNTitle  = DiagnosticWarn
	NotifyERRORTitle = DiagnosticError

	LualineBg       = { fg = C.snow0,  bg = C.night1 }
	LualineNormal   = { fg = C.night1, bg = C.frost2 }
	LualineInsert   = { fg = C.night1, bg = C.frost0 }
	LualineVisual   = { fg = C.night1, bg = C.frost3 }
	LualineReplace  = { fg = C.night1, bg = C.frost1 }
	LualineCommand  = { fg = C.night1, bg = C.aurora3 }
	LualineTerminal = { fg = C.night1, bg = C.aurora4 }
	LualineInactive = { fg = C.night0, bg = C.night4 }

	Rainbow1 = { fg = "#CC8888" }
	Rainbow2 = { fg = "#CCCC88" }
	Rainbow3 = { fg = "#88CC88" }
	Rainbow4 = { fg = "#88CCCC" }
	Rainbow5 = { fg = "#8888CC" }
	Rainbow6 = { fg = "#CC88CC" }
end)

function M.apply()
	vim.cmd[[hi clear]]
	for group, color in pairs(M.colors) do
		vim.api.nvim_set_hl(0, group, color)
	end
	if vim.g.rainbow_delimiters then
		vim.g.rainbow_delimiters.highlight = { "Rainbow1", "Rainbow2", "Rainbow3", "Rainbow4", "Rainbow5", "Rainbow6" }
	end
end

local augroup = vim.api.nvim_create_augroup("worzel", { clear = true })
function M.enable_background(enable)
	local function osc(s) vim.fn.chansend(vim.v.stderr, "\x1b]"..s.."\x1b\\") end
	vim.api.nvim_clear_autocmds({ group = augroup })
	if enable ~= false then
		vim.api.nvim_create_autocmd("UIEnter", { callback = function() osc("11;"..C.night0) end, group = augroup })
		vim.api.nvim_create_autocmd("UILeave", { callback = function() osc("111") end, group = augroup })
		osc("11;"..C.night0)
	else
		osc("111")
	end
end

local function ll(base) return {
	a = base,
	b = { fg = base.bg, bg = C.night2 },
	c = M.colors.LualineBg,
} end

M.lualine = {
	normal = ll(M.colors.LualineNormal),
	insert = ll(M.colors.LualineInsert),
	visual = ll(M.colors.LualineVisual),
	replace = ll(M.colors.LualineReplace),
	command = ll(M.colors.LualineCommand),
	terminal = ll(M.colors.LualineTerminal),
	inactive = ll(M.colors.LualineInactive),
}

return M
