return {
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "LazyFile",
    opts = {
      enable = true,
      max_lines = 3,            -- Tối đa hiển thị bao nhiêu dòng dính ở top (ví dụ: class -> function -> if)
      min_window_height = 0,     -- Chiều cao tối thiểu của window để bật tính năng
      line_numbers = true,       -- Hiển thị số dòng tương ứng trên thanh Sticky Header
      multiline_threshold = 20,  -- Thu gọn nếu header của function dài quá 20 dòng
      trim_scope = "outer",      -- Ưu tiên giữ scope trong cùng khi bị vượt quá max_lines
      mode = "cursor",           -- Tính toán scope dựa trên vị trí con trỏ
      separator = "-",           -- Thêm đường gạch ngang mỏng ngăn cách Sticky Header với nội dung code bên dưới
    },
  },
}
