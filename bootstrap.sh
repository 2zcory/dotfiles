#!/usr/bin/env bash

# ==============================================================================
#  BOOTSTRAP.SH - KỊCH BẢN TỰ ĐỘNG THIẾT LẬP MÔI TRƯỜNG LÀM VIỆC TRÊN MAC OS
#  Dự án: Tự động hóa & Tối ưu hóa Môi trường Làm việc Dotfiles
#  Tiêu chuẩn: Zero-Touch, Tương thích Apple Silicon & Intel Mac
# ==============================================================================

# Ngăn chặn script tiếp tục chạy nếu gặp lỗi bất ngờ hoặc biến chưa định nghĩa
set -euo pipefail

# --- ĐỊNH NGHĨA MÀU SẮC GIAO DIỆN (UI TOKENS) ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color (Reset)

# --- KHỞI TẠO CÁC BIẾN TOÀN CỤC ĐỘNG ---
# Tự động dò tìm thư mục chứa script đang thực thi thực tế
CURRENT_SOURCE="${BASH_SOURCE[0]}"
# Giải quyết liên kết mềm (symlink) của chính file script nếu có
while [ -h "$CURRENT_SOURCE" ]; do
    DIR="$(cd -P "$(dirname "$CURRENT_SOURCE")" && pwd)"
    CURRENT_SOURCE="$(readlink "$CURRENT_SOURCE")"
    [[ $CURRENT_SOURCE != /* ]] && CURRENT_SOURCE="$DIR/$CURRENT_SOURCE"
done
SCRIPT_DIR="$(cd -P "$(dirname "$CURRENT_SOURCE")" && pwd)"

# Cơ chế Fallback: Nếu chạy trực tiếp từ xa (stdin/curl) thì đặt mặc định ở $HOME/dotfiles
if [ -z "${SCRIPT_DIR}" ] || [ "${SCRIPT_DIR}" = "/tmp" ] || [[ "${SCRIPT_DIR}" == *"/sh"* ]]; then
    REPO_DIR="$HOME/wp/dotfiles"
else
    REPO_DIR="${SCRIPT_DIR}"
fi

BACKUP_DIR="$HOME/dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

# --- TRÌNH BÀY UI HEADER ---
clear
echo -e "${CYAN}${BOLD}===============================================================${NC}"
echo -e "${CYAN}${BOLD}       2Z-DOTFILES AUTOMATION BOOTSTRAPPER (macOS)             ${NC}"
echo -e "${CYAN}${BOLD}===============================================================${NC}"
echo -e "${BLUE}Thực thi bởi: TriNK${NC}"
echo -e "${BLUE}Thư mục nguồn cấu hình (REPO_DIR): ${BOLD}$REPO_DIR${NC}"
echo -e "${CYAN}${BOLD}===============================================================${NC}\n"

# --- 1. KIỂM TRA XCODE COMMAND LINE TOOLS (SỰ PHỤ THUỘC NỀN TẢNG) ---
echo -e "${PURPLE}[1/7] Đang kiểm tra Xcode Command Line Tools...${NC}"
if ! xcode-select -p &>/dev/null; then
    echo -e "${YELLOW}Xcode Command Line Tools chưa được cài đặt. Đang kích hoạt tiến trình cài đặt...${NC}"
    
    # Tạo tệp tin trigger tạm để buộc hệ thống macOS tìm kiếm cập nhật CLI thầm lặng
    touch /tmp/.ca_bootstrap_xcode_install
    
    # Kích hoạt trình cài đặt chính thức của Apple
    xcode-select --install
    
    echo -e "${RED}${BOLD}LƯU Ý:${NC} Một hộp thoại GUI yêu cầu cài đặt Xcode CLI đã xuất hiện."
    echo -e "Vui lòng click ${BOLD}'Install'${NC} và đồng ý với các điều khoản."
    echo -e "Sau khi cài đặt Xcode CLI hoàn tất, hãy chạy lại script này."
    exit 0
else
    echo -e "${GREEN}✓ Xcode Command Line Tools đã sẵn sàng trên hệ thống.${NC}"
fi

# --- 2. CÀI ĐẶT / NẠP BIẾN MÔI TRƯỜNG HOMEBREW ---
echo -e "\n${PURPLE}[2/7] Đang kiểm tra và thiết lập Homebrew...${NC}"
if ! command -v brew &>/dev/null; then
    echo -e "${YELLOW}Homebrew chưa được phát hiện. Bắt đầu tiến trình tải và cài đặt tự động...${NC}"
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Định cấu hình PATH ngay lập tức dựa trên kiến trúc chip phần cứng mà không cần mở lại Shell
    if [[ "$(uname -m)" == "arm64" ]]; then
        echo -e "${CYAN}Hệ thống chạy trên Apple Silicon (arm64). Nạp /opt/homebrew...${NC}"
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        echo -e "${CYAN}Hệ thống chạy trên Intel Mac (x86_64). Nạp /usr/local...${NC}"
        eval "$(/usr/local/bin/brew shellenv)"
    fi
else
    echo -e "${GREEN}✓ Homebrew đã được cài đặt.${NC}"
    # Đồng bộ hóa PATH của phiên chạy hiện tại
    if [ -f "/opt/homebrew/bin/brew" ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [ -f "/usr/local/bin/brew" ]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi
fi

# Đảm bảo Brew hoạt động ổn định và cập nhật cơ sở dữ liệu gói mới nhất
echo -e "${BLUE}Đang đồng bộ hóa cơ sở dữ liệu Brew (brew update)...${NC}"
brew update --quiet

# --- 3. CÀI ĐẶT CÁC THÀNH PHẦN KỸ THUẬT & TERMINAL ---
echo -e "\n${PURPLE}[3/7] Đang cài đặt các Gói phần mềm cốt lõi & Terminal...${NC}"

# Danh sách ứng dụng cài đặt dạng CLI
cli_packages=(
    "git"         # Quản lý mã nguồn
    "neovim"      # Trình soạn thảo văn bản hiệu năng cao (Lua-based)
    "ripgrep"     # Tìm kiếm chuỗi cực nhanh cho Telescope
    "fzf"         # Bộ lọc tìm kiếm tương tác
    "eza"         # Lệnh thay thế ls hiện đại
    "fd"          # Lệnh thay thế find nhanh chóng
    "bat"         # Trình xem file có tô màu cú pháp
    "zsh"         # Shell làm việc chính
)

# Cài đặt các gói CLI
for pkg in "${cli_packages[@]}"; do
    if ! brew list "$pkg" &>/dev/null; then
        echo -e "${BLUE}Đang cài đặt gói: ${BOLD}$pkg${NC}..."
        brew install "$pkg" --quiet
    else
        echo -e "${GREEN}✓ Gói $pkg đã có sẵn trên máy.${NC}"
    fi
done

# Cài đặt WezTerm nếu chưa có
if ! brew list --cask wezterm &>/dev/null; then
    brew install --cask wezterm --quiet
else
    echo -e "${GREEN}✓ WezTerm Terminal đã được cài đặt.${NC}"
fi

# Cài đặt Font chữ Nerd Font để hiển thị Glyph không bị lỗi mã hoá
if ! brew list --cask font-jetbrains-mono-nerd-font &>/dev/null; then
    brew install --cask font-jetbrains-mono-nerd-font --quiet
else
    echo -e "${GREEN}✓ JetBrains Mono Nerd Font đã được cài đặt.${NC}"
fi

# --- 4. TỰ ĐỘNG HÓA HẠ TẦNG ZSH (OH-MY-ZSH, PLUGINS & NVM) ---
echo -e "\n${PURPLE}[4/7] Đang thiết lập Oh-My-Zsh, 5 Plugins chính & NVM...${NC}"

# 4.1 Cài đặt Oh-My-Zsh (Tải thầm lặng không làm nghẽn tiến trình)
ZSH_DIR="$HOME/.oh-my-zsh"
if [ ! -f "$ZSH_DIR/oh-my-zsh.sh" ]; then
    echo -e "${BLUE}Oh-My-Zsh chưa được cài đặt đầy đủ. Tiến hành cài đặt...${NC}"
    if [ -d "$ZSH_DIR/custom" ]; then
        echo -e "${YELLOW}Phát hiện thư mục custom cũ, đang tạm thời sao lưu...${NC}"
        mv "$ZSH_DIR/custom" /tmp/omz-custom-backup
        rm -rf "$ZSH_DIR"
    fi
    git clone https://github.com/ohmyzsh/ohmyzsh.git "$ZSH_DIR"
    if [ -d /tmp/omz-custom-backup ]; then
        rm -rf "$ZSH_DIR/custom"
        mv /tmp/omz-custom-backup "$ZSH_DIR/custom"
    fi
    echo -e "${GREEN}✓ Cài đặt Oh-My-Zsh hoàn tất.${NC}"
else
    echo -e "${GREEN}✓ Oh-My-Zsh đã tồn tại đầy đủ.${NC}"
fi

# 4.2 Thiết lập thư mục custom plugins của Oh-My-Zsh
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
mkdir -p "$ZSH_CUSTOM/plugins"

# Danh sách 5 plugins yêu cầu đi kèm URL nguồn tương ứng 
# Giải pháp tối ưu hóa: Sử dụng mảng chuẩn để tương thích hoàn toàn với Bash 3.2 trên macOS (tránh lỗi declare -A)
zsh_plugins=(
    "zsh-autosuggestions|https://github.com/zsh-users/zsh-autosuggestions"
    "zsh-syntax-highlighting|https://github.com/zsh-users/zsh-syntax-highlighting"
    "fast-syntax-highlighting|https://github.com/zdharma-continuum/fast-syntax-highlighting"
    "zsh-autocomplete|https://github.com/marlonrichert/zsh-autocomplete"
    "zsh-npm-scripts-autocomplete|https://github.com/grigorii-zander/zsh-npm-scripts-autocomplete"
)

# Tiến hành quét và tải tự động các plugin
for item in "${zsh_plugins[@]}"; do
    # Tách dữ liệu bằng cơ chế POSIX String Manipulation (Tối ưu hóa tốc độ, an toàn tuyệt đối)
    plugin="${item%%|*}"
    url="${item##*|}"
    
    PLUGIN_PATH="$ZSH_CUSTOM/plugins/$plugin"
    if [ ! -d "$PLUGIN_PATH" ]; then
        echo -e "${BLUE}Đang tự động cài plugin Zsh: ${BOLD}$plugin${NC}..."
        git clone --depth=1 "$url" "$PLUGIN_PATH"
        echo -e "${GREEN}✓ Cài đặt $plugin hoàn tất.${NC}"
    else
        echo -e "${GREEN}✓ Plugin $plugin đã có sẵn.${NC}"
    fi
done

# 4.3 Cài đặt NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
if [ ! -d "$NVM_DIR" ]; then
    echo -e "${BLUE}NVM chưa được cài đặt. Đang kéo cài đặt trực tiếp từ Git...${NC}"
    git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
    
    # Xác định và checkout sang tag phiên bản ổn định mới nhất của NVM
    cd "$NVM_DIR"
    LATEST_NVM_TAG=$(git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1))
    git checkout "$LATEST_NVM_TAG" --quiet
    cd "$HOME"
    echo -e "${GREEN}✓ Đã cài đặt NVM phiên bản $LATEST_NVM_TAG.${NC}"
else
    echo -e "${GREEN}✓ NVM đã được cấu hình sẵn tại: $NVM_DIR.${NC}"
fi

# Nạp động môi trường NVM tạm thời cho phiên thực thi script hiện tại
echo -e "${BLUE}Đang nạp tạm thời môi trường NVM...${NC}"
# shellcheck disable=SC1090
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
# shellcheck disable=SC1090
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# --- 5. SAO LƯU CẤU HÌNH CŨ ĐỂ PHÒNG NGỪA RỦI RO CÁT SẮT DỮ LIỆU ---
echo -e "\n${PURPLE}[5/7] Đang quét và sao lưu cấu hình cũ...${NC}"
configs_to_backup=(
    ".zshrc"
    ".config/nvim"
    ".wezterm.lua"
)

backup_needed=false
for config in "${configs_to_backup[@]}"; do
    if [ -L "$HOME/$config" ]; then
        echo -e "${BLUE}  -> Đang xóa liên kết cũ: $config...${NC}"
        rm -rf "$HOME/$config"
    elif [ -e "$HOME/$config" ]; then
        if [ "$backup_needed" = false ]; then
            echo -e "${YELLOW}Phát hiện cấu hình vật lý cũ. Đang khởi tạo thư mục sao lưu tại: $BACKUP_DIR${NC}"
            mkdir -p "$BACKUP_DIR"
            backup_needed=true
        fi
        echo -e "${YELLOW}  -> Đang di chuyển $config về thư mục sao lưu...${NC}"
        cp -R "$HOME/$config" "$BACKUP_DIR/"
        rm -rf "$HOME/$config"
    fi
done

if [ "$backup_needed" = false ]; then
    echo -e "${GREEN}✓ Không tìm thấy cấu hình cũ trùng lặp. Hệ thống sạch sẽ.${NC}"
fi

# --- 6. ĐỒNG BỘ HOÁ REPO & THIẾT LẬP HỆ SYMLINK ĐỘNG ---
echo -e "\n${PURPLE}[6/7] Đang tải mã nguồn Dotfiles & ánh xạ Symlinks...${NC}"
if [ ! -d "$REPO_DIR" ]; then
    echo -e "${BLUE}Đang clone kho lưu trữ 2zcory/dotfiles về máy cục bộ...${NC}"
    git clone https://github.com/2zcory/dotfiles.git "$REPO_DIR"
else
    echo -e "${GREEN}✓ Thư mục dotfiles đã tồn tại. Tiến hành kiểm tra cập nhật mới nhất (git pull)...${NC}"
    if [ -d "$REPO_DIR/.git" ]; then
        cd "$REPO_DIR"
        git pull origin main --quiet
        cd "$HOME"
    fi
fi

# Đảm bảo thư mục .config tồn tại trước khi tạo liên kết mềm
mkdir -p "$HOME/.config"


# Tạo Symlink hướng đối tượng từ $REPO_DIR ra môi trường đích $HOME
echo -e "${BLUE}Đang thực thi tạo liên kết Symlink động từ: ${BOLD}$REPO_DIR${NC}"
ln -sf "$REPO_DIR/.zshrc/.zshrc" "$HOME/.zshrc"
ln -sf "$REPO_DIR/.config/nvim" "$HOME/.config/nvim"
ln -sf "$REPO_DIR/.wezterm.lua" "$HOME/.wezterm.lua"

echo -e "${GREEN}✓ Tất cả liên kết cấu hình đã được thiết lập thành công.${NC}"

# --- 7. KHỞI TẠO TIẾN TRÌNH SHELL & KẾT THÚC ---
echo -e "\n${PURPLE}[7/7] Hoàn tất khâu thiết lập cuối cùng...${NC}"

# Thiết lập Zsh làm Shell mặc định nếu chưa phải
if [[ "$SHELL" != */zsh ]]; then
    echo -e "${YELLOW}Đang chuyển đổi Shell mặc định của bạn sang Zsh...${NC}"
    chsh -s /bin/zsh || echo -e "${YELLOW}Cảnh báo: Không thể đổi shell mặc định tự động. Vui lòng tự chạy 'chsh -s /bin/zsh'.${NC}"
fi

echo -e "\n${GREEN}${BOLD}===============================================================${NC}"
echo -e "${GREEN}${BOLD}             QUY TRÌNH SETUP HOÀN TẤT THÀNH CÔNG!              ${NC}"
echo -e "${GREEN}${BOLD}===============================================================${NC}"
echo -e "${CYAN}Cách sử dụng Terminal mới của bạn:${NC}"
echo -e "  1. Mở ứng dụng ${BOLD}WezTerm${NC} vừa được cài đặt trong thư mục Applications."
echo -e "  2. Giao diện Powerlevel10k sẽ tự động kích hoạt nhờ file cấu hình .zshrc."
echo -e "  3. Gõ ${BOLD}nvim${NC} để trải nghiệm trình soạn thảo Neovim đã được đồng bộ cấu hình."
if [ "$backup_needed" = true ]; then
    echo -e "\n${YELLOW}* Lưu ý: Các cấu hình cũ của bạn được lưu trữ an toàn tại: $BACKUP_DIR${NC}"
fi
echo -e "${GREEN}${BOLD}===============================================================${NC}\n"