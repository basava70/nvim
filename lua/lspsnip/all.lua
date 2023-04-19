local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local get_visual = function(args, parent)
  if (#parent.snippet.env.SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
  else  -- If SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

local line_begin = require("luasnip.extras.expand_conditions").line_begin
-- Some LaTeX-specific conditional expansion functions (requires VimTeX)
local tex_utils = {}
tex_utils.in_mathzone = function()  -- math context detection
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end
tex_utils.in_text = function()
  return not tex_utils.in_mathzone()
end
tex_utils.in_comment = function()  -- comment detection
  return vim.fn['vimtex#syntax#in_comment']() == 1
end
tex_utils.in_env = function(name)  -- generic environment detection
    local is_inside = vim.fn['vimtex#env#is_inside'](name)
    return (is_inside[1] > 0 and is_inside[2] > 0)
end
-- A few concrete environments---adapt as needed
tex_utils.in_equation = function()  -- equation environment detection
    return tex_utils.in_env('equation')
end
tex_utils.in_itemize = function()  -- itemize environment detection
    return tex_utils.in_env('itemize')
end
tex_utils.in_tikz = function()  -- TikZ picture environment detection
    return tex_utils.in_env('tikzpicture')
end


return {
  -- Shorthand
  s("hi",  -- LuaSnip expands this to {trig = "hi"}
    { t("Hello, world!"), }
  ),

  -- Examples of Greek letter snippets, autotriggered for efficiency
s({trig=";a", snippetType="autosnippet"},
  {
    t("\\alpha"),
  }
),
s({trig=";b", snippetType="autosnippet"},
  {
    t("\\beta"),
  }
),
s({trig=";g", snippetType="autosnippet"},
  {
    t("\\gamma"),
  }
),

-- lambda
s({trig=";l", snippetType="autosnippet"},
  {
    t("\\lambda"),
  }
),

s({trig = "([^%a])mm", wordTrig = false, regTrig = true, snippetType = "autosnippet"},
  fmta(
    "<>$<>$",
    {
      f( function(_, snip) return snip.captures[1] end ),
      d(1, get_visual),
    }
  )
),

s({trig = "ff", snippetType = "autosnippet"},
  fmta(
    "\\frac{<>}{<>}",
    {
      i(1),
      i(2),
    }
  ),
  {condition = tex_utils.in_mathzone}  -- `condition` option passed in the snippet `opts` table 
),

s({trig = "h1", dscr="Top-level section", snippetType = "autosnippet"},
  fmta(
    [[\section{<>}]],
    { i(1) }
  ),
  {condition = line_begin}  -- set condition in the `opts` table
),

s({trig = "h2", dscr="Top-level section", snippetType = "autosnippet"},
  fmta(
    [[\subsection{<>}]],
    { i(1) }
  ),
  {condition = line_begin}  -- set condition in the `opts` table
),

s({trig="env", dscr="A generic new environmennt", snippetType = "autosnippet"},
  fmta(
    [[
      \begin{<>}\label{<>}
          <>
      \end{<>}
    ]],
    {
      i(1),
      i(2),
      i(3),
      rep(1),
    }
  ),
  {condition = line_begin}
),

-- Example: italic font implementing visual selection
s({trig = "tii", dscr = "Expands 'tii' into LaTeX's textit{} command."},
  fmta("\\textit{<>}",
    {
      d(1, get_visual),
    }
  )
),

-- For thesis
-- mathrm
s({trig = "mdiv", dscr = "Write div in mathrm font", snippetType="autosnippet"},
{
  t("\\mathrm{div}"),
},
{condition = tex_utils.in_mathzone}
),

s({trig = "fo", dscr = "forall", snippetType="autosnippet"},
{
  t("\\forall \\,"),
},
{condition = tex_utils.in_mathzone}
),

-- Mathbf
s({trig = "mb", snippetType = "autosnippet"},
  fmta(
    "\\mathbf{<>}",
    {
      i(1),
    }
  ),
  {condition = tex_utils.in_mathzone}
),

-- R
s({trig = "rr", snippetType = "autosnippet"},
{
  t("\\mathbb{R}"),
},
{condition = tex_utils.in_mathzone}
),

-- Matcal
s({trig = "cal", snippetType = "autosnippet"},
  fmta(
    "\\mathcal{<>}",
    {
      i(1),
    }
  ),
  {condition = tex_utils.in_mathzone}
),

-- set
s({trig = "set", snippetType = "autosnippet"},
  fmta(
    "\\left\\{ <> \\right\\}",
    {
      i(1),
    }
  ),
  {condition = tex_utils.in_mathzone}
),

-- dual pairing
s({trig = "dp", snippetType = "autosnippet"},
  fmta(
    "\\langle <> \\rangle",
    {
      i(1),
    }
  ),
  {condition = tex_utils.in_mathzone}
),

-- underscore h
s({trig = "hh", snippetType = "autosnippet", regTrig = true, wordTrig = false},
{
  t("_h"),
},
{condition = tex_utils.in_mathzone}
),

-- _0
s({trig = "h0", snippetType = "autosnippet", regTrig = true, wordTrig = false},
{
  t("_0"),
},
{condition = tex_utils.in_mathzone}
),

-- inf
s({trig = "inf", snippetType = "autosnippet"},
  fmta(
    "\\inf\\limits_{<>}",
    {
      i(1),
    }
  ),
  {condition = tex_utils.in_mathzone}
),

-- sup
s({trig = "sup", snippetType = "autosnippet"},
  fmta(
    "\\sup\\limits_{<>}",
    {
      i(1),
    }
  ),
  {condition = tex_utils.in_mathzone}
),

-- norm
s({trig = "norm", snippetType = "autosnippet"},
  fmta(
  "\\| <> \\|",
  {
    i(1),
  }
  ),
  {condition = tex_utils.in_mathzone}
),

-- Figure environment
s({trig = "fig", snippetType = "autosnippet"},
  fmta(
    [[
      \begin{figure}[H]
        \centering
        \includegraphics[width=<>\textwidth]{<>} 
        \caption{<>}
        \label{<>}
      \end{figure}
    ]],
    {
      i(1),
      i(2),
      i(3),
      i(4),
    }
  ),
  {condition = line_begin}
),

-- pi div
s({trig = "pdiv", snippetType="autosnippet"},
{
  t("\\pi^\\mathrm{div}"),
},
{condition = tex_utils.in_mathzone}
),

-- colon
s({trig = ":", snippetType="autosnippet"},
{
  t("\\colon"),
},
{condition = tex_utils.in_mathzone}
),

-- l2d
s({trig = "l2d", snippetType="autosnippet"},
{
  t("L^2(\\Omega; \\mathbb{R}^d)"),
},
{condition = tex_utils.in_mathzone}
),

-- h1d
s({trig = "h1d", snippetType="autosnippet"},
{
  t("H^1(\\Omega; \\mathbb{R}^d)"),
},
{condition = tex_utils.in_mathzone}
),

--h10d
s({trig = "h10d", snippetType="autosnippet"},
{
  t("H^1_0(\\Omega; \\mathbb{R}^d)"),
},
{condition = tex_utils.in_mathzone}
),
-- h10
s({trig = "h10", snippetType="autosnippet"},
{
  t("H^1_0"),
},
{condition = tex_utils.in_mathzone}
),

-- l20
s({trig = "l20", snippetType="autosnippet"},
{
  t("L^2_0"),
},
{condition = tex_utils.in_mathzone}
),
}
