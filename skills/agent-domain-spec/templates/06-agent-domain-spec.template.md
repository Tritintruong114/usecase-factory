# Agent Domain Spec — `ws-<slug>` ("<Tên hiển thị>")

<!--
TẦNG AGENT NGHIỆP VỤ (Agent Domain Spec) — sinh SAU /usecase-factory:run (research + Decision Gate)
và TRƯỚC /usecase-factory:grill-to-brief (screen brief). Là bản thiết kế CÁCH MỘT NGHIỆP VỤ ĐƯỢC AGENT HÓA,
chạy trên runtime OpenClaw, TRƯỚC khi vẽ UI.

Mô hình tư duy (giữ trong đầu khi điền):
  • Business process  = con người/quy trình làm việc ra sao (research mô tả cái này).
  • Agent Domain Spec = phần nào của quy trình giao cho agent, agent tự chủ tới đâu,
                        con người giữ kiểm soát rủi ro ở đâu, OpenClaw chạy nghiệp vụ bằng primitive nào.
  • Screen brief      = cách user NHÌN THẤY và ĐIỀU KHIỂN nghiệp vụ đó (grill-to-brief vẽ, là PROJECTION của file này).

Nguồn: _research/dossier.md (source of truth) · MVP-Coreloop.md · MR/JTBD · Target-User · Boi-Canh (· brief.md).
File đặt tại doc/ws-<slug>/Agent-Domain-Spec.md
Các heading dưới (0..19) là CONTRACT — giữ NGUYÊN thứ tự + tên (validator soi). Bỏ mọi <!-- guidance --> + <placeholder> khi điền.

OpenClaw primitives (dùng xuyên suốt §17): skills · tools/connectors · memory · sessions/subagents ·
cron/heartbeat · approval surfaces · guardrails · workspace state.
-->

> **Tầng nghiệp-vụ-agent.** Mô tả con agent thật sự *làm nghề* thế nào trước khi vẽ UI: quan sát object nào,
> hiểu lifecycle nào, phân loại intent ra sao, đọc signal nào, khi nào hành động / hỏi người / im, gọi tool nào,
> action nào cần duyệt, guardrail nào chặn rủi ro, feedback user cập nhật rule/memory gì — và map tất cả sang
> OpenClaw primitives. `/usecase-factory:grill-to-brief` đọc file này; mỗi màn phải là một PROJECTION của spec này.

## 0. Input & sources

- **Slug:** `<slug>`
- **Decision Gate verdict:** `<Proceed (từ dossier §8) — chỉ chạy tiếp khi Proceed>`
- **Sources read:** `<_research/dossier.md · MVP-Coreloop.md · MR-<slug>-Problem-Solution.md · Target-User-<slug>.md · Boi-Canh-Va-Van-De.md · brief.md (nếu có)>`
- **Core loop (từ MVP-Coreloop §2):** `<dán lại 1 dòng core loop — spec này agent-hóa đúng vòng lặp này>`
- **Trace rule:** mọi object / pain / job trong file này phải truy về một dòng trong dossier/4 doc. KHÔNG phát minh nghiệp vụ.

## 1. Domain thesis

<!-- Agent làm NGHỀ gì, và KHÔNG làm gì. Một đoạn ngắn, dứt khoát. Đây là ranh giới phạm vi nghề. -->

- **Agent làm nghề:** `<một câu — nghề/nghiệp vụ agent đảm nhận, vd "trực inbox đa kênh, phân loại và trả lời/leo thang lead">`
- **Agent KHÔNG làm:** `<những việc cố ý để ngoài — vd "không chốt đơn/thu tiền", "không tư vấn pháp lý", "không tự quyết khuyến mãi">`
- **Vì sao là agent (không phải automation/SaaS):** `<1–2 câu, dẫn từ dossier §1 Agent Fit Check>`

## 2. Human / Agent / Tool role split

