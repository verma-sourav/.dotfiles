require('nvim-treesitter.configs').setup({
  -- Can be "all" or a list of parsers.
  ensure_installed = "all",
  ignore_install = { "phpdoc" },

  -- Should language parsers be installed synchronously (only applies to `ensure_installed`)
  sync_install = false,

  highlight = {
    -- False will disable the whole extension
    enable = true,

    -- List of languages that will be disabled
    disable = { "" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = true,
  },
  indent = {
    enable = true,
    disable = { "yaml" }
  },
})
