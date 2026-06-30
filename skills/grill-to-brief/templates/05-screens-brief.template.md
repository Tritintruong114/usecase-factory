# Screen Brief — `ws-<slug>` ("<Tên hiển thị>")

> ⚠ **DOWNSTREAM REFERENCE ONLY — `use-case-factory` KHÔNG sinh file này.** Đây là OUTPUT của `/usecase-factory:grill-to-brief`. Để đây làm mẫu để factory biết bộ màn sẽ ra trông thế nào, từ đó điền 4 input cho đủ "nguyên liệu" grill cần.

<!--
OUTPUT của /usecase-factory:grill-to-brief (KHÔNG phải input của factory, KHÔNG nằm trong 4 output của use-case-factory).
Để đây làm mẫu: biết bộ màn sẽ ra trông thế nào → factory điền 4 input cho đủ "nguyên liệu" mà grill cần.
KHÔNG tự viết file này bằng tay — /usecase-factory:grill-to-brief sinh ra qua phỏng vấn từng màn. Đây chỉ là khuôn tham chiếu.
File đặt tại doc/ws-<slug>/screens-brief.md
-->

> **Phase: bridge (research → wireframe).** Nguồn: Boi-Canh · MR · Target-User · MVP-Coreloop (· brief.md).
> **Feed:** `/usecase-factory:design-a-screen` (ASCII) → `/usecase-factory:mockup-to-html` (HTML) → prototype.
> Đây là **SPEC tập màn đã biện minh**, KHÔNG phải ASCII/layout/code. Mỗi màn phải trace về một việc user cần làm.

## Góc nhìn target user (lăng kính chấm mọi màn)

<1-2 câu rút từ Target-User §4: expertise · thiết bị · ngưỡng lỗi · tần suất ghé.>

## Channel split (phản biện mặc định cho mọi màn)

<Việc gì làm được ngoài dashboard (chat/notification/route-call)? Một màn chỉ sống nếu cho user XEM NHIỀU THỨ CÙNG LÚC / browse / tra cứu — thứ chat không làm được.>

## Copy register (output `/usecase-factory:copy-writer` — step 7)

<Register microcopy theo persona. Bảng tổng hợp title + subtitle để review nhanh.>

| Màn | Page title | Subtitle |
| --- | --- | --- |
| S1 | <title> | <≤14 từ, nói WHAT> |

## Screens (v0)

<!-- Mỗi màn lặp khối dưới. Mọi field bắt buộc — thiếu field nào là màn chưa được grill xong. -->

### S1 — <Tên màn>

- **Purpose (1 dòng):** <điều màn này LÀ, từ phía user. Không "quản lý X". Cần "và" = có thể là 2 màn.>
- **Serves:** <J# + ưu tiên; bước loop nào nó gánh.>
- **User-day moment:** <khi nào trong ngày user mở màn này, đang cố làm gì.>
- **Must-show:** <first paint phải thấy gì.>
- **Primary action:** <một hành động chính.> · **Secondary:** <...>
- **States:** <empty / first-run / loading / error / done — cái nào quan trọng + trông thế nào.>
- **Why a screen (not chat):** <vì sao phải là màn, không phải noti/chat/route-call.>
- **Palette-gap:** <element nào palette chưa có (nếu có ràng buộc component set).>
- **Copy (UX microcopy):**
  - Page title: <...>
  - Subtitle: <...>
  - Section headings: <...>
  - Action labels: primary = "<động từ + danh từ>" · secondary = "<...>"
  - Empty-state: <một câu.>

## Coverage check

<!-- Cổng 2 chiều. Jobs→screens: mọi HIGH job có ≥1 màn. Screens→jobs: mọi màn có ≥1 job. -->

| Job | Ưu tiên | Phủ bởi | Ghi chú |
| --- | --- | --- | --- |
| J1 | Cao | <S#> | |

- **Uncovered HIGH jobs:** <không có / liệt kê + quyết định: thêm màn vs off-dashboard>
- **Orphan screens:** <không có / liệt kê + cắt hoặc gắn job>

## MVP cut line

- **v0:** <các màn ship — lý do: trên loop / cổng setup.>
- **Deferred (màn riêng):** <...>
- **Deferred (trong màn):** <...>

## Navigation shape (nhẹ)

<Một đoạn: v0 màn group thế nào, user di chuyển ra sao (top tabs / left rail / wizard / master-detail).>

## Open questions cho `/usecase-factory:design-a-screen`

- <element bespoke cần spec sâu>
- <quyết định còn treo>
</content>