<!-- Tách rõ 3 vai trên CÙNG nghiệp vụ: phần nào người làm, phần nào agent phán đoán, phần nào tool chỉ thực thi.
     Đây là nơi đặt ranh giới tự chủ. "Agent đề xuất → người duyệt" là một split hợp lệ và rất hay dùng. -->

| Bước nghiệp vụ | Người (Human) | Agent (phán đoán) | Tool (thực thi) |
|---|---|---|---|
| `<bước 1>` | `<quyết định/checkpoint gì>` | `<phán đoán/đề xuất gì>` | `<API/connector nào chạy>` |
| `<bước 2>` | `<...>` | `<...>` | `<...>` |

- **Ranh giới tự chủ (autonomy line):** `<agent tự chạy tới đâu trước khi cần người — 1–2 câu>`
- **Nơi con người giữ kiểm soát rủi ro:** `<checkpoint người không thể bỏ — feed §11 Approval policy>`

## 3. Core objects

<!-- Object NGHIỆP VỤ chính agent quan sát/thao tác. Ví dụ tùy domain: Thread, Contact, Action, Draft, Rule, Case, Lead, Order…
     Mỗi object: nó là gì, khóa nhận dạng, agent đọc/ghi field nào, nguồn dữ liệu. Truy về research. -->

| Object | Là gì | Khóa nhận dạng | Field agent quan tâm | Nguồn (connector/workspace) |
|---|---|---|---|---|
| `<Thread>` | `<...>` | `<id>` | `<status, lastMsg, channel…>` | `<Zalo/FB connector>` |
| `<Lead>` | `<...>` | `<...>` | `<...>` | `<...>` |

## 4. Object lifecycle / state machine

<!-- Cho object QUAN TRỌNG nhất (thường cái core loop xoay quanh): các state hợp lệ, transition (sự kiện → state mới),
     và terminal state. Đây là xương sống để §5 intent + §8 decision policy bám vào. KHÔNG để state mơ hồ/chồng lấn. -->

**Object:** `<tên object>`

- **States hợp lệ:** `<New → Triaged → AgentHandling → AwaitingHuman → Resolved / Dropped …>`
- **Terminal states:** `<Resolved · Dropped · Lost …>`

| Từ state | Sự kiện / điều kiện | Sang state | Ai gây transition (agent/người/cron) |
|---|---|---|---|
| `<New>` | `<agent phân loại xong>` | `<Triaged>` | `<agent>` |
| `<AgentHandling>` | `<confidence thấp / lead nóng>` | `<AwaitingHuman>` | `<agent>` |
| `<...>` | `<...>` | `<...>` | `<...>` |

> Mọi state ở đây phải xuất hiện lại ở §16 (background job nào quét/đổi state) và được PROJECT thành display/outcome state khi grill vẽ màn.

## 5. Intent taxonomy

<!-- Agent phân loại TÌNH HUỐNG/INPUT theo intent nào. Đây là cách agent "hiểu chuyện gì đang xảy ra".
     Mỗi intent: dấu hiệu nhận biết + hành động mặc định (link tới §8). Có nhánh "không chắc / ngoài phạm vi". -->

| Intent | Dấu hiệu nhận biết | Hành động mặc định | Ghi chú |
|---|---|---|---|
| `<Hỏi giá>` | `<từ khóa/ngữ cảnh>` | `<trả lời từ catalog>` | `<...>` |
| `<Khiếu nại>` | `<...>` | `<leo thang người>` | `<rủi ro cao>` |
| `<Ngoài phạm vi / không rõ>` | `<không khớp intent nào>` | `<fallback §10>` | `<bắt buộc có nhánh này>` |

## 6. Signals / features

<!-- Agent ĐỌC signal nào để quyết định? Từ input (nội dung tin), từ tool/connector (lịch sử đơn, CRM),
     từ context (giờ, kênh), từ memory (rule đã học, preference). Mỗi signal: nguồn + dùng cho quyết định nào. -->

