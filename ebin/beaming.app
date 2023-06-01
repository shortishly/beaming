{application, 'beaming', [
	{description, ""},
	{vsn, "0.1.0"},
	{modules, ['beaming','beaming_app','beaming_sup']},
	{registered, [beaming_sup]},
	{applications, [kernel,stdlib]},
	{optional_applications, []},
	{mod, {beaming_app, []}},
	{env, []}
]}.