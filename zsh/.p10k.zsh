# Catppuccin Latte theme for Powerlevel10k
# Based on catppuccin/latte colors

# Basic UI elements
typeset -g POWERLEVEL9K_RULER_FOREGROUND='#8c8fa1'  # overlay1
if [[ $POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_CHAR != ' ' ]]; then
  typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_FOREGROUND='#8c8fa1'  # overlay1
fi

# Prompt Characters
typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND='#40a02b'  # green
typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND='#d20f39'  # red

# Directory
typeset -g POWERLEVEL9K_DIR_FOREGROUND='#1e66f5'  # blue
typeset -g POWERLEVEL9K_DIR_SHORTENED_FOREGROUND='#1e66f5'  # blue
typeset -g POWERLEVEL9K_DIR_ANCHOR_FOREGROUND='#1e66f5'  # blue
typeset -g POWERLEVEL9K_DIR_ANCHOR_BOLD=true

# Version Control
typeset -g POWERLEVEL9K_VCS_CLEAN_FOREGROUND='#40a02b'  # green
typeset -g POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='#40a02b'  # green
typeset -g POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='#fe640b'  # peach
typeset -g POWERLEVEL9K_VCS_VISUAL_IDENTIFIER_COLOR='#40a02b'  # green
typeset -g POWERLEVEL9K_VCS_LOADING_VISUAL_IDENTIFIER_COLOR='#7c7f93'  # overlay2

# Status indicators
typeset -g POWERLEVEL9K_STATUS_OK_FOREGROUND='#40a02b'  # green
typeset -g POWERLEVEL9K_STATUS_OK_PIPE_FOREGROUND='#40a02b'  # green
typeset -g POWERLEVEL9K_STATUS_ERROR_FOREGROUND='#d20f39'  # red
typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL_FOREGROUND='#d20f39'  # red
typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE_FOREGROUND='#d20f39'  # red

# Command execution and jobs
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='#fe640b'  # peach
typeset -g POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND='#40a02b'  # green

# Development environments and tools
typeset -g POWERLEVEL9K_DIRENV_FOREGROUND='#fe640b'  # peach

# ASDF version manager
typeset -g POWERLEVEL9K_ASDF_FOREGROUND='#7c7f93'  # overlay2
typeset -g POWERLEVEL9K_ASDF_RUBY_FOREGROUND='#ea76cb'  # pink
typeset -g POWERLEVEL9K_ASDF_PYTHON_FOREGROUND='#1e66f5'  # blue
typeset -g POWERLEVEL9K_ASDF_GOLANG_FOREGROUND='#1e66f5'  # blue
typeset -g POWERLEVEL9K_ASDF_NODEJS_FOREGROUND='#40a02b'  # green
typeset -g POWERLEVEL9K_ASDF_RUST_FOREGROUND='#1e66f5'  # blue
typeset -g POWERLEVEL9K_ASDF_DOTNET_CORE_FOREGROUND='#04a5e5'  # sky
typeset -g POWERLEVEL9K_ASDF_FLUTTER_FOREGROUND='#179299'  # teal
typeset -g POWERLEVEL9K_ASDF_LUA_FOREGROUND='#1e66f5'  # blue
typeset -g POWERLEVEL9K_ASDF_JAVA_FOREGROUND='#1e66f5'  # blue
typeset -g POWERLEVEL9K_ASDF_PERL_FOREGROUND='#1e66f5'  # blue
typeset -g POWERLEVEL9K_ASDF_ERLANG_FOREGROUND='#d20f39'  # red
typeset -g POWERLEVEL9K_ASDF_ELIXIR_FOREGROUND='#8839ef'  # mauve
typeset -g POWERLEVEL9K_ASDF_POSTGRES_FOREGROUND='#179299'  # teal
typeset -g POWERLEVEL9K_ASDF_PHP_FOREGROUND='#8839ef'  # mauve
typeset -g POWERLEVEL9K_ASDF_HASKELL_FOREGROUND='#8839ef'  # mauve
typeset -g POWERLEVEL9K_ASDF_JULIA_FOREGROUND='#8839ef'  # mauve

