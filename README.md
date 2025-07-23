# NixOS Configuration | Конфигурация NixOS

<div align="center">

![NixOS](https://img.shields.io/badge/NixOS-23.11-blue.svg?style=flat-square&logo=nixos)
![Hyprland](https://img.shields.io/badge/WM-Hyprland-purple.svg?style=flat-square)
![License](https://img.shields.io/badge/License-MIT-green.svg?style=flat-square)

**A modern, feature-rich NixOS configuration with Hyprland, 30+ development environments, and optimized Zsh setup**

**Современная, функциональная конфигурация NixOS с Hyprland, 30+ средами разработки и оптимизированной настройкой Zsh**

</div>

---

## 🌐 Table of Contents | Содержание

**English:**
- [Features](#-features)
- [Quick Start](#-quick-start)
- [Installation](#%EF%B8%8F-installation)
- [Customization](#-customization)
- [Hotkeys & Keybindings](#%EF%B8%8F-hotkeys--keybindings)
- [Zsh Aliases & Functions](#-zsh-aliases--functions)
- [Development Environments](#-development-environments)
- [System Management](#%EF%B8%8F-system-management)

**Русский:**
- [Особенности](#-особенности)
- [Быстрый старт](#-быстрый-старт-rus)
- [Установка](#%EF%B8%8F-установка-rus)
- [Кастомизация](#-кастомизация-rus)
- [Горячие клавиши](#%EF%B8%8F-горячие-клавиши-rus)
- [Алиасы и функции Zsh](#-алиасы-и-функции-zsh-rus)
- [Среды разработки](#-среды-разработки-rus)
- [Управление системой](#%EF%B8%8F-управление-системой-rus)

---

## ✨ Features

### 🖥️ Desktop Environment
- **Hyprland** - Modern Wayland compositor with tiling window management
- **SDDM** - Login manager with astronaut theme
- **Waybar** - Customizable status bar
- **Rofi** - Application launcher and dmenu replacement
- **Catppuccin** theme throughout the system

### 🛠️ Development Tools
- **30+ Development Shells** for different programming languages
- **NixVim** - Neovim configuration in Nix
- **Starship** - Cross-shell prompt
- **Tmux** with custom configuration
- **Git** with enhanced aliases and functions

### 🎯 Productivity Features
- **Enhanced Zsh** with powerful plugins and 100+ aliases
- **FZF integration** for fuzzy finding
- **Auto-completion** and syntax highlighting
- **Smart file management** with Yazi/LF
- **Built-in media server** (MiniDLNA)

### 🎨 Theming & Customization
- Multiple wallpapers (Kurzgesagt, Cyberpunk, etc.)
- Bibata cursor theme
- JetBrains Mono and Fira Code fonts
- Consistent Catppuccin theming

---

## 🚀 Quick Start

```bash
# Clone the repository
git clone https://github.com/yourusername/nixos-config.git
cd nixos-config

# For live ISO installation
sudo ./live-install.sh

# For existing NixOS system
./install.sh
```

---

## ⚙️ Installation

### Prerequisites
- NixOS 23.11 or later
- UEFI system (BIOS support available)
- At least 8GB RAM recommended
- 50GB+ storage space

### Method 1: Live ISO Installation
1. Boot into NixOS live environment
2. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/nixos-config.git
   cd nixos-config
   ```
3. Run the interactive installer:
   ```bash
   sudo ./live-install.sh
   ```
4. Follow the prompts for disk partitioning and user setup

### Method 2: Existing System
1. Clone the repository to your home directory:
   ```bash
   git clone https://github.com/yourusername/nixos-config.git ~/NixOS
   cd ~/NixOS
   ```
2. Run the installation script:
   ```bash
   ./install.sh
   ```

### Post-Installation
After reboot, the system will:
- Start with Hyprland window manager
- Have all development tools available
- Include optimized Zsh configuration
- Support for all configured hardware

---

## 🎨 Customization

### Changing System Settings
Edit `flake.nix` to modify:

```nix
settings = {
  username = "yourusername";        # Your username
  editor = "nixvim";               # nixvim, vscode, nvchad, neovim
  browser = "floorp";              # firefox, floorp, zen
  terminal = "kitty";              # kitty, alacritty, wezterm
  terminalFileManager = "yazi";    # yazi or lf
  videoDriver = "intel";           # nvidia, amdgpu, intel
  hostname = "nixos";              # System hostname
  locale = "en_US.UTF-8";          # System locale
  timezone = "UTC";                # System timezone
  wallpaper = "kurzgesagt";        # See modules/themes/wallpapers
};
```

### Adding Programs
Add modules in `hosts/Default/configuration.nix`:
```nix
imports = [
  # Add new modules here
  ../../modules/programs/media/obs-studio
  ../../modules/programs/misc/virt-manager
];
```

### Desktop Environments
Switch between desktop environments by uncommenting in `configuration.nix`:
```nix
# For Hyprland (default)
../../modules/desktop/hyprland

# For i3-gaps
# ../../modules/desktop/i3-gaps

# For GNOME
# ../../modules/desktop/gnome
```

---

## ⌨️ Hotkeys & Keybindings

### Hyprland Window Manager
| Key Combination | Action |
|------------------|--------|
| `SUPER + Return` | Open terminal |
| `SUPER + D` | Application launcher (Rofi) |
| `SUPER + Q` | Close window |
| `SUPER + M` | Exit Hyprland |
| `SUPER + V` | Toggle floating window |
| `SUPER + F` | Toggle fullscreen |
| `SUPER + Space` | Change keyboard layout |
| `SUPER + L` | Lock screen |

### Window Navigation
| Key Combination | Action |
|------------------|--------|
| `SUPER + ←/→/↑/↓` | Move focus |
| `SUPER + H/J/K/L` | Move focus (Vim keys) |
| `SUPER + SHIFT + ←/→/↑/↓` | Move window |
| `SUPER + CTRL + ←/→/↑/↓` | Resize window |

### Workspaces
| Key Combination | Action |
|------------------|--------|
| `SUPER + 1-9` | Switch to workspace |
| `SUPER + SHIFT + 1-9` | Move window to workspace |
| `SUPER + Mouse Wheel` | Cycle through workspaces |

### System Controls
| Key Combination | Action |
|------------------|--------|
| `SUPER + SHIFT + E` | Power menu |
| `Print Screen` | Screenshot |
| `SUPER + SHIFT + S` | Screenshot selection |
| `XF86AudioRaiseVolume` | Increase volume |
| `XF86AudioLowerVolume` | Decrease volume |
| `XF86AudioMute` | Toggle mute |
| `XF86MonBrightnessUp` | Increase brightness |
| `XF86MonBrightnessDown` | Decrease brightness |

### Zsh Terminal Hotkeys
| Key Combination | Action |
|------------------|--------|
| `Ctrl + F` | Find directory with FZF |
| `Ctrl + R` | Search command history with FZF |
| `Ctrl + L` | Open file manager (Yazi/LF) |
| `Ctrl + A` | Beginning of line |
| `Ctrl + E` | End of line |
| `Ctrl + K/J` | Navigate history |
| `Ctrl + O` | Go to parent directory |
| `Ctrl + T` | Tmux sessionizer |

---

## 🔧 Zsh Aliases & Functions

### File Operations
```bash
# Navigation
..          # cd ..
...         # cd ../..
....        # cd ../../..

# Listing
l           # eza -lh --icons --git
ll          # eza -lha --icons --git --sort=name --group-directories-first
la          # eza -a --icons
tree        # eza --tree --level=3

# File operations
cp          # cp -iv (interactive, verbose)
mv          # mv -iv
rm          # rm -vI
mkdir       # mkdir -pv
```

### Git Shortcuts
```bash
g           # git
ga          # git add
gaa         # git add --all
gc          # git commit
gcm         # git commit -m
gca         # git commit --amend
gco         # git checkout
gb          # git branch
gbd         # git branch -d
gs          # git status --short --branch
gst         # git status
gl          # git log --oneline --graph --decorate
gla         # git log --oneline --graph --decorate --all
gd          # git diff
gdc         # git diff --cached
gp          # git push
gpu         # git push -u origin HEAD
gpl         # git pull
gf          # git fetch
gr          # git remote -v
gm          # git merge
grh         # git reset --hard
grs         # git reset --soft
gclean      # git clean -fd
```

### System Information
```bash
nf          # microfetch
neofetch    # neofetch
htop        # btop
top         # btop
df          # df -h
du          # du -h
free        # free -h
ps          # ps auxf
```

### Docker (if available)
```bash
d           # docker
dc          # docker-compose
dps         # docker ps
di          # docker images
dlog        # docker logs
dexec       # docker exec -it
```

### Tmux
```bash
t           # tmux
ta          # tmux attach
tat         # tmux attach -t
tn          # tmux new-session
tns         # tmux new-session -s
tl          # tmux list-sessions
tk          # tmux kill-session
tks         # tmux kill-session -t
```

### NixOS Specific
```bash
rebuild     # Rebuild system configuration
sysup       # System update with flake upgrade
nixup       # Update flake inputs
nixgc       # Garbage collection
nixstore    # Store garbage collection
nixoptimise # Optimize nix store
nixsearch   # Search packages
nixshell    # nix-shell
nixrun      # nix run nixpkgs#
```

### Quick Navigation
```bash
home        # cd ~
dots        # cd ~/NixOS/
conf        # cd ~/NixOS/
work        # cd /mnt/work/
proj        # cd /mnt/work/Projects/
dev         # cd /mnt/work/Projects/
downloads   # cd ~/Downloads/
docs        # cd ~/Documents/
```

### Custom Functions
```bash
# File management
mkcd <dir>              # Create directory and cd into it
backup <file>           # Create timestamped backup
dirsize [dir]           # Show directory size
bigfiles [size]         # Find large files (default: >100M)
tmpd                    # Create and cd to temp directory

# Search and information
findin <text>           # Search text in files recursively
h [pattern]             # Search command history
hf                      # Execute command from history with FZF
psg <pattern>           # Search running processes
countlines [extension]  # Count lines of code in project

# System utilities
sysinfo                 # Show detailed system information
weather [city]          # Get weather information
myip                    # Show external IP address
qr <text>               # Generate QR code

# Notes
note <text>             # Add timestamped note
notes                   # View all notes

# Development
gclone <url>            # Clone repo and cd into it
gcommit <message>       # Add all and commit
gpush                   # Push to current branch
gstatus                 # Short git status

# Quick navigation
j <shortcut>            # Jump to common directories
# j home, j work, j proj, j downloads, j docs

# Configuration editing
editconfig <config>     # Quick edit configs
# editconfig zsh, editconfig hypr, editconfig flake
```

---

## 💻 Development Environments

This configuration includes 30+ pre-configured development environments:

### Available Templates
```bash
# Web Development
bun         # Bun runtime environment
node        # Node.js development
php         # PHP development

# Systems Programming
c-cpp       # C/C++ with CMake
rust        # Rust development
rust-toolchain # Rust with toolchain file
go          # Go development
zig         # Zig development

# JVM Languages
java        # Java development
kotlin      # Kotlin development
scala       # Scala development

# Functional Programming
haskell     # Haskell development
elm         # Elm development
clojure     # Clojure development
ocaml       # OCaml development

# Scripting
python      # Python development
ruby        # Ruby development
elixir      # Elixir development
nim         # Nim development

# Other Languages
csharp      # C# development
swift       # Swift development
vlang       # V language development

# Specialized
latex       # LaTeX document preparation
jupyter     # Jupyter notebook environment
hashi       # HashiCorp tools (Terraform, Vault, etc.)
nix         # Nix development tools
```

### Using Development Environments
```bash
# Create new project with template
fnew <project_name> <template>
# Example: fnew my-rust-app rust

# Initialize template in current directory
finit <template>
# Example: finit python

# For C++ projects specifically
cgen <project_name>  # Creates C++ project with CMake
crun                 # Build and run C++ project
cbuild              # Build C++ project only
```

### Development Tools Included
- **Language Servers** for all supported languages
- **Debuggers** and profilers
- **Build tools** (Make, CMake, Cargo, etc.)
- **Package managers** for each ecosystem
- **Formatters** and linters
- **Testing frameworks**

---

## 🛠️ System Management

### Rebuilding System
```bash
# Quick rebuild (recommended)
rebuild

# Full system upgrade
sysup

# Update flake inputs
nixup
```

### Maintenance
```bash
# Clean old generations (automatic weekly)
nixgc

# Optimize store
nixoptimise

# Check system status
systemctl status

# View logs
journalctl -f
```

### Managing Generations
```bash
# List system generations
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system/

# Rollback to previous generation
sudo nixos-rebuild switch --rollback

# Boot into specific generation
sudo nixos-rebuild boot --rollback
```

---

## 🌐 Русский | Russian

## 🌟 Особенности

### 🖥️ Рабочее окружение
- **Hyprland** - Современный Wayland композитор с тайлинговым управлением окнами
- **SDDM** - Менеджер входа с темой космонавта
- **Waybar** - Настраиваемая панель состояния
- **Rofi** - Лаунчер приложений и замена dmenu
- **Catppuccin** тема во всей системе

### 🛠️ Инструменты разработки
- **30+ сред разработки** для разных языков программирования
- **NixVim** - конфигурация Neovim в Nix
- **Starship** - межоболочечный промпт
- **Tmux** с пользовательской конфигурацией
- **Git** с улучшенными алиасами и функциями

### 🎯 Возможности продуктивности
- **Улучшенный Zsh** с мощными плагинами и 100+ алиасами
- **Интеграция FZF** для нечёткого поиска
- **Автодополнение** и подсветка синтаксиса
- **Умное управление файлами** с Yazi/LF
- **Встроенный медиасервер** (MiniDLNA)

---

## 🚀 Быстрый старт (RUS)

```bash
# Клонирование репозитория
git clone https://github.com/yourusername/nixos-config.git
cd nixos-config

# Для установки с live ISO
sudo ./live-install.sh

# Для существующей системы NixOS
./install.sh
```

---

## ⚙️ Установка (RUS)

### Требования
- NixOS 23.11 или новее
- UEFI система (поддержка BIOS доступна)
- Рекомендуется минимум 8ГБ ОЗУ
- 50ГБ+ дискового пространства

### Метод 1: Установка с Live ISO
1. Загрузитесь в среду NixOS live
2. Клонируйте репозиторий:
   ```bash
   git clone https://github.com/yourusername/nixos-config.git
   cd nixos-config
   ```
3. Запустите интерактивный установщик:
   ```bash
   sudo ./live-install.sh
   ```
4. Следуйте подсказкам для разметки диска и настройки пользователя

### Метод 2: Существующая система
1. Клонируйте репозиторий в домашнюю директорию:
   ```bash
   git clone https://github.com/yourusername/nixos-config.git ~/NixOS
   cd ~/NixOS
   ```
2. Запустите скрипт установки:
   ```bash
   ./install.sh
   ```

---

## 🎨 Кастомизация (RUS)

### Изменение настроек системы
Отредактируйте `flake.nix`:

```nix
settings = {
  username = "имя_пользователя";      # Ваше имя пользователя
  editor = "nixvim";                  # nixvim, vscode, nvchad, neovim
  browser = "floorp";                 # firefox, floorp, zen
  terminal = "kitty";                 # kitty, alacritty, wezterm
  terminalFileManager = "yazi";       # yazi или lf
  videoDriver = "intel";              # nvidia, amdgpu, intel
  hostname = "nixos";                 # Имя хоста системы
  locale = "ru_RU.UTF-8";            # Локаль системы
  timezone = "Europe/Moscow";         # Часовой пояс
  wallpaper = "kurzgesagt";          # См. modules/themes/wallpapers
};
```

---

## ⌨️ Горячие клавиши (RUS)

### Оконный менеджер Hyprland
| Комбинация клавиш | Действие |
|-------------------|----------|
| `SUPER + Return` | Открыть терминал |
| `SUPER + D` | Лаунчер приложений (Rofi) |
| `SUPER + Q` | Закрыть окно |
| `SUPER + M` | Выйти из Hyprland |
| `SUPER + V` | Переключить плавающее окно |
| `SUPER + F` | Переключить полноэкранный режим |
| `SUPER + Space` | Сменить раскладку клавиатуры |
| `SUPER + L` | Заблокировать экран |

### Навигация по окнам
| Комбинация клавиш | Действие |
|-------------------|----------|
| `SUPER + ←/→/↑/↓` | Переместить фокус |
| `SUPER + H/J/K/L` | Переместить фокус (клавиши Vim) |
| `SUPER + SHIFT + ←/→/↑/↓` | Переместить окно |
| `SUPER + CTRL + ←/→/↑/↓` | Изменить размер окна |

### Горячие клавиши терминала Zsh
| Комбинация клавиш | Действие |
|-------------------|----------|
| `Ctrl + F` | Найти директорию с FZF |
| `Ctrl + R` | Поиск по истории команд с FZF |
| `Ctrl + L` | Открыть файловый менеджер |
| `Ctrl + A` | В начало строки |
| `Ctrl + E` | В конец строки |
| `Ctrl + K/J` | Навигация по истории |

---

## 🔧 Алиасы и функции Zsh (RUS)

### Файловые операции
```bash
# Навигация
..          # cd ..
...         # cd ../..
....        # cd ../../..

# Просмотр файлов
l           # eza -lh --icons --git
ll          # eza -lha --icons --git --sort=name --group-directories-first
tree        # eza --tree --level=3

# Операции с файлами
cp          # cp -iv (интерактивно, подробно)
mv          # mv -iv
rm          # rm -vI
mkdir       # mkdir -pv
```

### Git ярлыки
```bash
g           # git
ga          # git add
gc          # git commit
gs          # git status --short --branch
gl          # git log --oneline --graph
gd          # git diff
gp          # git push
gpl         # git pull
```

### Пользовательские функции
```bash
# Управление файлами
mkcd <папка>            # Создать папку и перейти в неё
backup <файл>           # Создать резервную копию с timestamp
dirsize [папка]         # Показать размер папки
tmpd                    # Создать временную папку и перейти в неё

# Поиск и информация
findin <текст>          # Поиск текста в файлах
h [паттерн]             # Поиск по истории команд
sysinfo                 # Показать информацию о системе
weather [город]         # Получить информацию о погоде

# Заметки
note <текст>            # Добавить заметку с timestamp
notes                   # Просмотреть все заметки

# Быстрая навигация
j <ярлык>               # Перейти к часто используемым папкам
# j home, j work, j proj, j downloads

# Редактирование конфигов
editconfig <конфиг>     # Быстрое редактирование конфигов
# editconfig zsh, editconfig hypr, editconfig flake
```

---

## 💻 Среды разработки (RUS)

Конфигурация включает 30+ предварительно настроенных сред разработки:

### Доступные шаблоны
```bash
# Веб-разработка
bun         # Среда выполнения Bun
node        # Разработка Node.js
php         # Разработка PHP

# Системное программирование
c-cpp       # C/C++ с CMake
rust        # Разработка Rust
go          # Разработка Go
zig         # Разработка Zig

# JVM языки
java        # Разработка Java
kotlin      # Разработка Kotlin
scala       # Разработка Scala

# Функциональное программирование
haskell     # Разработка Haskell
elm         # Разработка Elm
clojure     # Разработка Clojure

# Скриптовые языки
python      # Разработка Python
ruby        # Разработка Ruby
elixir      # Разработка Elixir

# Специализированные
latex       # Подготовка документов LaTeX
jupyter     # Среда Jupyter notebook
hashi       # Инструменты HashiCorp
nix         # Инструменты разработки Nix
```

### Использование сред разработки
```bash
# Создать новый проект с шаблоном
fnew <имя_проекта> <шаблон>
# Пример: fnew my-rust-app rust

# Инициализировать шаблон в текущей папке
finit <шаблон>
# Пример: finit python

# Специально для проектов C++
cgen <имя_проекта>  # Создаёт проект C++ с CMake
crun                # Собрать и запустить проект C++
cbuild              # Только собрать проект C++
```

---

## 🛠️ Управление системой (RUS)

### Пересборка системы
```bash
# Быстрая пересборка (рекомендуется)
rebuild

# Полное обновление системы
sysup

# Обновить входные данные flake
nixup
```

### Обслуживание
```bash
# Очистить старые поколения
nixgc

# Оптимизировать хранилище
nixoptimise

# Проверить состояние системы
systemctl status

# Просмотреть логи
journalctl -f
```