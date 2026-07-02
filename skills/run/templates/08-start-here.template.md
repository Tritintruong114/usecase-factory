# 00 · Start Here — `ws-<slug>` ("<Tên hiển thị>")

<!--
TẦNG ĐỌC ĐẦU TIÊN của Decision Pack. File này KHÔNG sinh một lần rồi xong — nó được VIẾT bởi
/usecase-factory:run (verdict + tóm tắt + routing ban đầu) rồi CẬP NHẬT bởi mỗi stage sau
(agent-domain-spec, grill-to-brief, brief-to-html) khi có thêm artifact. Luôn phản ánh trạng thái
MỚI NHẤT của workspace — đừng để nó nói dối về file nào đã/chưa tồn tại.
Mục tiêu: người đọc mất DƯỚI 3 PHÚT để biết verdict + đọc tiếp gì theo đúng vai trò của họ.
Khi một section chưa tới lượt stage nào điền, viết thẳng "Chưa có — chạy <skill> để tạo" — KHÔNG
để lại <!-- guidance --> hay <placeholder> chờ, vì file này được đọc ở MỌI gate dừng, không chỉ ở cuối.
File đặt tại doc/ws-<slug>/00-START-HERE.md
-->

> Đọc file này TRƯỚC bất kỳ file nào khác trong thư mục này.

## Verdict

**<Proceed | Pivot | Narrow | Kill>** · Confidence: **<Cao/Vừa/Thấp>** · Cập nhật lần cuối `<YYYY-MM-DD>` bởi `<tên stage vừa chạy>`

## Tóm tắt (5–10 dòng)

<!-- Use case là gì · cho ai · đau gì · vì sao cần AGENT (không phải SaaS/automation/chatbot thường)
     · giá trị kinh doanh nếu thành công. Viết cho người CHƯA đọc gì khác trong workspace này. -->

`<...>`

## Vì sao verdict này

<!-- 2-4 câu, dẫn thẳng từ appendix/dossier.md §8 Decision Gate: rationale + confidence.
     Giọng quyết định, không phải giọng tóm tắt research. -->

`<...>`

**Rủi ro lớn nhất chưa giải quyết:** `<...>` — chi tiết ở `appendix/dossier.md` §7–§8.

## Đọc tiếp theo — theo vai trò

| Vai trò | Đọc gì | Để làm gì |
|---|---|---|
| **Product / người quyết định** | `01-PRODUCT-MAP.md` | pain → user → workflow → agent job → giá trị → moat, core loop, và scope V0 — trong một trang |
| **Builder / agent engineer** | `Agent-Domain-Spec.md` → `screens-brief.md` → `mockups.html` (mở cùng thư mục với `mockups.data.js`) | nghiệp vụ agent-hoá trên OpenClaw → bộ màn đã biện minh → prototype xem thử |
| **Cần verify một claim / xem bằng chứng thô** | `appendix/` | dossier, 4 doc research, ASCII coverage gate — bằng chứng phụ trợ, KHÔNG phải quyết định |

## Trạng thái pipeline (cập nhật mỗi stage)

- [x] `run` — verdict + evidence sẵn sàng (`appendix/dossier.md` + 4 doc research)
- [ ] `agent-domain-spec` — `<Chưa có. Chạy /usecase-factory:agent-domain-spec <slug> để tạo Agent-Domain-Spec.md + 01-PRODUCT-MAP.md.>`
- [ ] `grill-to-brief` — `<Chưa có. Cần agent-domain-spec xong trước.>`
- [ ] `design-a-screen` + `brief-to-html` — `<Chưa có.>`

> Mục nào chưa tick = file tương ứng CHƯA tồn tại trong workspace này. Đừng suy diễn nội dung của nó.

## Scope

<!-- Điền đủ 3 dòng khi brief-to-html chạy xong (pipeline hoàn tất). Trước đó, dòng đầu ghi rõ
     pipeline mới đi tới đâu — KHÔNG bịa scope của các stage chưa chạy. -->

- ✓ Đã có tới đây: `<verdict + evidence (run)>`
- ✗ KHÔNG backend, KHÔNG FE↔BE contract — mọi artifact ở đây là wireframe/spec design-time, không phải code production (Phase-2, ngoài plugin này).
- ✗ WTP / urgency / switching là **giả thuyết chưa verify** (xem Decision Gate, `appendix/dossier.md` §8) — không phải dữ kiện.

## Bước kế — chọn theo người nhận

<!-- Điền đủ khi brief-to-html chạy xong. Trước đó: "Chưa có prototype — bước kế là chạy stage tiếp theo ở trên." -->

`<Chưa có prototype. Bước kế: chạy /usecase-factory:agent-domain-spec <slug>.>`

## Design system đã dùng

<!-- Điền ở brief-to-html — ghi rõ ĐÚNG file tokens/components đã dùng để bước sau tái lập đúng skin. -->

`<Chưa render — chưa chọn design system.>`