| Signal | Nguồn (input / tool / context / memory) | Dùng cho quyết định nào |
|---|---|---|
| `<độ nóng của lead>` | `<input + lịch sử>` | `<§9 priority>` |
| `<giờ trong ngày>` | `<context>` | `<§16 after-hours auto-reply>` |
| `<rule "khách VIP">` | `<memory>` | `<§8 decision>` |

## 7. Eligibility rules

<!-- Điều kiện để một object ĐƯỢC ĐƯA VÀO queue / được agent hành động. Lọc trước khi tốn công.
     "Đủ điều kiện để agent xử" vs "phải bỏ qua / chờ". -->

- **Đủ điều kiện agent xử lý:** `<điều kiện — vd "thread có tin khách chưa trả + trong giờ hoặc bật after-hours">`
- **Không đủ / bỏ qua:** `<vd "spam đã gắn cờ", "đã có người đang trả">`
- **Vào hàng đợi chờ người:** `<điều kiện đẩy thẳng cho người>`

## 8. Decision policy

<!-- Agent CHỌN ACTION dựa trên policy nào. Dạng cây/bảng quyết định: tình huống (intent + signal + state) → action.
     Đây là "bộ não" — phải khớp lifecycle §4, intent §5, eligibility §7. Mọi nhánh dẫn tới một action có thật ở §12. -->

| # | Khi (intent + signal + state) | Action | Auto / Cần duyệt / Cấm (→ §11) |
|---|---|---|---|
| D1 | `<hỏi giá, có trong catalog, AgentHandling>` | `<gửi báo giá draft>` | `<cần duyệt lần đầu>` |
| D2 | `<khiếu nại, bất kỳ>` | `<leo thang + tạo Case>` | `<auto leo thang, không auto trả lời>` |
| D3 | `<confidence < ngưỡng>` | `<hỏi người / im>` | `<§10>` |

- **Nguyên tắc mặc định:** khi không có nhánh khớp → KHÔNG hành động mù; rơi về §10 (fallback) hoặc §11 (hỏi người).

## 9. Priority / scoring

<!-- urgent / important / value / confidence tính ra sao để xếp hàng đợi + chọn việc làm trước.
     Công thức/heuristic rõ ràng, dẫn từ signal §6. KHÔNG cần ML — heuristic minh bạch là đủ ở v0. -->

- **Urgency:** `<cách tính — vd "lead hỏi mua + < 1h từ tin cuối = cao">`
- **Importance / value:** `<vd "giá trị đơn dự kiến", "khách cũ">`
- **Confidence:** `<cách agent tự chấm độ chắc của phán đoán — feed §10>`
- **Thứ tự hàng đợi:** `<urgent desc, rồi value desc — cái gì nổi lên đầu cho người>`

## 10. Confidence & uncertainty

<!-- KHI NÀO agent chắc → tự làm; khi nào KHÔNG chắc → hỏi người / im; fallback khi confidence thấp.
     Đây là van an toàn quan trọng nhất chống over-automation. Đặt ngưỡng cụ thể, đừng để mơ hồ. -->

| Mức confidence | Agent làm gì |
|---|---|
| Cao (`<ngưỡng>`) | `<tự thực hiện action trong giới hạn §11/§12>` |
| Trung bình | `<đề xuất draft + chờ người duyệt>` |
| Thấp | `<KHÔNG hành động — hỏi người, hoặc im và gắn cờ>` |

- **Fallback an toàn khi không chắc:** `<luôn nghiêng về im/hỏi, KHÔNG đoán bừa — "khi nghi ngờ thì không tự gửi">`

## 11. Approval policy

<!-- Action nào AUTO, action nào CẦN HUMAN APPROVAL, action nào BỊ CẤM. Đây là bảng phân loại rủi ro lõi.
     Quy tắc an toàn: rủi ro/không-đảo-ngược/đối ngoại càng cao → càng cần duyệt. Mặc định khi phân vân = cần duyệt. -->

