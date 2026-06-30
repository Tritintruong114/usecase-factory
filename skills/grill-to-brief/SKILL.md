---
name: grill-to-brief
description: Grill 4 doc research (Context & Problem, MR/JTBD, Target User, MVP & Core Loop) thành Screen Brief — bộ màn đã biện minh, mỗi màn trace về một vấn đề thật từ góc target user. Phỏng vấn từng màn một: ép gọi tên mục đích duy nhất + JTBD phục vụ + khoảnh khắc trong ngày, map mọi hành động tới state nó sinh + vẽ flow đầu-cuối, chạy two-way coverage check (không orphan, không job cao bị hở, không dead-end CTA), rồi polish microcopy. Ghi doc/ws-<slug>/screens-brief.md — input cho /usecase-factory:design-a-screen → /usecase-factory:mockup-to-html → prototype. Chạy SAU khi có 4 doc research, TRƯỚC khi vẽ màn. Dùng khi user nói "grill ra screen brief", "biến research thành bộ màn", "chốt bộ màn trước khi vẽ", "chạy grill-to-brief", "/usecase-factory:grill-to-brief".
disable-model-invocation: true
---

# Grill to Brief — router

Skill này là **router mỏng**. Toàn bộ logic thực thi nằm trong `playbook.md` cạnh file này (tách riêng để dễ versioning + maintain mà không đụng trigger contract). Khi skill kích hoạt: **mở playbook và chạy đúng theo contract của nó.**

## Vị trí trong pipeline

```
/usecase-factory:run ──▶ 4 doc research ──/usecase-factory:grill-to-brief──▶ screens-brief.md ──/usecase-factory:design-a-screen──▶ mockups (ASCII)
                                            (skill này: ra SPEC, KHÔNG phải ASCII)
```

`grill-to-brief` = **cầu nối research → wireframe**. Nó ra một SPEC (bộ màn đã biện minh), KHÔNG phải ASCII. Nó **được phép reject · kill · narrow · pivot** — KHÔNG tự động biến research thành màn.

## STEP 0 — đọc playbook trước (bắt buộc)

Trước khi làm bất cứ gì, **đọc `playbook.md`** trong thư mục skill này (`${CLAUDE_PLUGIN_ROOT}/skills/grill-to-brief/playbook.md`) từ đầu tới cuối. Đây là **GUIDE THỰC THI CHÍNH THỨC**. Chứa: nguyên tắc (một màn = một job × một user × một khoảnh khắc), 7-step workflow (map → grill từng màn → two-way coverage → MVP cut line → nav+flows → viết → copy pass), Screen Brief contract, và anti-patterns. Đừng chạy từ router này — router chỉ gọi tên các bước; playbook định nghĩa cách làm.

Template để điền vào `screens-brief.md` nằm tại `${CLAUDE_PLUGIN_ROOT}/skills/grill-to-brief/templates/05-screens-brief.template.md`.

## Command contract (tóm tắt — chi tiết ở playbook)

```
/usecase-factory:grill-to-brief <slug>
```

- Đọc cả 4 doc research từ `doc/ws-<slug>/` (+ `brief.md` nếu có) TRƯỚC. Thiếu một loại → nói rõ thiếu cái nào và dừng.
- Grill **từng màn một**, recommend-rồi-chờ. Gate decision (screen-set, screen-hay-không, lỗ hổng coverage, cut line) không bao giờ tự điền âm thầm — nêu + confirm từng cái.
- Viết `doc/ws-<slug>/screens-brief.md` tăng dần (đừng dồn).

## Boundaries (tóm tắt — chi tiết ở playbook)

- KHÔNG vẽ ASCII — đó là `/usecase-factory:design-a-screen`.
- KHÔNG bịa màn research không đỡ; không orphan screen, không job CAO bị hở, không dead-end CTA.
- KHÔNG ship brief thiếu flows + MVP cut line.
