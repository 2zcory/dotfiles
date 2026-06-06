# 🚀 2Z-DOTFILES - Tự Động Hóa & Tối Ưu Hóa Môi Trường Làm Việc

Chào mừng bạn đến với **2Z-Dotfiles** — bộ cấu hình dotfiles tự động hóa chất lượng cao dành cho macOS và Windows, được thiết kế để nâng cao tối đa hiệu suất lập trình hàng ngày của bạn.

---

## 🎨 Tính năng nổi bật

### 1. Shell & Prompt (Zsh & Oh-My-Zsh)
* **Theme:** Sử dụng [Powerlevel10k](https://github.com/romkatv/powerlevel10k) tối giản, hiển thị nhanh và đầy đủ thông tin về Git branch, trạng thái Node.js/Python, thời gian thực thi lệnh.
* **Plugins cài sẵn:**
  * `zsh-autosuggestions` — Gợi ý lệnh thông minh dựa trên lịch sử.
  * `zsh-syntax-highlighting` & `fast-syntax-highlighting` — Tô màu cú pháp lệnh trực tiếp khi gõ.
  * `zsh-autocomplete` — Tự động hoàn thành lệnh thời gian thực.
  * `zsh-npm-scripts-autocomplete` — Hỗ trợ gợi ý các script trong file `package.json` của thư mục làm việc.
* **Quản lý phiên bản Node (NVM):** Tự động phát hiện và chuyển đổi phiên bản Node.js phù hợp khi bạn truy cập vào thư mục có file `.nvmrc` (`load-nvmrc`).

### 2. Trình soạn thảo mã nguồn (Neovim)
* Cấu hình Neovim hiện đại đặt tại thư mục `.config/nvim`, tối ưu hóa tốc độ khởi động, hỗ trợ LSP mạnh mẽ và giao diện lập trình trực quan.

### 3. Terminal Emulator (WezTerm)
* Cấu hình qua tệp tin `.wezterm.lua` trên macOS.
* Sử dụng font chữ **JetBrains Mono Nerd Font** giúp hiển thị đầy đủ icon và các ký tự lập trình đặc biệt mà không bị lỗi hiển thị.

### 4. PowerShell (Windows & Cross-platform)
* Hỗ trợ cấu hình profile PowerShell (`Microsoft.PowerShell_profile.ps1`) tích hợp **Oh-My-Posh** và bộ công cụ **PSReadLine** đem lại trải nghiệm Shell mượt mà trên cả môi trường Windows.

---

## 📁 Cấu trúc thư mục repository

```bash
.
├── .config/
│   └── nvim/               # Cấu hình Neovim (LSP, Plugins, Keymaps)
├── .zshrc/
│   ├── .zshrc              # Tệp cấu hình Zsh chính
│   └── custom/             # Các tệp cấu hình chia tách theo mục đích
│       ├── .os.android.zsh # Cấu hình cho môi trường Android Termux
│       ├── .os.darwin.zsh  # Cấu hình cho macOS (NVM, PostgreSQL...)
│       ├── .os.linux.zsh   # Cấu hình cho môi trường Linux
│       ├── 1.variables.zsh # Khai báo biến môi trường toàn cục
│       ├── 2.alias.zsh     # Các từ viết tắt (Docker, Git...)
│       ├── 3.functions.zsh # Các hàm bổ trợ
│       └── 4.wp.zsh        # Quản lý phím tắt Workspace
├── p10k/
│   └── .p10k.zsh           # Cấu hình chi tiết giao diện Powerlevel10k
├── powershell/             # Cấu hình PowerShell cho Windows
├── .wezterm.lua            # Cấu hình Terminal WezTerm
├── bootstrap.sh            # Script cài đặt tự động (macOS/Linux)
└── bootstrap.ps1           # Script setup Neovim (Windows)
```

---

## 🚀 Hướng dẫn cài đặt nhanh (macOS)

Để cài đặt tự động toàn bộ môi trường từ Homebrew, Oh-My-Zsh, Plugins, Fonts, NVM cho đến tạo các liên kết cấu hình (Symlinks), bạn chỉ cần chạy duy nhất một dòng lệnh sau trong Terminal:

```bash
bash ./bootstrap.sh
```

### Script cài đặt sẽ tự động thực hiện:
1. Kiểm tra và cài đặt **Xcode Command Line Tools** nếu chưa có.
2. Tải và cấu hình **Homebrew** (ở chế độ tự động không chờ tương tác).
3. Cài đặt các gói CLI thiết yếu: `git`, `neovim`, `ripgrep`, `fzf`, `eza`, `fd`, `bat`, `zsh`, `tmux`.
4. Cài đặt **WezTerm** và **JetBrains Mono Nerd Font**.
5. Cài đặt **Oh-My-Zsh** cùng với 5 plugins mở rộng bổ trợ.
6. Cài đặt **NVM** trực tiếp từ mã nguồn Git.
7. Quét các tệp cấu hình cũ (`.zshrc`, `.wezterm.lua`, `.config/nvim`) để sao lưu an toàn rồi thực hiện ánh xạ Symlink tự động từ repository này ra thư mục `$HOME`.
8. Chuyển đổi Shell mặc định sang **Zsh**.

---

## 🛠️ Hướng dẫn cài đặt nhanh (Windows)

Để liên kết nhanh cấu hình Neovim từ repository này trên Windows, bạn hãy chạy file script PowerShell với quyền Administrator:

```powershell
powershell -ExecutionPolicy Bypass -File .\bootstrap.ps1
```

---

## 💡 Khắc phục sự cố thường gặp (Troubleshooting)

### 1. Lỗi thiếu lõi Oh-My-Zsh (`oh-my-zsh.sh` not found)
Nếu trước đây bạn đã từng chạy cấu hình thủ công tạo trước thư mục `$HOME/.oh-my-zsh`, phiên bản nâng cấp của `bootstrap.sh` sẽ tự động phát hiện, sao lưu tùy chỉnh cũ của bạn và tải lại mã nguồn chính của Oh-My-Zsh để sửa lỗi này hoàn toàn.

### 2. Lỗi không tìm thấy lệnh `nvm_find_nvmrc` khi gõ lệnh trong Zsh
Lỗi này xảy ra khi bạn cài đặt NVM qua Git nhưng Zsh lại cố gắng nạp NVM từ đường dẫn Homebrew. File `.os.darwin.zsh` đã được sửa đổi để tự động tìm kiếm thông minh cả hai nguồn cài đặt.
