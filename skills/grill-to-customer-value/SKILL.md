---
name: grill-to-customer-value
description: Grill dossier + 4 doc research (Context & Problem, MR/JTBD, Target User, MVP & Core Loop) của /usecase-factory:run thành một Customer Value & Fear Map — customer value cốt lõi, giá trị của agent app theo lớp, nỗi sợ xếp hạng, cơ hội, vấn đề, và các nhóm tính năng lớn để giải nỗi sợ + deliver customer value, chốt bằng một bảng chi tiết feature-centric truy vết ngược về nỗi sợ/giá trị/job gốc. Cơ chế grill ba lớp: (1) Claude tự chọn một persona + khoảnh khắc cụ thể từ Target User/Context doc rồi ĐÓNG VAI tự trả lời trước, mồi bằng giả thuyết bám bằng chứng dossier; (2) PHỎNG VẤN user từng câu một ở những chỗ chỉ user mới phán đoán được (docs không trả lời nổi); (3) luân phiên draft-rồi-thu hẹp để hội tụ dần về đúng 1-2 customer value/nỗi sợ cốt lõi. Tối thiểu ~12-15 câu hỏi cả hành trình, không tự chốt gate nào âm thầm. Đứng ĐỘC LẬP, không bắt buộc trong pipeline chính — không skill nào khác phụ thuộc input của nó, chạy được bất cứ lúc nào sau /usecase-factory:run. Ghi doc/ws-<slug>/customer-value.md. Dùng khi user nói "grill ra customer value", "tìm nỗi sợ và giá trị khách hàng", "customer value là gì", "map nỗi sợ và cơ hội", "/usecase-factory:grill-to-customer-value".
disable-model-invocation: true
---

# Grill to Customer Value — router

Skill này là **router mỏng**. Toàn bộ logic thực thi nằm trong `playbook.md` cạnh file này (tách riêng để dễ versioning + maintain mà không đụng trigger contract). Khi skill kích hoạt: **mở playbook và chạy đúng theo contract của nó.**

## Vị trí trong pipeline

```
/usecase-factory:run ─▶ dossier + 4 doc research ─┬─▶ /usecase-factory:agent-domain-spec ─▶ grill-to-brief ─▶ ... (pipeline chính)
                                                    │
                                                    └─▶ /usecase-factory:grill-to-customer-value (skill này)
                                                             ▶ doc/ws-<slug>/customer-value.md
```

`grill-to-customer-value` = **cầu nối research → sự thật customer**. Nó ĐỘC LẬP với pipeline chính: không skill nào khác (agent-domain-spec, grill-to-brief) đọc `customer-value.md` tự động, và skill này không chặn/không cần các skill đó chạy trước hay sau. Đây là một lát cắt bổ sung — dùng khi cần trả lời rõ "khách mua vì cái gì, sợ cái gì, feature nào bắt buộc" trước khi đi tiếp bất kỳ hướng nào (agent-hóa nghiệp vụ hay thiết kế màn).

## STEP 0 — đọc playbook trước (bắt buộc)

Trước khi làm bất cứ gì, **đọc `playbook.md`** trong thư mục skill này (`${CLAUDE_PLUGIN_ROOT}/skills/grill-to-customer-value/playbook.md`) từ đầu tới cuối. Đây là **GUIDE THỰC THI CHÍNH THỨC**: nguyên tắc grill ba lớp (đóng vai → phỏng vấn → thu hẹp), cách chọn persona/khoảnh khắc, checklist câu hỏi từng phase, ngưỡng hội tụ, Customer Value contract, và anti-patterns. Đừng chạy từ router này — router chỉ gọi tên các bước; playbook định nghĩa cách làm.

Template để điền vào `customer-value.md` nằm tại `${CLAUDE_PLUGIN_ROOT}/skills/grill-to-customer-value/templates/10-customer-value.template.md`.

## Command contract (tóm tắt — chi tiết ở playbook)

```
/usecase-factory:grill-to-customer-value <slug>
```

- Đọc `appendix/dossier.md` + cả 4 doc research trong `doc/ws-<slug>/appendix/` (+ `brief.md` nếu có) TRƯỚC. Thiếu một loại doc research → nói rõ thiếu cái nào và dừng.
- Chọn + công bố một persona/khoảnh khắc cụ thể để grill qua đó (không hỏi xin phép dài dòng, chỉ nêu rõ + cho user redirect nếu chọn sai).
- Tự đóng vai trả lời trước (draft bám bằng chứng), rồi phỏng vấn user từng câu một những chỗ chỉ user phán đoán được, rồi thu hẹp dần — **không bao giờ tự chốt gate lớn (customer value cốt lõi, nỗi sợ #1, feature must-have) mà không hỏi user**.
- Ghi `doc/ws-<slug>/customer-value.md` tăng dần theo từng mục đã hội tụ (đừng dồn tới cuối).
- Nếu `doc/ws-<slug>/00-START-HERE.md` đã tồn tại (từ `run`/`agent-domain-spec`/`grill-to-brief`) → thêm MỘT dòng ghi chú trỏ tới `customer-value.md` (không bắt buộc phải có file này để routing hoạt động, không tạo mới 00-START-HERE.md nếu chưa tồn tại).

## Boundaries (tóm tắt — chi tiết ở playbook)

- KHÔNG tự chốt gate lớn (customer value cốt lõi / nỗi sợ #1 / feature must-have) mà không hỏi user xác nhận.
- KHÔNG bịa nỗi sợ/cơ hội/vấn đề không đỡ được bằng dossier hoặc câu trả lời thật của user trong buổi grill — brainstorm được phép (đây là mục đích cốt lõi của skill), nhưng mọi claim vẫn phải gắn nhãn must-cite/infer/assumption như dossier.
- KHÔNG vẽ màn, không thiết kế feature chi tiết (UI/flow) — đó là `agent-domain-spec`/`grill-to-brief`. Skill này chỉ dừng ở TÊN nhóm feature + lý do, không xuống tới UI.
- KHÔNG dồn câu hỏi — hỏi một câu, chờ trả lời, rồi mới hỏi tiếp (đúng nhịp `grill-to-brief`).
- KHÔNG dừng grill quá sớm — dưới ~12 câu hỏi hoặc chưa thấy core value/nỗi sợ #1 ổn định qua 2 vòng liên tiếp thì chưa được viết phần chốt của `customer-value.md`.