# Python virtual environment
typeset -g POWERLEVEL9K_VIRTUALENV_FOREGROUND='#1e66f5'  # blue
typeset -g POWERLEVEL9K_ANACONDA_FOREGROUND='#40a02b'  # green
typeset -g POWERLEVEL9K_PYENV_FOREGROUND='#1e66f5'  # blue

# Node version manager
typeset -g POWERLEVEL9K_NVM_FOREGROUND='#40a02b'  # green
typeset -g POWERLEVEL9K_NODEENV_FOREGROUND='#40a02b'  # green
typeset -g POWERLEVEL9K_NODE_VERSION_FOREGROUND='#40a02b'  # green

# Ruby
typeset -g POWERLEVEL9K_RBENV_FOREGROUND='#ea76cb'  # pink
typeset -g POWERLEVEL9K_RVM_FOREGROUND='#ea76cb'  # pink
typeset -g POWERLEVEL9K_CHRUBY_FOREGROUND='#ea76cb'  # pink

# Java
typeset -g POWERLEVEL9K_JAVA_VERSION_FOREGROUND='#1e66f5'  # blue

# PHP
typeset -g POWERLEVEL9K_PHP_VERSION_FOREGROUND='#8839ef'  # mauve

# Laravel
typeset -g POWERLEVEL9K_LARAVEL_VERSION_FOREGROUND='#d20f39'  # red

# Terraform
typeset -g POWERLEVEL9K_TERRAFORM_FOREGROUND='#8839ef'  # mauve

# Cloud/Infrastructure
typeset -g POWERLEVEL9K_KUBECONTEXT_FOREGROUND='#04a5e5'  # sky
typeset -g POWERLEVEL9K_KUBECTL_FOREGROUND='#04a5e5'  # sky
typeset -g POWERLEVEL9K_AWS_FOREGROUND='#df8e1d'  # yellow
typeset -g POWERLEVEL9K_AWS_EB_ENV_FOREGROUND='#df8e1d'  # yellow
typeset -g POWERLEVEL9K_AZURE_FOREGROUND='#04a5e5'  # sky
typeset -g POWERLEVEL9K_GCLOUD_FOREGROUND='#1e66f5'  # blue

# Databases
typeset -g POWERLEVEL9K_MYSQL_FOREGROUND='#179299'  # teal
typeset -g POWERLEVEL9K_POSTGRES_FOREGROUND='#179299'  # teal

# System metrics
typeset -g POWERLEVEL9K_RAM_FOREGROUND='#fe640b'  # peach
typeset -g POWERLEVEL9K_SWAP_FOREGROUND='#d20f39'  # red
typeset -g POWERLEVEL9K_DISK_USAGE_FOREGROUND='#df8e1d'  # yellow
typeset -g POWERLEVEL9K_LOAD_FOREGROUND='#fe640b'  # peach
typeset -g POWERLEVEL9K_BATTERY_FOREGROUND='#40a02b'  # green
typeset -g POWERLEVEL9K_BATTERY_CHARGED_FOREGROUND='#40a02b'  # green
typeset -g POWERLEVEL9K_BATTERY_CHARGING_FOREGROUND='#df8e1d'  # yellow
typeset -g POWERLEVEL9K_BATTERY_LOW_FOREGROUND='#d20f39'  # red
typeset -g POWERLEVEL9K_BATTERY_DISCONNECTED_FOREGROUND='#8c8fa1'  # overlay1

# Network and connectivity
typeset -g POWERLEVEL9K_PUBLIC_IP_FOREGROUND='#04a5e5'  # sky
typeset -g POWERLEVEL9K_VPN_IP_FOREGROUND='#df8e1d'  # yellow
typeset -g POWERLEVEL9K_WIFI_FOREGROUND='#04a5e5'  # sky

# Time
typeset -g POWERLEVEL9K_TIME_FOREGROUND='#8839ef'  # mauve

# User info
typeset -g POWERLEVEL9K_USER_FOREGROUND='#1e66f5'  # blue
typeset -g POWERLEVEL9K_USER_ROOT_FOREGROUND='#d20f39'  # red
typeset -g POWERLEVEL9K_HOST_FOREGROUND='#40a02b'  # green
typeset -g POWERLEVEL9K_HOST_LOCAL_FOREGROUND='#40a02b'  # green
typeset -g POWERLEVEL9K_HOST_REMOTE_FOREGROUND='#df8e1d'  # yellow

