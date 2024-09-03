if exists("g:colors_name")
	hi clear
endif
set termguicolors
set background=dark
let g:colors_name = "worzel"

lua package.loaded["worzel"] = nil
lua require "worzel".apply()
