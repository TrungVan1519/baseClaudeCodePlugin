## Quy Tắc Cốt Lõi

### 1. Chỉ Check Theo Rule Đã Khai Báo

Chỉ được kiểm tra và báo lỗi những gì được quy định rõ ràng trong tài liệu này. Nghiêm cấm tự suy luận, suy diễn về cấu trúc tài liệu, ý định của người viết, hoặc "best practice" không được khai báo.

---

## Quy Tắc Ngoại Lệ

Các file sau được miễn áp dụng toàn bộ formatting rules:

- `README.md`

- `CLAUDE.md`

- `documents/index.md`

- Toàn bộ folder `.claude/**`

> Note: Chỉ `documents/index.md` được miễn — các file `index.md` trong subfolder vẫn áp dụng bình thường

```markdown
<!-- Miễn áp dụng -->
README.md
CLAUDE.md
documents/index.md
.claude/**

<!-- Vẫn áp dụng bình thường -->
documents/pages/index.md
documents/pages/claudeFolder/index.md
```

---

## Quy Tắc Heading

### 1. Không Đánh Giá Cấu Trúc Phân Cấp

Không được tự suy luận heading nào là con của heading nào, hoặc đánh giá việc
dùng H1/H2/H3/... có "đúng cấp" hay không — đây không phải rule được khai báo.

### 2. Viết Hoa Chữ Cái Đầu Mỗi Từ

Chữ cái đầu tiên của **mỗi từ** trong heading phải được viết hoa, **ngoại trừ**
từ nằm trong dấu backtick (``) thì giữ nguyên

```markdown
<!-- Sai -->
# table of contents

## cài đặt môi trường

### `CLAUDE.md` và cách dùng

<!-- Đúng -->
# Table Of Contents

## Cài Đặt Môi Trường

### `CLAUDE.md` Và Cách Dùng
```

---

## Quy Tắc Bullet-Points

### 1. Khoảng Cách Giữa Các Bullet

Các bullet cách nhau 1 dòng trống, **ngoại trừ** bullet trong Table Of Contents
(TOC)

Với bullet có nội dung con (sub-bullet hoặc code block), dòng trống phân cách
được tính là dòng trống **sau nội dung con cuối cùng** của bullet đó — không
phải dòng trống ngay sau dòng text của bullet cha.

```markdown
<!-- Đúng — bullet thường -->
- Mục A

- Mục B

- Mục C

<!-- Đúng — bullet có nội dung con, dòng trống tính sau sub-bullet cuối -->
- Mục A

  - Sub A.1

  - Sub A.2

- Mục B

<!-- Sai — thiếu dòng trống sau nội dung con cuối -->
- Mục A

  - Sub A.1

  - Sub A.2
- Mục B

<!-- Đúng — TOC không có dòng trống -->
- [1. Giới thiệu](#1-giới-thiệu)
- [2. Cài đặt](#2-cài-đặt)
- [3. Sử dụng](#3-sử-dụng)
```

### 2. Ký Tự Kết Câu

Không dùng dấu chấm (`.`), dấu phẩy (`,`), dấu chấm phẩy (`;`) ở cuối bullet

```markdown
<!-- Sai -->
- Cài đặt Node.js phiên bản 18 trở lên.
- Chạy lệnh npm install,

<!-- Đúng -->
- Cài đặt Node.js phiên bản 18 trở lên
- Chạy lệnh npm install
```

### 3. Định Dạng Bước

**Bước thường** — `- Step N: <Mô tả>`

**Bước con** — ` - Step N.M: <Mô tả>` (indent 2 spaces so với bước cha)

**Bước có chú thích** — `- (<Chú thích>) Step N: <Mô tả>`

```markdown
- Step 1: Cài đặt dependencies

  - Step 1.1: Chạy lệnh npm install

  - Step 1.2: Kiểm tra file node_modules đã được tạo

- (Bắt buộc) Step 2: Cấu hình biến môi trường

- Step 3: Khởi động server
```

---

## Quy Tắc Code Blocks

### 1. Không Có Tên File

Code block phải cách nội dung xung quanh 1 dòng trống ở trên và dưới

````markdown
<!-- Sai -->
Chạy lệnh sau:
```bash
npm install
```
Sau đó khởi động server.

<!-- Đúng -->
Chạy lệnh sau:

```bash
npm install
```

Sau đó khởi động server.
````

### 2. Có Tên File

Tên file cách nội dung phía trên 1 dòng trống, code block cách tên file 1 dòng trống, code block cách nội dung phía dưới 1 dòng trống

Cho phép chèn note (theo đúng quy tắc trong `notes.md`) giữa tên file và code
block — note cách tên file 1 dòng trống, code block cách note 1 dòng trống.

````markdown
<!-- Sai -->
Cấu hình như sau:
`package.json`
```json
{ "name": "my-app" }
```
Lưu lại và chạy.

<!-- Đúng — không có note -->
Cấu hình như sau:

`package.json`

```json
{ "name": "my-app" }
```