# Context (user@host)
typeset -g POWERLEVEL9K_CONTEXT_FOREGROUND='#1e66f5'  # blue
typeset -g POWERLEVEL9K_CONTEXT_ROOT_FOREGROUND='#d20f39'  # red
typeset -g POWERLEVEL9K_CONTEXT_REMOTE_FOREGROUND='#df8e1d'  # yellow
typeset -g POWERLEVEL9K_CONTEXT_REMOTE_SUDO_FOREGROUND='#d20f39'  # red

# SSH
typeset -g POWERLEVEL9K_SSH_FOREGROUND='#df8e1d'  # yellow

# Ranger file manager
typeset -g POWERLEVEL9K_RANGER_FOREGROUND='#40a02b'  # green

# Midnight Commander file manager
typeset -g POWERLEVEL9K_MIDNIGHT_COMMANDER_FOREGROUND='#40a02b'  # green

# nnn file manager
typeset -g POWERLEVEL9K_NNN_FOREGROUND='#40a02b'  # green

# xplr file manager
typeset -g POWERLEVEL9K_XPLR_FOREGROUND='#40a02b'  # green

# Vi mode
typeset -g POWERLEVEL9K_VI_MODE_INSERT_FOREGROUND='#40a02b'  # green
typeset -g POWERLEVEL9K_VI_MODE_NORMAL_FOREGROUND='#1e66f5'  # blue
typeset -g POWERLEVEL9K_VI_MODE_VISUAL_FOREGROUND='#8839ef'  # mauve
typeset -g POWERLEVEL9K_VI_MODE_OVERWRITE_FOREGROUND='#d20f39'  # red
typeset -g POWERLEVEL9K_VI_MODE_REPLACE_FOREGROUND='#fe640b'  # peach

# Task management
typeset -g POWERLEVEL9K_TASKWARRIOR_FOREGROUND='#fe640b'  # peach
typeset -g POWERLEVEL9K_TODO_FOREGROUND='#df8e1d'  # yellow

# Mail
typeset -g POWERLEVEL9K_MAIL_FOREGROUND='#ea76cb'  # pink

# Package managers
typeset -g POWERLEVEL9K_PACKAGE_FOREGROUND='#8839ef'  # mauve

# Disk usage
typeset -g POWERLEVEL9K_DISK_USAGE_NORMAL_FOREGROUND='#40a02b'  # green
typeset -g POWERLEVEL9K_DISK_USAGE_WARNING_FOREGROUND='#df8e1d'  # yellow
typeset -g POWERLEVEL9K_DISK_USAGE_CRITICAL_FOREGROUND='#d20f39'  # red

# Permissions
typeset -g POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND='#d20f39'  # red

# Lock and unlock
typeset -g POWERLEVEL9K_LOCK_FOREGROUND='#d20f39'  # red

# Instant prompt mode
typeset -g POWERLEVEL9K_INSTANT_PROMPT_FOREGROUND='#8c8fa1'  # overlay1

# Transient prompt
typeset -g POWERLEVEL9K_TRANSIENT_PROMPT=same-dir

# Keep existing prompt elements configuration from original file
typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
  dir                     # current directory
  vcs                     # git status
  prompt_char             # prompt symbol
)

typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
  # Minimal set - only show on-demand info
  status                  # exit code of the last command (only shows on error)
  command_execution_time  # duration of the last command (only shows if > threshold)
  # Uncomment any of these if you need them:
  # kubecontext           # kubernetes context (useful if you work with k8s)
  # virtualenv            # python virtual environment (shows only when active)
  # time                  # current time
)

# Basic style options that should match your original config
typeset -g POWERLEVEL9K_ICON_PADDING=none
typeset -g POWERLEVEL9K_BACKGROUND=                            # transparent background
typeset -g POWERLEVEL9K_{LEFT,RIGHT}_{LEFT,RIGHT}_WHITESPACE=  # no surrounding whitespace
typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SUBSEGMENT_SEPARATOR=' '  # separate segments with a space
typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SEGMENT_SEPARATOR=        # no end-of-line symbol

# Disable the default configuration that may have been set earlier
(( ! $+functions[p10k] )) || p10k reload

# Apply configuration
# Configuration applied via theme settings above