name                        = "Dummy Flingomatic"
description                 = "Help you plan your base as if you have already built an ice flingomatic. Marks its range whenever you plant or build anything near it just like the real ones do. Give parts to upgrade it to the real one. Destroy with hammer for refunds. Inspect to see your upgrading progress."
author                      = "Infernosblade"
version                     = "1.0.5"
forumthread                 = ""
api_version					= 10
dst_compatible 				= true
client_only_mod 			= false
all_clients_require_mod 	= true

icon_atlas = "modicon.xml"
icon = "modicon.tex"

configuration_options =
{
    {
		name = "config_test",
		label = "Test:gives upgrade parts on built",
		options =	{
            {description = "on", data = 1},
            {description = "off", data = 0}

		},
		default = 0,
	}
	}