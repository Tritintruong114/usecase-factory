---
name: agent-domain-spec
description: Biến research dossier + MVP core loop thành Agent Domain Spec — bản thiết kế CÁCH MỘT NGHIỆP VỤ ĐƯỢC AGENT HÓA trước khi vẽ UI: agent quan sát object nào, hiểu lifecycle/state nào, phân loại intent ra sao, đọc signal nào, khi nào hành động / hỏi người / im, gọi tool nào, action nào cần approval, guardrail nào chặn rủi ro, feedback user cập nhật rule/memory gì — và map tất cả sang OpenClaw primitives (skills, tools/connectors, memory, sessions/subagents, cron/heartbeat, approval surfaces, guardrails, workspace state). Ghi doc/ws-<slug>/Agent-Domain-Spec.md — input cho /usecase-factory:grill-to-brief (screen brief là PROJECTION của spec này). Chạy SAU /usecase-factory:run (Decision = Proceed) và TRƯỚC grill-to-brief. Dùng khi user nói "thiết kế agent nghiệp vụ", "agent domain spec", "spec cách agent làm nghề", "agent hóa nghiệp vụ", "/usecase-factory:agent-domain-spec".
disable-model-invocation: true
---

# Agent Domain Spec — router

Skill này là **router mỏng**. Toàn bộ logic thực thi nằm trong `playbook.md` cạnh file này (tách riêng để versioning + maintain mà không đụng trigger contract). Khi skill kích hoạt: **mở playbook và chạy đúng theo contract của nó.**

## Vị trí trong pipeline

```
/usecase-factory:run ─▶ dossier + 4 doc + Decision Gate ─/usecase-factory:agent-domain-spec─▶ Agent-Domain-Spec.md ─/usecase-factory:grill-to-brief─▶ screens-brief.md
   (research + verdict)                                   (skill này: nghiệp-vụ-agent, KHÔNG phải UI)        (UI = projection của spec)
```

`agent-domain-spec` = **cầu nối research → nghiệp-vụ-agent**. Với Agent Apps, ĐỪNG nhảy thẳng từ core loop sang screen brief. Tầng này mô tả con agent *làm nghề* thế nào (object · lifecycle · intent · signal · decision · approval · guardrail · learning · background jobs) và map sang **OpenClaw primitives**, TRƯỚC khi UI được vẽ. Nó **được phép** đẩy ngược (flag pivot/narrow) nếu nghiệp vụ không agent-hóa được an toàn.

Mô hình tư duy: **Business process** (research tả) → **Agent Domain Spec** (phần nào giao agent, tự chủ tới đâu, người giữ rủi ro ở đâu, OpenClaw chạy bằng primitive nào) → **Screen brief** (cách user nhìn + điều khiển). OpenClaw là runtime; spec này là SOP nghiệp vụ chạy trên nó.

## STEP 0 — đọc playbook trước (bắt buộc)

Trước khi làm bất cứ gì, **đọc `playbook.md`** trong thư mục skill này (`${CLAUDE_PLUGIN_ROOT}/skills/agent-domain-spec/playbook.md`) từ đầu tới cuối. Đây là **GUIDE THỰC THI CHÍNH THỨC**: 7-step flow, spec của `domain-modeler-agent` + `agent-logic-reviewer`, 20-section contract của `Agent-Domain-Spec.md`, các luật load-bearing (anti-over-automation, mọi action phân loại auto/duyệt/cấm, mọi phần map sang OpenClaw primitive), và boundaries. Router chỉ gọi tên các bước; playbook định nghĩa cách làm.

Template điền vào `Agent-Domain-Spec.md` nằm tại `${CLAUDE_PLUGIN_ROOT}/skills/agent-domain-spec/templates/06-agent-domain-spec.template.md`.
Template điền vào `01-PRODUCT-MAP.md` (Decision Pack — bản đồ quyết định sản phẩm 1 trang) nằm tại `${CLAUDE_PLUGIN_ROOT}/skills/agent-domain-spec/templates/07-product-map.template.md`.
Validator: `${CLAUDE_PLUGIN_ROOT}/scripts/validate-agent-domain-spec.sh` (cũng kiểm tra `01-PRODUCT-MAP.md` tồn tại cạnh spec).

## Command contract (tóm tắt — chi tiết ở playbook)

```
/usecase-factory:agent-domain-spec <slug>
```

- Đọc `appendix/dossier.md` + 4 doc research trong `appendix/` + `appendix/MVP-Coreloop.md` (+ `brief.md`) từ `doc/ws-<slug>/` TRƯỚC. Thiếu dossier hoặc MVP core loop → nói rõ thiếu cái nào và DỪNG (không thể agent-hóa khi chưa có nghiệp vụ + vòng lặp).
- Chỉ chạy tiếp khi **Decision Gate = Proceed**. Verdict khác → trình lại quyết định, không tự vượt.
- Derive từng section; các **gate rủi ro** (role split / autonomy line · approval policy auto-vs-duyệt-vs-cấm · guardrails · confidence fallback) KHÔNG bao giờ tự điền âm thầm — recommend rồi chờ confirm.
- Ghi `doc/ws-<slug>/Agent-Domain-Spec.md` tăng dần (đừng dồn). Sau đó tổng hợp `doc/ws-<slug>/01-PRODUCT-MAP.md` (Decision Pack — bản đồ quyết định sản phẩm) và cập nhật routing trong `00-START-HERE.md`. Chạy validator trước khi xong.

## Outputs (bắt buộc)

- `doc/ws-<slug>/Agent-Domain-Spec.md` — đủ 20 section (§0–§19), validator pass.
- `doc/ws-<slug>/01-PRODUCT-MAP.md` — Decision Pack: pain → user → workflow → agent job → giá trị → moat, core loop + agent actions + approval + guardrails + metrics, và danh sách KHÔNG build ở V0.
- `doc/ws-<slug>/00-START-HERE.md` — cập nhật (không tạo mới): routing trỏ tới `Agent-Domain-Spec.md` + `01-PRODUCT-MAP.md`, tick trạng thái pipeline.

```
bash ${CLAUDE_PLUGIN_ROOT}/scripts/validate-agent-domain-spec.sh doc/ws-<slug>/Agent-Domain-Spec.md
```

## Boundaries (tóm tắt — chi tiết ở playbook)

- KHÔNG vẽ màn / ASCII / HTML — đó là grill-to-brief → design-a-screen → brief-to-html.
- KHÔNG over-automate: mọi action phải phân loại Auto / Cần duyệt / Cấm; phân vân → Cần duyệt.
- KHÔNG bịa nghiệp vụ research không đỡ — mọi object/intent/pain trace về dossier/4 doc.
- KHÔNG để phần nào treo lơ lửng ngoài OpenClaw map (§17) — mỗi phần trỏ về một primitive.
