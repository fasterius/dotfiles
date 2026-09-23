# Plugins with `vim.pack`

The built-in package manager `vim.pack` loads all files in the `plugin/`
directory in alphabetical order. Some files are one plugin per file (where a
plugin is not directly related or dependent on other), while some have more than
one plugin per file (such as when plugins are high related or depend on each
other). 

When load order doesn't matter the file is named according to the plugin name (
or the functionality of the plugin group, as applicable), while for plugins with
sensitive load order they are prefixed with a two-digit number, _e.g._
`00-<plugin>`.

Those plugins that are needed for core functionality are eagerly loaded on
start-up, while others are either deferred to after the main start-up loop using
`vim.schedule` or an autocommand on _e.g._ `InsertEnter` or similar. Some
plugins handle their own lazy loading internally and are thus neither deferred
nor handled by autocommand.
