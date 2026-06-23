---
title: MR <Tên use-case> — Vấn đề, Giả thuyết giải pháp & Phạm vi MVP
type: market-research
tags: [market-research, problem, jtbd, hypothesis, mvp, <domain>]
categories: [Index]
date: <YYYY-MM-DD>
status: draft
---

<!--
INPUT #2 của /grill-to-brief — "MR / Jobs-to-be-Done".
Mục đích: cho grill BẢNG JTBD đã xếp ưu tiên (J1..Jn) để chạy coverage 2 chiều + chọn cut line.
LƯU Ý: JTBD là RESEARCH, KHÔNG map 1-1 ra màn. Đừng biến J# thành spec.
File đặt tại doc/ws-<slug>/MR-<slug>-Problem-Solution.md
-->

# MR <Tên use-case> — Vấn đề & Giả thuyết giải pháp (phiên bản MVP)

> Vế 2–3 của Market Research: **hiểu vấn đề** tệp <user> đang cần giải + **giả thuyết giải pháp** — lọc xuống tập nhỏ nhất cho **MVP**.
> Tệp user (vế 1): [[Target-User-<slug>]].

## 0. Mức độ tin cậy của bằng chứng

<!-- Trung thực về độ chắc của data. Phân lớp claim theo quy tắc dossier:
     MUST-CITE (có nguồn) · INFER (suy luận, không nguồn) · ASSUMPTION (chưa kiểm chứng).
     KHÔNG cite từng câu — cite đúng loại. WTP/urgency/switching/integration/ROI luôn là ASSUMPTION trừ khi đã phỏng vấn. -->

| Lớp claim | Hiện trạng | Việc cần làm |
| --- | --- | --- |
| Số liệu thị trường (must-cite) | <đã dẫn nguồn / chưa> | <—/cần gì> |
| Giá / pricing đối thủ (must-cite) | <đã dẫn nguồn / chưa> | <—> |
| Hình dạng workflow / hành vi persona (infer) | <suy luận từ nghiệp vụ> | <—> |
| Willingness-to-pay / urgency / switching (assumption) | <giả định chưa kiểm> | <phỏng vấn / pilot> |
| Pain của user | <đã phỏng vấn / giả định từ blog ngành> | <nâng lên "đã kiểm chứng" bằng cách nào> |
| Giả thuyết giải pháp | <chưa kiểm chứng> | <test concept với pilot> |

→ Tài liệu này là **bản đồ giả thuyết để đi validate**, không phải kết luận đã chốt.

## 1. Vấn đề — bảng Jobs-to-be-Done (xếp ưu tiên)

<!-- Mỗi job = việc user phải làm để đạt mục tiêu. Chấm 3 chiều 1-5: Tần suất × Mức đau × Sẵn sàng trả.
     Ưu tiên = tổng định tính (Cao / TB / Thấp). Đánh dấu rõ HIGH — grill bắt mọi HIGH job phải có chỗ. -->

| # | Job-to-be-Done (góc nhìn <user>) | Tần suất | Mức đau | Sẵn sàng trả | Ưu tiên | Bằng chứng |
|---|---|---|---|---|---|---|
| J1 | "<job>" | 5 | 4 | 4 | **Cao** | [nguồn](url) |
| J2 | "<job>" | 4 | 5 | 4 | **Cao** | [nguồn](url) |
| J3 | "<job>" | 4 | 5 | 5 | **Cao** | <suy ra từ nghiệp vụ> |
| J4 | "<job>" | 3 | 5 | 4 | **Cao** | <nguồn> |
| J5 | "<job>" | 3 | 4 | 3 | Trung bình | [nguồn](url) |
| J6 | "<job>" | 2 | 4 | 3 | Thấp–TB | [nguồn](url) |
| J7 | "<job — động lực bao trùm, không phải thao tác>" | — | 4 | 5 | Bối cảnh | [nguồn](url) |

## 2. Giả thuyết giải pháp (ánh xạ từng vấn đề)

<!-- Mỗi job: giả thuyết sản phẩm giải bằng gì + ĐO thành công ra sao (metric kiểm chứng được). -->

| Job | Giả thuyết giải pháp | Đo bằng |
|---|---|---|
| J1 | <giải pháp> | <metric> |
| J2 | <giải pháp> | <metric> |
| ... | ... | ... |

## 3. Câu hỏi cần kiểm chứng (primary research)

<!-- Câu hỏi mở phải trả lời bằng phỏng vấn/quan sát trước khi chốt scope. -->

1. <Trong các HIGH job, cái nào đau nhất / trả tiền trước?>
2. <Tỉ lệ thật của ...?>
3. <Ngưỡng giá chấp nhận?>

Cách lấy: <phỏng vấn N user + đọc M thread cộng đồng — nguồn ở Target-User §7>.

## 4. Cạnh tranh, thay thế & workaround (moat)

<!-- Feed từ agent C + dossier §5 (Substitute/Workaround Map). KHÔNG chỉ đối thủ AI trực tiếp:
     phải gồm đối thủ TRỰC TIẾP + MỌI cách tệp user đang giải hôm nay (substitute/workaround), kể cả "không làm gì".
     SME Việt Nam: bắt buộc soi Zalo / Facebook / TikTok / sàn TMĐT / Google Sheets-Excel / follow-up thủ công.
     Giá/traction phải có URL nguồn trong dossier hoặc đánh dấu infer/assumption. -->

### Đối thủ trực tiếp

| Đối thủ | Định vị | Giá | Traction (tín hiệu) | Mạnh | Yếu | Nguồn |
|---|---|---|---|---|---|---|
| `<tên>` | `<...>` | `<giá / model>` | `<...>` | `<...>` | `<...>` | [nguồn](url) |

### Substitute / workaround (cách tệp giải vấn đề hôm nay)

<!-- Đầy đủ: AI tool · vertical SaaS · agency/freelancer · nhân sự/admin · Zalo/FB/inbox thủ công · Sheets/Excel · TikTok/sàn · "không làm gì". -->

| Loại thay thế | Họ làm thế nào | Chi phí (tiền/công) | Mạnh | Yếu (khe ta chen) | Nguồn / nhãn |
|---|---|---|---|---|---|
| `<vertical SaaS / agency / admin người / Zalo-FB thủ công / Sheets / "không làm gì">` | `<...>` | `<...>` | `<...>` | `<...>` | [nguồn](url) hoặc `<infer/assumption>` |

### Khoảng trống & moat

- **Workaround mạnh nhất:** <cái khó đánh bại nhất — rẻ/đủ tốt/đã quen. Nếu nó thắng → tín hiệu pivot/narrow (xem dossier §8).>
- **Khoảng trống:** <điều thị trường chưa ai làm tốt / tệp này chưa được phục vụ.>
- **Moat giả thuyết:** <vì sao ta giữ được — KHÔNG phải "làm tốt hơn", mà là cấu trúc/dữ liệu/kênh.>

## 5. Related

- [[Target-User-<slug>]] · [[Boi-Canh-Va-Van-De]] · [[MVP-Coreloop]]
</content>
