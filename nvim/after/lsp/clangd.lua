-- CLT clangd: brew requires the CLT anyway, and full llvm is 1.8 GB for this one binary.
return {
  cmd = {
    "/Library/Developer/CommandLineTools/usr/bin/clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--fallback-style=llvm",
  },
}