| Action | Phân loại | Lý do | Approval surface (→ §17) |
|---|---|---|---|
| `<đọc inbox, phân loại>` | `<Auto>` | `<chỉ đọc, đảo ngược được>` | `<—>` |
| `<gửi tin cho khách>` | `<Cần duyệt (v0) / Auto sau khi tin cậy>` | `<đối ngoại, khó thu hồi>` | `<approval queue>` |
| `<hoàn tiền / xóa dữ liệu>` | `<Cấm — luôn người làm>` | `<phá hủy/không đảo ngược>` | `<n/a>` |

- **Mặc định khi phân vân:** Cần duyệt (không bao giờ tự nâng lên Auto khi chưa có bằng chứng tin cậy).

## 12. Tool / action policy

<!-- Agent được gọi TOOL/CONNECTOR nào, với tham số/ràng buộc gì. Mỗi tool: input cho phép, giới hạn (rate, scope),
     và side-effect. Map sang §17 (tools/connectors). Đây là bề mặt agent chạm thế giới thật. -->

| Tool / connector | Agent được làm gì | Ràng buộc / giới hạn | Side-effect |
|---|---|---|---|
| `<Zalo send API>` | `<gửi text/template>` | `<≤ N tin/khách/ngày, chỉ trong scope thread>` | `<đối ngoại>` |
| `<CRM read>` | `<đọc lịch sử khách>` | `<read-only>` | `<không>` |
| `<CRM write>` | `<cập nhật stage lead>` | `<chỉ field cho phép>` | `<đổi workspace state>` |

## 13. Draft / content policy

<!-- CHỈ điền nếu domain có sinh nội dung (trả lời, báo giá, email…). Nếu không → ghi "Không áp dụng — domain không sinh nội dung".
     tone · length · versioning · lần 1 vs lần 2 khác gì (vd lần 2 nhắc nhẹ hơn / leo thang). -->

- **Tone:** `<lấy từ Target-User + copy register — chuyên nghiệp-nhẹ, không emoji>`
- **Length:** `<giới hạn độ dài theo kênh>`
- **Versioning:** `<draft v1 → người sửa → v2; lưu bản đã duyệt làm mẫu (memory)>`
- **Lần 1 vs lần 2+:** `<follow-up lần 2 đổi gì — nhẹ hơn / nhắc / dừng sau N lần để không spam>`

## 14. Guardrails / anti-abuse / trust boundaries

<!-- Cái CHẶN rủi ro. Không spam, không gửi nhầm người, không đọc/lưu quá mức (data minimization), không over-automate.
     Mỗi guardrail: chặn cái gì + cơ chế chặn. Đây là hàng rào, không phải gợi ý. Map sang §17 guardrails. -->

| Guardrail | Chặn rủi ro gì | Cơ chế |
|---|---|---|
| `<Rate limit gửi>` | `<spam khách>` | `<≤ N tin/khách/ngày, cooldown>` |
| `<Khớp đúng thread/khách>` | `<gửi nhầm người>` | `<bind action vào object id, không gửi ngoài thread>` |
| `<Data minimization>` | `<đọc/lưu quá mức>` | `<chỉ đọc field §3, không lưu PII ngoài cần thiết>` |
| `<Anti over-automation>` | `<tự quyết việc rủi ro>` | `<mọi action §11=Cấm/Cần duyệt không bao giờ auto>` |
| `<Trust boundary>` | `<input độc hại / prompt injection từ khách>` | `<không thực thi lệnh trong nội dung khách; tool chỉ gọi theo §12>` |

## 15. Learning loop

<!-- User CORRECTION nào cập nhật RULE/MEMORY/STATE gì. Vòng phản hồi làm agent giỏi dần mà KHÔNG mất kiểm soát.
     Mỗi loại sửa của người → ghi vào memory dạng nào → ảnh hưởng quyết định sau ra sao. -->

| User correction | Cập nhật gì | Phạm vi áp dụng |
|---|---|---|
| `<sửa nội dung draft>` | `<lưu mẫu đã duyệt vào memory>` | `<intent tương tự sau>` |
| `<từ chối một đề xuất>` | `<hạ confidence cho pattern đó / thêm rule loại trừ>` | `<object cùng loại>` |
| `<gắn nhãn lại intent>` | `<bổ sung dấu hiệu §5>` | `<phân loại sau>` |

