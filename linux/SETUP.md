# Tmux
- Configure proper colorscheme for Neovim with Tmux
- https://stackoverflow.com/questions/66757229/vim-not-using-proper-colorscheme-in-tmux
add the following lines to tmux.conf:
	set -g default-terminal "tmux-256color"
	set -ga terminal-overrides ",*256col*:Tc"
add to init.vim or vimrc (OPTIONAL):
	set term=xterm-256color

# Neovim
For C/C++ development use "ccls" as LSP and "CMake" as build system
- https://jdhao.github.io/2020/11/29/neovim_cpp_dev_setup/
for Arch-based systems, run:
	sudo pacman -S cmake
	sudo pacman -S ccls