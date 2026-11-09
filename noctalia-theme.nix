# NoctaliaTheme for NVF (ported from the VS Code theme JSON)
# Usage: add this file to your NVF module imports, e.g.
#   imports = [ ./noctalia-theme.nix ];
{ ... }:
{
  # Base16 layer: sane defaults for any plugin that follows base16 groups
  vim.theme = {
    enable = true;
    name = "base16";
    base16-colors = {
      base00 = "#070722"; # background
      base01 = "#0b0b37"; # lighter bg (statusline, popups)
      base02 = "#454340"; # selection (VS Code #fff59b40 over bg)
      base03 = "#a79ead"; # comments
      base04 = "#a79ead"; # dim foreground
      base05 = "#ffffff"; # foreground
      base06 = "#ffffff";
      base07 = "#ffffff";
      base08 = "#FD4663"; # variables, tags
      base09 = "#9BFECE"; # numbers, constants
      base0A = "#a9aefe"; # types, classes
      base0B = "#a9aefe"; # strings
      base0C = "#fff59b"; # regex, escapes
      base0D = "#fff59b"; # functions
      base0E = "#fff59b"; # keywords
      base0F = "#FD4663";
    };
  };

  # Precise layer: per-group overrides taken from the theme's colors/tokenColors.
  # Applied now and re-applied on every :colorscheme, so load order doesn't matter.
  vim.luaConfigRC.noctalia-theme = ''
    local c = {
      bg = "#070722", bg2 = "#0b0b37", side = "#0c0c3b",
      fg = "#ffffff", grey = "#a79ead", dim = "#74697c",
      yellow = "#fff59b", lav = "#a9aefe", mint = "#9BFECE", red = "#FD4663",
      dyellow = "#998a00", dblue = "#000999", dgreen = "#00994f", dred = "#990018",
      sel = "#454340", line = "#080829", find = "#518378", findhl = "#3f6463",
      bracket = "#524f47", word = "#504811",
      add = "#1b1c3e", del = "#260f2a", chg = "#262531",
      ws = "#211f38", guide = "#1b1a33", black = "#000000",
    }

    local function apply()
      local hl = {
        -- Editor UI
        Normal = { fg = c.fg, bg = c.bg },
        NormalNC = { fg = c.fg, bg = c.bg },
        NormalFloat = { fg = c.fg, bg = c.bg },
        FloatBorder = { fg = c.grey, bg = c.bg },
        FloatTitle = { fg = c.yellow, bg = c.bg },
        EndOfBuffer = { fg = c.bg },
        Cursor = { fg = c.bg, bg = c.yellow },
        lCursor = { fg = c.bg, bg = c.yellow },
        TermCursor = { fg = c.bg, bg = c.yellow },
        CursorLine = { bg = c.line },
        CursorColumn = { bg = c.line },
        ColorColumn = { bg = c.bg2 },
        CursorLineNr = { fg = c.yellow, bold = true },
        LineNr = { fg = c.grey },
        SignColumn = { bg = c.bg },
        FoldColumn = { fg = c.fg, bg = c.bg },
        Folded = { fg = c.grey, bg = c.bracket },
        Visual = { bg = c.sel },
        VisualNOS = { bg = c.bg2 },
        Search = { fg = c.fg, bg = c.findhl },
        CurSearch = { fg = c.black, bg = c.find },
        IncSearch = { fg = c.black, bg = c.yellow },
        Substitute = { fg = c.black, bg = c.yellow },
        MatchParen = { fg = c.yellow, bg = c.bracket, bold = true },
        NonText = { fg = c.ws },
        Whitespace = { fg = c.ws },
        SpecialKey = { fg = c.ws },
        Conceal = { fg = c.grey },
        Directory = { fg = c.yellow },
        Title = { fg = c.yellow, bold = true },
        WinSeparator = { fg = c.grey },
        VertSplit = { fg = c.grey },
        Pmenu = { fg = c.fg, bg = c.bg },
        PmenuSel = { fg = c.fg, bg = c.bg2 },
        PmenuSbar = { bg = c.bg2 },
        PmenuThumb = { bg = c.grey },
        StatusLine = { fg = c.fg, bg = c.bg2 },
        StatusLineNC = { fg = c.grey, bg = c.bg },
        TabLine = { fg = c.fg, bg = c.bg },
        TabLineSel = { fg = c.fg, bg = c.bg2, bold = true },
        TabLineFill = { bg = c.bg },
        WildMenu = { fg = c.black, bg = c.yellow },
        Question = { fg = c.mint },
        MoreMsg = { fg = c.mint },
        ModeMsg = { fg = c.fg },
        ErrorMsg = { fg = c.red },
        WarningMsg = { fg = c.lav },
        SpellBad = { sp = c.red, undercurl = true },
        SpellCap = { sp = c.lav, undercurl = true },
        SpellLocal = { sp = c.mint, undercurl = true },
        SpellRare = { sp = c.yellow, undercurl = true },

        -- Classic syntax groups
        Comment = { fg = c.grey, italic = true },
        Constant = { fg = c.mint },
        String = { fg = c.lav },
        Character = { fg = c.lav },
        Number = { fg = c.mint },
        Boolean = { fg = c.mint },
        Float = { fg = c.mint },
        Identifier = { fg = c.red },
        Function = { fg = c.yellow },
        Statement = { fg = c.yellow },
        Conditional = { fg = c.yellow },
        Repeat = { fg = c.yellow },
        Label = { fg = c.yellow },
        Operator = { fg = c.fg },
        Keyword = { fg = c.yellow },
        Exception = { fg = c.yellow },
        PreProc = { fg = c.yellow },
        Include = { fg = c.yellow },
        Define = { fg = c.yellow },
        Macro = { fg = c.yellow },
        PreCondit = { fg = c.yellow },
        Type = { fg = c.lav },
        StorageClass = { fg = c.yellow },
        Structure = { fg = c.lav },
        Typedef = { fg = c.lav },
        Special = { fg = c.yellow },
        SpecialChar = { fg = c.yellow },
        Tag = { fg = c.red },
        Delimiter = { fg = c.fg },
        SpecialComment = { fg = c.grey },
        Debug = { fg = c.red },
        Underlined = { fg = c.yellow, underline = true },
        Error = { fg = c.red },
        Todo = { fg = c.black, bg = c.yellow, bold = true },

        -- Treesitter
        ["@variable"] = { fg = c.red },
        ["@variable.builtin"] = { fg = c.lav },
        ["@variable.parameter"] = { fg = c.fg, italic = true },
        ["@variable.member"] = { fg = c.red },
        ["@property"] = { fg = c.red },
        ["@field"] = { fg = c.red },
        ["@constant"] = { fg = c.mint },
        ["@constant.builtin"] = { fg = c.mint },
        ["@module"] = { fg = c.lav },
        ["@namespace"] = { fg = c.lav },
        ["@type"] = { fg = c.lav },
        ["@type.builtin"] = { fg = c.lav },
        ["@type.definition"] = { fg = c.lav },
        ["@attribute"] = { fg = c.yellow },
        ["@function"] = { fg = c.yellow },
        ["@function.builtin"] = { fg = c.yellow },
        ["@function.call"] = { fg = c.yellow },
        ["@function.method"] = { fg = c.yellow },
        ["@function.method.call"] = { fg = c.yellow },
        ["@constructor"] = { fg = c.yellow },
        ["@keyword"] = { fg = c.yellow },
        ["@keyword.operator"] = { fg = c.fg },
        ["@operator"] = { fg = c.fg },
        ["@string"] = { fg = c.lav },
        ["@string.regexp"] = { fg = c.yellow },
        ["@string.escape"] = { fg = c.yellow },
        ["@string.special"] = { fg = c.yellow },
        ["@character"] = { fg = c.lav },
        ["@number"] = { fg = c.mint },
        ["@number.float"] = { fg = c.mint },
        ["@boolean"] = { fg = c.mint },
        ["@comment"] = { fg = c.grey, italic = true },
        ["@punctuation"] = { fg = c.fg },
        ["@punctuation.delimiter"] = { fg = c.fg },
        ["@punctuation.bracket"] = { fg = c.fg },
        ["@punctuation.special"] = { fg = c.yellow },
        ["@tag"] = { fg = c.red },
        ["@tag.attribute"] = { fg = c.mint },
        ["@tag.delimiter"] = { fg = c.fg },
        ["@label"] = { fg = c.yellow },
        ["@markup.heading"] = { fg = c.red, bold = true },
        ["@markup.strong"] = { fg = c.mint, bold = true },
        ["@markup.italic"] = { fg = c.yellow, italic = true },
        ["@markup.raw"] = { fg = c.lav },
        ["@markup.link"] = { fg = c.yellow },
        ["@markup.link.url"] = { fg = c.yellow, underline = true },
        ["@markup.quote"] = { fg = c.grey, italic = true },
        ["@markup.list"] = { fg = c.yellow },

        -- LSP semantic tokens (semanticTokenColors in the theme)
        ["@lsp.type.enumMember"] = { fg = c.yellow },
        ["@lsp.typemod.variable.readonly"] = { fg = c.mint },
        ["@lsp.typemod.variable.defaultLibrary"] = { fg = c.lav },

        -- Diagnostics
        DiagnosticError = { fg = c.red },
        DiagnosticWarn = { fg = c.lav },
        DiagnosticInfo = { fg = c.mint },
        DiagnosticHint = { fg = c.mint },
        DiagnosticOk = { fg = c.mint },
        DiagnosticUnderlineError = { sp = c.red, undercurl = true },
        DiagnosticUnderlineWarn = { sp = c.lav, undercurl = true },
        DiagnosticUnderlineInfo = { sp = c.mint, undercurl = true },
        DiagnosticUnderlineHint = { sp = c.mint, undercurl = true },
        LspReferenceText = { bg = c.bg2 },
        LspReferenceRead = { bg = c.bg2 },
        LspReferenceWrite = { bg = c.word },
        LspInlayHint = { fg = c.grey, italic = true },
        LspCodeLens = { fg = c.grey },

        -- Diff / git
        DiffAdd = { bg = c.add },
        DiffDelete = { bg = c.del },
        DiffChange = { bg = c.chg },
        DiffText = { bg = c.word },
        Added = { fg = c.lav },
        Removed = { fg = c.red },
        Changed = { fg = c.yellow },
        GitSignsAdd = { fg = c.lav },
        GitSignsChange = { fg = c.yellow },
        GitSignsDelete = { fg = c.red },

        -- Completion (nvim-cmp / blink)
        CmpItemAbbr = { fg = c.fg },
        CmpItemAbbrMatch = { fg = c.yellow, bold = true },
        CmpItemAbbrMatchFuzzy = { fg = c.yellow },
        CmpItemAbbrDeprecated = { fg = c.grey, strikethrough = true },
        CmpItemMenu = { fg = c.grey },
        BlinkCmpLabelMatch = { fg = c.yellow, bold = true },

        -- File trees (VS Code sideBar.background)
        NeoTreeNormal = { fg = c.fg, bg = c.side },
        NeoTreeNormalNC = { fg = c.fg, bg = c.side },
        NeoTreeEndOfBuffer = { fg = c.side, bg = c.side },
        NeoTreeDirectoryName = { fg = c.fg },
        NeoTreeDirectoryIcon = { fg = c.yellow },
        NvimTreeNormal = { fg = c.fg, bg = c.side },
        NvimTreeNormalNC = { fg = c.fg, bg = c.side },
        NvimTreeEndOfBuffer = { fg = c.side, bg = c.side },
        NvimTreeFolderName = { fg = c.fg },
        NvimTreeRootFolder = { fg = c.yellow, bold = true },

        -- Telescope
        TelescopeNormal = { fg = c.fg, bg = c.bg },
        TelescopeBorder = { fg = c.grey, bg = c.bg },
        TelescopeTitle = { fg = c.yellow },
        TelescopePromptNormal = { fg = c.fg, bg = c.bg2 },
        TelescopePromptBorder = { fg = c.bg2, bg = c.bg2 },
        TelescopeSelection = { fg = c.fg, bg = c.bg2 },
        TelescopeMatching = { fg = c.yellow, bold = true },

        -- Indent guides / rainbow brackets
        IblIndent = { fg = c.guide },
        IblScope = { fg = c.grey },
        RainbowDelimiterYellow = { fg = c.yellow },
        RainbowDelimiterBlue = { fg = c.lav },
        RainbowDelimiterCyan = { fg = c.mint },
        RainbowDelimiterOrange = { fg = c.dyellow },
        RainbowDelimiterViolet = { fg = c.dblue },
        RainbowDelimiterGreen = { fg = c.dgreen },
        RainbowDelimiterRed = { fg = c.red },
      }

      for group, spec in pairs(hl) do
        vim.api.nvim_set_hl(0, group, spec)
      end

      -- Embedded terminal palette (terminal.ansi* from the theme)
      local term = {
        c.grey, c.red, c.lav, c.dblue, c.yellow, c.mint, c.dgreen, c.fg,
        c.fg, c.dred, c.dblue, c.lav, c.dyellow, c.dgreen, c.mint, c.fg,
      }
      for i, color in ipairs(term) do
        vim.g["terminal_color_" .. (i - 1)] = color
      end
    end

    apply()
    vim.api.nvim_create_autocmd("ColorScheme", {
      group = vim.api.nvim_create_augroup("NoctaliaTheme", { clear = true }),
      callback = apply,
    })
  '';
}
