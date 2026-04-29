---
name: plugin-update
description:
  Cập nhật plugin doc lên version mới nhất từ remote. Fetch git, so sánh
  version, cập nhật cache và installed_plugins.json nếu có bản mới.
disable-model-invocation: true
---

Cập nhật plugin `doc@baseClaudeCodePlugin` lên version mới nhất.

## Bước 1: Kiểm Tra Trạng Thái Hiện Tại

Dùng `Bash` đọc `~/.claude/plugins/installed_plugins.json` để lấy:

- `version` đang cài
- `gitCommitSha` đang cài
- `installPath`

## Bước 2: Fetch Remote

Dùng `Bash` để fetch:

```bash
git -C ~/.claude/plugins/marketplaces/baseClaudeCodePlugin fetch origin main --quiet
```

Lấy SHA và version mới nhất:

```bash
git -C ~/.claude/plugins/marketplaces/baseClaudeCodePlugin rev-parse origin/main
git -C ~/.claude/plugins/marketplaces/baseClaudeCodePlugin show origin/main:doc/.claude-plugin/plugin.json
```

## Bước 3: So Sánh

- Nếu SHA remote **bằng** SHA đang cài → hiển thị:
  ```
  ✅ Plugin doc@baseClaudeCodePlugin đang ở version mới nhất (<version>)
  ```
  Dừng lại.

- Nếu SHA remote **khác** → tiếp tục Bước 4.

## Bước 4: Cập Nhật Cache

Dùng `Bash` để checkout version mới vào thư mục cache mới:

```bash
NEW_VERSION=<version từ remote>
CACHE_DIR=~/.claude/plugins/cache/baseClaudeCodePlugin/doc/$NEW_VERSION
mkdir -p "$CACHE_DIR"
git -C ~/.claude/plugins/marketplaces/baseClaudeCodePlugin checkout origin/main -- doc/
cp -r ~/.claude/plugins/marketplaces/baseClaudeCodePlugin/doc/. "$CACHE_DIR/"
```

## Bước 5: Cập Nhật installed_plugins.json

Dùng `Bash` cập nhật các trường sau trong entry `doc@baseClaudeCodePlugin`:

- `version` → version mới
- `installPath` → path cache mới
- `gitCommitSha` → SHA remote mới
- `lastUpdated` → timestamp hiện tại (`date -u +"%Y-%m-%dT%H:%M:%S.000Z"`)

## Bước 6: Xóa update-check-cache

Dùng `Bash` reset cache check để lần sau SessionStart không báo nhầm:

```bash
python3 -c "
import json
path = '$HOME/.claude/plugins/update-check-cache.json'
try:
  data = json.load(open(path))
except:
  data = {}
data.pop('doc@baseClaudeCodePlugin', None)
json.dump(data, open(path, 'w'), indent=2)
"
```

## Bước 7: Thông Báo Kết Quả

Hiển thị:

```
✅ Đã cập nhật doc@baseClaudeCodePlugin: <version cũ> → <version mới>
   Khởi động lại session để áp dụng thay đổi.
```