Lưu lại và chạy.

<!-- Đúng — có note chèn giữa tên file và code block -->
Cấu hình như sau:

`package.json`

> Note: Thay `my-app` bằng tên dự án thực tế

```json
{ "name": "my-app" }
```

Lưu lại và chạy.
````

### 3. Số Lượng Backtick

Nếu nội dung bên trong code block chứa N backtick liên tiếp, fence bên ngoài phải dùng ít nhất N+1 backtick

``````markdown
<!-- Nội dung có ``` → fence dùng ```` -->
````markdown
```json
{ "name": "my-app" }
```
````

<!-- Nội dung có ```` → fence dùng ````` -->
`````markdown
````markdown
...
````
`````
``````

### 4. Không Sửa Nội Dung

Nội dung bên trong code block và tên file phải giữ nguyên, không được dịch hay chỉnh sửa

---

## Quy Tắc Note

### 1. Note Đơn

Dùng `>` với từ `Note` theo sau là nội dung trên cùng một dòng. Nếu nội dung
dài có thể xuống dòng — các dòng tiếp theo bắt đầu bằng `>` và phải viết liền
nhau, không có dòng trống giữa các dòng.

```markdown
> Note: Cần khởi động lại server sau khi thay đổi cấu hình

> Note: You must use a `GlobalKey` to ensure that the native view widget
> properly rebuilds when `setState()` is called
```

### 2. Note Nhiều Mục

Dùng `>` với từ `Notes` (không có ký tự đặc biệt sau `Notes`), các bullet cách nhau 1 dòng trống và bắt đầu bằng `>`

```markdown
> Notes
>
> - Cần khởi động lại server sau khi thay đổi cấu hình
>
> - File `.env` không được commit lên git
>
> - Phiên bản Node.js tối thiểu là 18
```

---

## Quy Tắc Tables

### 1. Bảng Không Có Headers

Chỉ gồm 2 dòng: dòng dữ liệu và dòng phân cách

```markdown
<!-- Sai -->
| Tên | Giá trị |
| --- | ------- |
| A   | 1       |

<!-- Đúng -->
| Tên | Giá trị |
| --- | ------- |
```

### 2. Bảng Có Headers

Gồm 3 dòng trở lên: dòng header, dòng phân cách, và các dòng dữ liệu

```markdown
<!-- Sai -->
| Tên | Giá trị |
| --- | ------- |

<!-- Đúng -->
| Tên | Giá trị |
| --- | ------- |
| A   | 1       |
| B   | 2       |
```

---

## Quy Tắc Assets

### 1. Image

Alt text phải giống tên file (không bao gồm đuôi file)

```markdown
<!-- Sai -->
![ảnh sơ đồ](diagram-flow.png)
![](diagram-flow.png)

<!-- Đúng -->
![diagram-flow](diagram-flow.png)
```

---

## Quy Tắc Keywords

### 1. Từ Khoá

| agent          | Android        | Android Studio | APNS        |
| -------------- | -------------- | -------------- | ----------- |
| Antigravity    | arm64          | certificate    | certificates |
| context        | Dio            | FCM            | Firebase    |
| Flutter        | Hive           | HttpV1         | identify    |
| iOS            | profile        | profiles       | Retrofit    |
| subagent       | token          | VSCode         | XCode       |

### 2. Cụm Từ Khoá

| App Connect            | Apple Connect | Apple Store          |
| ---------------------- | ------------- | -------------------- |
| context window         | Firebase Cloud Messaging | Google Play |
| Google Play Console    | Shared Preferences |               |

### 3. Quy Tắc Viết

- Phải viết đúng từ khoá theo bảng trên, không tự ý thay đổi viết hoa hoặc
  viết thường

- Ngoại lệ: chữ cái đầu tiên của từ khoá được phép viết hoa khi nằm ngay sau
  dấu kết thúc câu (`.`, `!`, `?`, ...) hoặc khi đứng ở đầu dòng

### 4. Ví Dụ

```markdown
<!-- Sai — từ khoá đơn -->
Mỗi subagent chạy trong Context riêng của nó.
Cần tính toán số Token phù hợp cho mỗi request.

<!-- Đúng — từ khoá đơn -->
Mỗi subagent chạy trong context riêng của nó.
Cần tính toán số token phù hợp cho mỗi request.

<!-- Sai — cụm từ khoá -->
Mô hình bị giới hạn bởi Context Window.
Tăng Context window để xử lý tài liệu dài hơn.

<!-- Đúng — cụm từ khoá -->
Mô hình bị giới hạn bởi context window.
Tăng context window để xử lý tài liệu dài hơn.

<!-- Đúng — viết hoa sau dấu kết thúc câu hoặc đầu dòng -->
Hệ thống dùng token để xác thực. Token này có thời hạn 24 giờ.
Mô hình có context window 200k. Context window này đủ để xử lý tài liệu lớn.
Token phải được mã hoá trước khi lưu trữ.
Subagent chạy độc lập với context của hội thoại chính.
```