- **Ranh giới học:** agent KHÔNG tự nới quyền (§11) bằng learning — nâng auto là quyết định người, không phải máy tự học.

## 16. Background jobs

<!-- Việc chạy NỀN (không phải màn): scan, classify, detect, retry, snooze, re-open, notify.
     Mỗi job: trigger (cron/sự kiện), làm gì, đổi state nào (§4). Map sang §17 cron/heartbeat. -->

| Job | Trigger | Làm gì | Đổi state (§4) |
|---|---|---|---|
| `<Scan inbox>` | `<heartbeat mỗi N phút>` | `<lấy tin mới, phân loại §5>` | `<New → Triaged>` |
| `<Detect lead nguội>` | `<cron>` | `<không phản hồi sau X giờ → nhắc/đóng>` | `<… → Dropped>` |
| `<Snooze / re-open>` | `<sự kiện>` | `<...>` | `<...>` |
| `<Notify người>` | `<có AwaitingHuman>` | `<đẩy thông báo>` | `<—>` |

## 17. OpenClaw implementation map

<!-- Map TỪNG PHẦN trên sang OpenClaw primitive. Đây là cầu nối spec ↔ runtime. KHÔNG hand-wave: mỗi primitive
     phải trỏ về section ở trên. OpenClaw là runtime/operating layer; spec này là SOP nghiệp vụ chạy trên nó. -->

| OpenClaw primitive | Nghiệp vụ này dùng nó cho gì | Trỏ về section |
|---|---|---|
| **Skills** | `<năng lực/SOP agent — phân loại, soạn draft, leo thang>` | `<§5, §8, §13>` |
| **Tools / connectors** | `<Zalo/FB/CRM… cụ thể>` | `<§12>` |
| **Memory** | `<rule đã học, mẫu đã duyệt, preference>` | `<§6, §15>` |
| **Sessions / subagents** | `<mỗi thread = một session; subagent cho việc dài>` | `<§3, §4>` |
| **Cron / heartbeat** | `<scan, detect, retry, snooze>` | `<§16>` |
| **Approval surfaces** | `<hàng đợi duyệt cho action cần người>` | `<§11>` |
| **Guardrails** | `<rate limit, scope binding, data minimization>` | `<§14>` |
| **Workspace state** | `<store object + state machine>` | `<§3, §4>` |

## 18. Metrics

<!-- Đo agent làm nghề tốt không + lòng tin được giữ không. Mỗi metric: định nghĩa + ngưỡng mong muốn (nếu có). -->

| Metric | Định nghĩa | Mục tiêu (nếu có) |
|---|---|---|
| False positive | `<agent hành động khi đáng lẽ không>` | `<thấp>` |
| False negative | `<bỏ sót việc đáng xử>` | `<thấp>` |
| Approval rate | `<% đề xuất được người duyệt y nguyên>` | `<cao = tin cậy tăng>` |
| Edit distance | `<người sửa draft nhiều ít>` | `<giảm dần>` |
| Action success | `<% action đạt kết quả mong muốn>` | `<...>` |
| Trust recovery | `<sau một lỗi, bao lâu/đk gì để mở lại auto>` | `<...>` |

## 19. Open questions / assumptions

<!-- Cái spec này còn giả định/chưa chắc — feed sang grill + primary research. KHÔNG bịa. -->

| Giả định / câu hỏi mở | Nếu sai thì sao | Cách kiểm chứng |
|---|---|---|
| `<ngưỡng confidence đặt đúng chưa>` | `<over/under automation>` | `<đo edit distance + approval rate sau pilot>` |
| `<khách chấp nhận agent trả lời tự động không>` | `<mất lòng tin>` | `<phỏng vấn / A-B>` |

- **Biggest open risk:** `<rủi ro nghiệp-vụ nguy hiểm nhất nếu spec sai — mang sang grill>`
</content>
