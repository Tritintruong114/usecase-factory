# Handoff — ws-<slug> ("<Tên hiển thị>")

> Gói handoff tự-giải-thích cho use-case này. Đọc file này TRƯỚC. Sinh bởi `/usecase-factory:mockup-to-html` ở cuối pipeline.

**Verdict:** <Proceed | Pivot | Narrow | Kill> · **Confidence:** <cao/vừa/thấp> · **Top risk:** <vd WTP chưa verify>
**Xem trước:** mở `mockups.html` (double-click) — **phải nằm cùng thư mục với `mockups.data.js`**.

## Trong gói này (đọc theo thứ tự)

| # | Artifact | Là gì | Ai dùng |
|---|----------|-------|---------|
| 1 | **`mockups.html` + `mockups.data.js`** | Bản xem tương tác (CẶP — đi cùng nhau) | non-tech review · web-app prototype nuốt |
| 2 | `screens-brief.md` | Bộ màn + flows + coverage (mỗi màn trace 1 job) | spec biện minh |
| 3 | `mockups.md` | ASCII — GATE coverage | dev Phase-2 đối chiếu |
| 4 | `_research/dossier.md` + 4 doc research | Bằng chứng + Decision Gate | vì sao đáng làm |

> ⚠ **`mockups.html` và `mockups.data.js` là một cặp.** html nạp js qua `<script src="mockups.data.js">` (đường dẫn tương đối). Tách rời → html mở ra trắng. Khi gửi/zip/upload phải mang **cả hai**.

## Scope

- ✓ Bộ màn đã biện minh · states (empty/first-run/loading/error/done) · flows đầu-cuối · microcopy.
- ✗ KHÔNG backend, KHÔNG FE↔BE contract. Đây là wireframe design-time, không phải code production.
- ✗ WTP / urgency / switching là **giả thuyết chưa verify** (xem Decision Gate) — không phải dữ kiện.

## Bước kế (chọn theo người nhận)

- **Non-tech / review:** double-click `mockups.html` (giữ cạnh `mockups.data.js`).
- **Prototype tương tác:** upload `mockups.data.js` + `screens-brief.md` vào web-app prototype.
- **Dev build FE (Phase-2):** dựng FE từ `mockups.md` (GATE) + `mockups.data.js` (states) + `screens-brief.md` (ý đồ).

## Style reference đã dùng

<new-design/ | $DESIGN_SYSTEM_ROOT | neutral default — ghi rõ tokens lấy từ đâu, để bước sau tái lập đúng skin>
