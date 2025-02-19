# ~/.bash_profile: executed for login shells.

# Load .bashrc if it exists
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

export BASH_SILENCE_DEPRECATION_WARNING=1

# Add local bin to PATH
export PATH="/usr/local/bin:$PATH"

# Ensure Homebrew is correctly loaded
eval "$(/usr/local/bin/brew shellenv)"

# Set LLVM paths correctly
export PATH="/usr/local/opt/llvm/bin:$PATH"
export CC=/usr/local/opt/llvm/bin/clang
export CXX=/usr/local/opt/llvm/bin/clang++
export LDFLAGS="-L/usr/local/opt/llvm/lib"
export CPPFLAGS="-I/usr/local/opt/llvm/include"

# Add Go binaries to PATH
export PATH="$HOME/go/bin:$PATH"

# K3S
export KUBECONFIG=~/.kube/config
