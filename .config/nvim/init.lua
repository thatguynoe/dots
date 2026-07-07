-- Load core settings before plugins
require('config.mappings')
require('config.misc_settings')
require('config.visual')
require('config.editing')

-- Install/load plugins and configure them
require('config.plugins')

-- Post-plugin configuration
require('config.lsp')
require('config.files')
