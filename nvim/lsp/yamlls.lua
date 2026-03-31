-- https://github.com/redhat-developer/yaml-language-server#language-server-settings
return {
	settings = {
		yaml = {
			schemas = {
				["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.29.0-standalone-strict/all.json"] = {
					"/*.k8s.yaml",
					"/*.k8s.yml",
				},
			},
			validate = true,
			completion = true,
			hover = true,
		},
	},
}
