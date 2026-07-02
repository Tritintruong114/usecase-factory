# 01 · Product Map — `ws-<slug>` ("<Tên hiển thị>")

<!--
BẢN ĐỒ QUYẾT ĐỊNH SẢN PHẨM — một trang, dành cho product / người quyết định (KHÔNG phải research
summary). Đây là PROJECTION của Agent-Domain-Spec.md + 4 doc research trong appendix/ — KHÔNG lặp
lại toàn bộ nội dung của chúng, chỉ rút phần đã QUYẾT ĐỊNH được thành một chuỗi hành động rõ ràng.
Sinh bởi /usecase-factory:agent-domain-spec, SAU khi Agent-Domain-Spec.md đã chốt §1/§8/§11/§14/§18.
Mọi claim lớn ở đây phải trỏ về một section cụ thể trong appendix/ hoặc Agent-Domain-Spec.md — không
tự bịa thêm quyết định sản phẩm ở tầng này. Không có nguồn → ghi rõ đó là giả định, không phải fact.
File đặt tại doc/ws-<slug>/01-PRODUCT-MAP.md
-->

> Không viết chung chung. Mỗi dòng phải trả lời được: người dùng thuê agent này để làm việc gì
> **ĐAU và LẶP LẠI**? Ô nào không trỏ về được một nguồn cụ thể là một giả định — ghi rõ, đừng laundering thành fact.

## Chuỗi giá trị — pain → moat

| Bước | Nội dung | Nguồn |
|---|---|---|
| **Pain** | `<đau cụ thể + tần suất/cường độ — không phải "quy trình chưa tối ưu">` | `appendix/Boi-Canh-Va-Van-De.md §2-3` |
| **User** | `<ai chịu đau này — persona 1 dòng: vai trò, ngữ cảnh, expertise>` | `appendix/Target-User-<slug>.md §1` |
| **Workflow hôm nay** | `<họ đang giải quyết thế nào — thủ công / substitute / "không làm gì">` | `appendix/MR-<slug>-Problem-Solution.md §4` |
| **Agent job** | `<MỘT câu: "người dùng thuê agent này để [việc đau + lặp lại]" — giọng user, không phải giọng builder>` | `Agent-Domain-Spec.md §1 Domain thesis` |
| **Giá trị kinh doanh** | `<tiết kiệm gì, cho ai — thời gian / tiền / rủi ro; ai là người trả tiền>` | `appendix/Target-User-<slug>.md §6` |
| **Moat** | `<vì sao substitute mạnh nhất không thắng được — khe trống thật, không phải "chưa ai làm">` | `appendix/dossier.md §5` |

## Core loop + agent hoạt động thế nào

- **Core loop (vòng giá trị lặp lại):** `<trigger → agent action → payoff → return — dán từ MVP-Coreloop §2>`
- **Agent actions (v0):** `<hành động agent được LÀM ở v0 — liệt ngắn gọn, từ Agent-Domain-Spec §8 Decision policy + §12 Tool/action policy>`
- **Human approval points:** `<action nào bắt buộc người duyệt + vì sao — từ §11 Approval policy>`
- **Guardrails:** `<chặn rủi ro gì — rate limit / data minimization / anti over-automation — từ §14>`
- **Success metrics:** `<đo agent làm nghề tốt không — từ §18 Metrics, vd approval rate, false positive/negative, edit distance>`

## KHÔNG build ở V0 (chặn scope creep)

<!-- Liệt rõ từng cái bị hoãn CÓ CHỦ ĐÍCH — feature, agent action, hay screen — kèm lý do một nửa dòng.
     Mục này tồn tại để chặn scope creep, không phải danh sách wishlist. -->

- `<...>` — hoãn vì `<lý do>` — nguồn: `appendix/MVP-Coreloop.md §5`
- `<...>` — hoãn vì `<lý do>` — nguồn: `Agent-Domain-Spec.md §19`

## Rủi ro lớn nhất cần người quyết định tiếp

`<câu hỏi mở quan trọng nhất chưa trả lời được — từ appendix/dossier.md §7-§8 hoặc Agent-Domain-Spec.md §19. Đây là cái nếu sai sẽ đổi cả quyết định build.>`
