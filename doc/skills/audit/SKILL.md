---
name: audit
description:
  Đánh giá tài liệu Markdown bằng cách gọi subagent reviewer để kiểm tra
  formatting và chất lượng nội dung, sau đó tuỳ chọn chỉnh sửa bằng subagent
  writer. Dùng khi muốn review và sửa một tài liệu từ đầu đến cuối.
argument-hint: <file-path>
disable-model-invocation: true
---

Audit tài liệu Markdown `$ARGUMENTS` theo quy trình 4 giai đoạn.

> Nếu bất kỳ Agent tool call nào bị deny hoặc trả lỗi permission denied, hiển
> thị text `"Kết thúc skill audit"` và DỪNG NGAY — không thử gọi lại, không làm
> gì thêm.

## Kiểm Tra Điều Kiện Tiên Quyết

Nếu `$ARGUMENTS` rỗng hoặc không có, hiển thị text
`❌ Yêu cầu nhập tên file cần audit. Kết thúc skill audit` và DỪNG ngay.

## Giai Đoạn 1: Đánh Giá Formatting

Gọi subagent `formatting-reviewer` để kiểm tra formatting file `$ARGUMENTS`.
Prompt của Agent call phải bắt đầu bằng `[SKILL=audit][ROLE=formatting-reviewer]`.
Chờ kết quả đầy đủ rồi hiển thị cho người dùng.

## Giai Đoạn 2: Đánh Giá Nội Dung

Gọi subagent `grammar-reviewer` để kiểm tra nội dung file `$ARGUMENTS`.
Prompt của Agent call phải bắt đầu bằng `[SKILL=audit][ROLE=grammar-reviewer]`.
Chờ kết quả đầy đủ rồi hiển thị cho người dùng.

Sau đó gọi `AskUserQuestion` với câu hỏi:

```
Muốn lên kế hoạch sửa không?
```

- Nếu user chọn **No**: hiển thị text `"Kết thúc skill audit"` và DỪNG,
  không làm gì thêm
- Nếu user chọn **Yes**: tiếp tục Giai Đoạn 3

## Giai Đoạn 3: Lên Plan

Gọi subagent `writer` lần 1 với toàn bộ kết quả từ Giai Đoạn 1 và Giai Đoạn 2.
Prompt phải bắt đầu bằng `[SKILL=audit][PHASE=plan][USER_APPROVED=plan]`. Yêu
cầu writer:

- Xác minh lại tính đúng/sai của từng vấn đề trước khi lập plan
- Lập plan chi tiết
- Trả kết quả về — **KHÔNG sửa file**

Chờ writer trả về plan đầy đủ rồi **hiển thị toàn bộ plan cho người dùng**.

Sau đó gọi `AskUserQuestion` với câu hỏi:

```
Muốn tiến hành sửa không?
```

- Nếu user chọn **No**: hiển thị text `"Kết thúc skill audit"` và DỪNG,
  không làm gì thêm
- Nếu user chọn **Yes**: tiếp tục Giai Đoạn 4

## Giai Đoạn 4: Thực Thi

Gọi subagent `writer` lần 2 với toàn bộ plan từ Giai Đoạn 3. Prompt phải bắt đầu
bằng `[SKILL=audit][PHASE=execute][USER_APPROVED=execute]`. Yêu cầu
writer thực thi sửa file theo plan đã duyệt và báo kết quả sau khi hoàn thành.
