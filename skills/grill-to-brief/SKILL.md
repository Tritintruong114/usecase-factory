---
name: grill-to-brief
description: Grill 4 doc research (Context & Problem, MR/JTBD, Target User, MVP & Core Loop) thành Screen Brief — bộ màn đã biện minh, mỗi màn trace về một vấn đề thật từ góc target user. Phỏng vấn từng màn một: ép gọi tên mục đích duy nhất + JTBD phục vụ + khoảnh khắc trong ngày, map mọi hành động tới state nó sinh + vẽ flow đầu-cuối, chạy two-way coverage check (không orphan, không job cao bị hở, không dead-end CTA), rồi polish microcopy. Ghi doc/ws-<slug>/screens-brief.md — input cho /usecase-factory:design-a-screen (ASCII, coverage gate) và /usecase-factory:brief-to-html (render HTML từ brief + design system) → prototype. Chạy SAU khi có 4 doc research, TRƯỚC khi vẽ màn. Dùng khi user nói "grill ra screen brief", "biến research thành bộ màn", "chốt bộ màn trước khi vẽ", "chạy grill-to-brief", "/usecase-factory:grill-to-brief".
disable-model-invocation: true
---

# Grill to Brief — router

Skill này là **router mỏng**. Toàn bộ logic thực thi nằm trong `playbook.md` cạnh file này (tách riêng để dễ versioning + maintain mà không đụng trigger contract). Khi skill kích hoạt: **mở playbook và chạy đúng theo contract của nó.**

## Vị trí trong pipeline

```
/usecase-factory:run ─▶ 4 doc research ─/usecase-factory:agent-domain-spec─▶ Agent-Domain-Spec.md ─/usecase-factory:grill-to-brief─▶ screens-brief.md ─▶ design-a-screen (ASCII)
                                              (nghiệp-vụ-agent)                                       (skill này: ra SPEC UI, KHÔNG phải ASCII)
```

`grill-to-brief` = **cầu nối nghiệp-vụ-agent → wireframe**. Nó ra một SPEC (bộ màn đã biện minh), KHÔNG phải ASCII. Nó **được phép reject · kill · narrow · pivot** — KHÔNG tự động biến research thành màn.

**Input chính = `Agent-Domain-Spec.md`** (output của `/usecase-factory:agent-domain-spec`): screen brief phải là **PROJECTION của spec đó** — mỗi màn surface một phần của nghiệp-vụ-agent (object/state cần thấy, decision/approval cần bề mặt, background job cần thông báo). KHÔNG tự phát minh nghiệp vụ. Nếu workspace **chưa có** `Agent-Domain-Spec.md` (workspace cũ) → **cảnh báo mạnh** rằng brief sẽ nông (bịa nghiệp vụ từ 4 doc) và **đề xuất chạy `/usecase-factory:agent-domain-spec` trước**; vẫn cho fallback về 4 doc research nếu user xác nhận.

## STEP 0 — đọc playbook trước (bắt buộc)

Trước khi làm bất cứ gì, **đọc `playbook.md`** trong thư mục skill này (`${CLAUDE_PLUGIN_ROOT}/skills/grill-to-brief/playbook.md`) từ đầu tới cuối. Đây là **GUIDE THỰC THI CHÍNH THỨC**. Chứa: nguyên tắc (một màn = một job × một user × một khoảnh khắc), 7-step workflow (map → grill từng màn → two-way coverage → MVP cut line → nav+flows → viết → copy pass), Screen Brief contract, và anti-patterns. Đừng chạy từ router này — router chỉ gọi tên các bước; playbook định nghĩa cách làm.

Template để điền vào `screens-brief.md` nằm tại `${CLAUDE_PLUGIN_ROOT}/skills/grill-to-brief/templates/05-screens-brief.template.md`.

## Command contract (tóm tắt — chi tiết ở playbook)

```
/usecase-factory:grill-to-brief <slug>
```

- Đọc `Agent-Domain-Spec.md` (input chính, nếu có) + cả 4 doc research từ `doc/ws-<slug>/` (+ `brief.md` nếu có) TRƯỚC. Thiếu một loại doc research → nói rõ thiếu cái nào và dừng. Thiếu `Agent-Domain-Spec.md` → cảnh báo mạnh + đề xuất chạy `/usecase-factory:agent-domain-spec` trước, fallback 4 doc nếu user xác nhận.
- Grill **từng màn một**, recommend-rồi-chờ. Gate decision (screen-set, screen-hay-không, lỗ hổng coverage, cut line) không bao giờ tự điền âm thầm — nêu + confirm từng cái.
- Viết `doc/ws-<slug>/screens-brief.md` tăng dần (đừng dồn).

## Boundaries (tóm tắt — chi tiết ở playbook)

- KHÔNG vẽ ASCII — đó là `/usecase-factory:design-a-screen`.
- KHÔNG phát minh nghiệp vụ. Có `Agent-Domain-Spec.md` → màn là projection của spec đó; không thêm decision/action/state nghiệp vụ mà spec không có.
- KHÔNG bịa màn research không đỡ; không orphan screen, không job CAO bị hở, không dead-end CTA.
- KHÔNG ship brief thiếu flows + MVP cut line.
