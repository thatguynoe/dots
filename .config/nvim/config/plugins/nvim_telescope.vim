nnoremap <silent> <Leader>ff :Telescope find_files<cr>
nnoremap <silent> <Leader>fb :Telescope buffers<cr>

lua << END
require('telescope').setup{
  defaults = {
    file_ignore_patterns = {
      "pdf",
      "png",
      "docx",
      "doc",
      "mscz",
      "mp3",
      "xlsx",
      "jpeg",
      ".git/[^h]"
    }
  }
}
END
