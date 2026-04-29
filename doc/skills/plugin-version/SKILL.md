---
name: plugin-version
description: Hiển thị version hiện tại của plugin doc đang được cài đặt.
disable-model-invocation: true
---

Hiển thị version đang cài và version mới nhất của plugin `doc@baseClaudeCodePlugin`.

## Bước 1: Đọc installed_plugins.json

Dùng `Bash` để lấy thông tin đang cài:

```bash
jq -r '.plugins["doc@baseClaudeCodePlugin"][0] | "\(.version)|\(.gitCommitSha)|\(.installPath)|\(.lastUpdated)"' ~/.claude/plugins/installed_plugins.json
```

Nếu không có entry, hiển thị:

```
❌ Plugin doc@baseClaudeCodePlugin chưa được cài đặt.
```

và dừng lại.

## Bước 2: Lấy Version Mới Nhất

Dùng `Bash` để fetch remote rồi đọc version mới nhất:

```bash
git -C ~/.claude/plugins/marketplaces/baseClaudeCodePlugin fetch origin main --quiet
git -C ~/.claude/plugins/marketplaces/baseClaudeCodePlugin show origin/main:doc/.claude-plugin/plugin.json 2>/dev/null | jq -r '.version // empty'
```

Nếu không lấy được, hiển thị `(không xác định)` cho trường này.

## Bước 3: Hiển Thị Kết Quả

Hiển thị theo định dạng:

Nếu version đang cài **bằng** version mới nhất:

```
doc@baseClaudeCodePlugin
  - Installed:    <version> (Up-to-date)
  - Latest:       <version> (Up-to-date)
  - Commit:       <gitCommitSha>
  - Install path: <installPath>
  - Last updated: <lastUpdated>
```

Nếu version đang cài **khác** version mới nhất:

```
doc@baseClaudeCodePlugin
  - Installed:    <version đang cài>
  - Latest:       <version mới nhất>
  - Commit:       <gitCommitSha>
  - Install path: <installPath>
  - Last updated: <lastUpdated>

  💡 Gọi /doc:plugin-update để cập nhật.
```
