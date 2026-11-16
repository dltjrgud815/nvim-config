# nvim-config

Neovim configuration (lazy.nvim 기반)

## 요구 사항

- Neovim 0.12 이상 (nvim-treesitter `main` 브랜치 요구사항)
- macOS (Homebrew) 기준 사전 설치 패키지

```bash
brew install neovim git ripgrep fd tree-sitter-cli
brew install --cask font-jetbrains-mono-nerd-font   # 아이콘용 Nerd Font (터미널 폰트로 지정)
```

| 패키지 | 용도 |
| --- | --- |
| ripgrep | Telescope `live_grep` |
| fd | Telescope `find_files` 속도 향상 (선택) |
| tree-sitter-cli | nvim-treesitter 파서 설치 |
| Nerd Font | neo-tree / lualine 아이콘 |
| node, python3 | mason 으로 설치하는 일부 LSP·포매터 (pyright, prettier, black 등) |

## 설치

```bash
git clone https://github.com/dltjrgud815/nvim-config ~/.config/nvim
nvim   # 첫 실행 시 플러그인, LSP 서버, 포매터, treesitter 파서가 자동 설치됨
```

플러그인 버전은 `lazy-lock.json` 으로 고정되어 있다. 업데이트는 `:Lazy update` 후 lockfile 을 커밋한다.
