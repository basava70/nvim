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
	if #parent.snippet.env.SELECT_RAW > 0 then
		return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
	else -- If SELECT_RAW is empty, return a blank insert node
		return sn(nil, i(1))
	end
end

local line_begin = require("luasnip.extras.expand_conditions").line_begin
-- Some LaTeX-specific conditional expansion functions (requires VimTeX)
local tex_utils = {}
tex_utils.in_mathzone = function() -- math context detection
	return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end
tex_utils.in_text = function()
	return not tex_utils.in_mathzone()
end
tex_utils.in_comment = function() -- comment detection
	return vim.fn["vimtex#syntax#in_comment"]() == 1
end
tex_utils.in_env = function(name) -- generic environment detection
	local is_inside = vim.fn["vimtex#env#is_inside"](name)
	return (is_inside[1] > 0 and is_inside[2] > 0)
end
-- A few concrete environments---adapt as needed
tex_utils.in_equation = function() -- equation environment detection
	return tex_utils.in_env("equation")
end
tex_utils.in_itemize = function() -- itemize environment detection
	return tex_utils.in_env("itemize")
end
tex_utils.in_tikz = function() -- TikZ picture environment detection
	return tex_utils.in_env("tikzpicture")
end

return {
	-- Shorthand
	s(
		"hi", -- LuaSnip expands this to {trig = "hi"}
		{ t("Hello, world!") }
	),

	-- Examples of Greek letter snippets, autotriggered for efficiency
	s({ trig = ";a", snippetType = "autosnippet" }, {
		t("\\alpha"),
	}),
	s({ trig = ";b", snippetType = "autosnippet" }, {
		t("\\beta"),
	}),
	s({ trig = ";g", snippetType = "autosnippet" }, {
		t("\\gamma"),
	}),

	-- lambda
	s({ trig = ";l", snippetType = "autosnippet" }, {
		t("\\lambda"),
	}),

	-- Omgea
	s({ trig = ";O", snippetType = "autosnippet" }, {
		t("\\Omega"),
	}),

	-- phi
	s({ trig = ";p", snippetType = "autosnippet" }, {
		t("\\phi"),
	}),

	-- Phi
	s({ trig = ";P", snippetType = "autosnippet" }, {
		t("\\Phi"),
	}),

	-- psi
	s({ trig = ";s", snippetType = "autosnippet" }, {
		t("\\psi"),
	}),
	--
	-- Psi
	s({ trig = ";S", snippetType = "autosnippet" }, {
		t("\\Psi"),
	}),

	-------------------------------------------------------------
	-------------------------------------------------------------

	s(
		{ trig = "([^%a])mm", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>$<>$", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		})
	),

	s(
		{ trig = "ff", snippetType = "autosnippet" },
		fmta("\\frac{<>}{<>}", {
			i(1),
			i(2),
		}),
		{ condition = tex_utils.in_mathzone } -- `condition` option passed in the snippet `opts` table
	),

	s(
		{ trig = "h1", dscr = "Top-level section", snippetType = "autosnippet" },
		fmta([[\section{<>}]], { i(1) }),
		{ condition = line_begin } -- set condition in the `opts` table
	),

	s(
		{ trig = "h2", dscr = "Top-level section", snippetType = "autosnippet" },
		fmta([[\subsection{<>}]], { i(1) }),
		{ condition = line_begin } -- set condition in the `opts` table
	),

	s(
		{ trig = "env", dscr = "A generic new environmennt", snippetType = "autosnippet" },
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
		{ condition = line_begin }
	),

	-- Example: italic font implementing visual selection
	s(
		{ trig = "tii", dscr = "Expands 'tii' into LaTeX's textit{} command." },
		fmta("\\textit{<>}", {
			d(1, get_visual),
		})
	),

	-- For thesis
	-- mathrm
	s(
		{ trig = "rm", dscr = "Write div in mathrm font", snippetType = "autosnippet" },
		fmta(
			[[
    \mathrm{<>}
    ]],
			{
				i(1),
			}
		),
		{ condition = tex_utils.in_mathzone }
	),

	s({ trig = "fo", dscr = "forall", snippetType = "autosnippet" }, {
		t("\\forall \\,"),
	}, { condition = tex_utils.in_mathzone }),

	-- Mathbf
	s(
		{ trig = "mb", snippetType = "autosnippet" },
		fmta("\\mathbf{<>}", {
			i(1),
		}),
		{ condition = tex_utils.in_mathzone }
	),

	-- R
	s({ trig = "rr", snippetType = "autosnippet" }, {
		t("\\mathbb{R}"),
	}, { condition = tex_utils.in_mathzone }),

	-- Matcal
	s(
		{ trig = "cal", snippetType = "autosnippet" },
		fmta("\\mathcal{<>}", {
			i(1),
		}),
		{ condition = tex_utils.in_mathzone }
	),

	-- set
	s(
		{ trig = "set", snippetType = "autosnippet" },
		fmta("\\left\\{ <> \\right\\}", {
			i(1),
		}),
		{ condition = tex_utils.in_mathzone }
	),

	-- dual pairing
	s(
		{ trig = "dp", snippetType = "autosnippet" },
		fmta("\\langle <> \\rangle", {
			i(1),
		}),
		{ condition = tex_utils.in_mathzone }
	),

	-- underscore h
	s({ trig = "hh", snippetType = "autosnippet", regTrig = true, wordTrig = false }, {
		t("_h"),
	}, { condition = tex_utils.in_mathzone }),

	-- _0
	s({ trig = "h0", snippetType = "autosnippet", regTrig = true, wordTrig = false }, {
		t("_0"),
	}, { condition = tex_utils.in_mathzone }),

	-- inf
	s(
		{ trig = "inf", snippetType = "autosnippet" },
		fmta("\\inf\\limits_{<>}", {
			i(1),
		}),
		{ condition = tex_utils.in_mathzone }
	),

	-- sup
	s(
		{ trig = "sup", snippetType = "autosnippet" },
		fmta("\\sup\\limits_{<>}", {
			i(1),
		}),
		{ condition = tex_utils.in_mathzone }
	),

	-- norm
	s(
		{ trig = "norm", snippetType = "autosnippet" },
		fmta("\\| <> \\|", {
			i(1),
		}),
		{ condition = tex_utils.in_mathzone }
	),

	-- Figure environment
	s(
		{ trig = "fig", snippetType = "autosnippet" },
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
		{ condition = line_begin }
	),

	-- colon
	s({ trig = ":", snippetType = "autosnippet" }, {
		t("\\colon"),
	}, { condition = tex_utils.in_mathzone }),

	-- l2d
	s({ trig = "L2", snippetType = "autosnippet" }, {
		t("\\mathbf{L}^2(\\Omega; \\mathbb{R}^d)"),
	}, { condition = tex_utils.in_mathzone }),

	-- l02
	s({ trig = "l02", snippetType = "autosnippet" }, {
		t("L^2_0"),
	}, { condition = tex_utils.in_mathzone }),

	-- l20d
	s({ trig = "L02", snippetType = "autosnippet" }, {
		t("\\mathbf{L}^2_0(\\Omega; \\mathbb{R}^d)"),
	}, { condition = tex_utils.in_mathzone }),

	-- h1d
	s({ trig = "H1", snippetType = "autosnippet" }, {
		t("\\mathbf{H}^1(\\Omega; \\mathbb{R}^d)"),
	}, { condition = tex_utils.in_mathzone }),

	-- hcurld
	s({ trig = "Hcurl", snippetType = "autosnippet" }, {
		t("\\mathbf{H}^\\mathrm{curl}(\\Omega; \\mathbb{R}^d)"),
	}, { condition = tex_utils.in_mathzone }),

	-- h0curld
	s({ trig = "H0curl", snippetType = "autosnippet" }, {
		t("\\mathbf{H}^\\mathrm{curl}_0(\\Omega; \\mathbb{R}^d)"),
	}, { condition = tex_utils.in_mathzone }),

	--h10d
	s({ trig = "H01", snippetType = "autosnippet" }, {
		t("\\mathbf{H}^1_0(\\Omega; \\mathbb{R}^d)"),
	}, { condition = tex_utils.in_mathzone }),
	-- h10
	s({ trig = "h01", snippetType = "autosnippet" }, {
		t("H^1_0"),
	}, { condition = tex_utils.in_mathzone }),

	-- l20

	-- int_Omega
	s({ trig = "intO", snippetType = "autosnippet" }, {
		t("\\int_\\Omega"),
	}, { condition = tex_utils.in_mathzone }),

	-- int_partial Omega
	s({ trig = "intpO", snippetType = "autosnippet" }, {
		t("\\int_{\\partial\\Omega}"),
	}, { condition = tex_utils.in_mathzone }),

	-- curl operator
	s({ trig = "opcurl", snippetType = "autosnippet" }, {
		t("\\nabla \\times"),
	}, { condition = tex_utils.in_mathzone }),

	-- div operator
	s({ trig = "opdiv", snippetType = "autosnippet" }, {
		t("\\nabla \\cdot"),
	}, { condition = tex_utils.in_mathzone }),

	-- grad operator
	s({ trig = "opgrad", snippetType = "autosnippet" }, {
		t("\\nabla"),
	}, { condition = tex_utils.in_mathzone }),

	-- dx
	s({ trig = "dd", snippetType = "autosnippet" }, {
		t("\\,\\mathrm{d}"),
	}, { condition = tex_utils.in_mathzone }),

	-- (
	s({ trig = "(", snippetType = "autosnippet" }, {
		t("\\left("),
	}, { condition = tex_utils.in_mathzone }),

	--)
	s({ trig = ")", snippetType = "autosnippet" }, {
		t("\\right)"),
	}, { condition = tex_utils.in_mathzone }),
}
