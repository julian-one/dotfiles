-- https://github.com/sveltejs/language-tools/tree/master/packages/language-server
return {
	settings = {
		typescript = {
			inlayHints = {
				parameterNames = { enabled = "all" },
				parameterTypes = { enabled = true },
				variableTypes = { enabled = true },
				propertyDeclarationTypes = { enabled = true },
				functionLikeReturnTypes = { enabled = true },
				enumMemberValues = { enabled = true },
			},
		},
		svelte = {
			plugin = {
				svelte = {
					defaultScriptLanguage = "ts",
					runesLegacyModeCodeLens = {
						enable = true,
					},
					compilerWarnings = {
						["a11y-click-events-have-key-events"] = "warn",
						["a11y-no-static-element-interactions"] = "warn",
					},
				},
				html = {
					completions = {
						enable = true,
						emmet = true,
					},
					tagComplete = {
						enable = true,
					},
				},
				css = {
					completions = {
						enable = true,
						emmet = true,
					},
				},
			},
		},
	},
}
