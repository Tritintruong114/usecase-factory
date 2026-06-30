# Research Dossier: `<slug>`

<!--
TẦNG RESEARCH (intermediate) — sinh TRƯỚC 4 output, là SOURCE OF TRUTH DUY NHẤT cho chúng.
Lớp gom bằng chứng MARKET RESEARCH TỪ INTERNET: spawn N sub-agent chạy nghiên cứu thị trường trên web
(fan-out search → fetch nguồn → verify ≥2 nguồn → trích URL) → tổng hợp về đây → MỚI synthesize 4 output.
Mục đích KÉP:
  (a) truy nguồn — mỗi claim output → một dòng + URL ở đây;
  (b) RA QUYẾT ĐỊNH — kết bằng Decision Gate (proceed / pivot / narrow / kill), KHÔNG chỉ đẻ doc đẹp.
Vault chỉ là seed ngữ cảnh, KHÔNG phải nguồn số liệu.
File đặt tại doc/ws-<slug>/_research/dossier.md
Các heading dưới (0..9) là CONTRACT — giữ nguyên thứ tự + tên. Bỏ mọi <!-- guidance --> + <placeholder> khi điền.
-->

> **Tầng research → quyết định.** Source of truth cho 4 doc output VÀ cho kết luận build/pivot/narrow/kill.
> Engine: web (WebSearch + WebFetch). Vault = seed ngữ cảnh. Kết bằng **Decision Gate** + **Handoff Recommendation**.

## 0. Input

- **Slug:** `<slug>`
- **Original idea:** `<ý tưởng + market gốc user đưa>`
- **Existing brief:** `<doc/ws-<slug>/brief.md có/không — cái gì đã chốt>`
- **Research date:** `<YYYY-MM-DD>`

## 1. Agent Fit Check

<!--
CỔNG LỌC SỚM — chạy TRƯỚC khi synthesize sâu. Câu hỏi gốc:
"Vì sao đây phải là AI Agent, thay vì SaaS thường / automation đơn giản / chatbot / VA người / quy trình thủ công?"
Chấm 6 trục dưới. Yếu nhiều trục → ghi rõ + đề xuất pivot HOẶC reframe thành non-agent automation (đẩy tín hiệu này vào Decision Gate).
Đây KHÔNG phải nơi bán ý tưởng — chấm thật.
-->

**Vì sao AI Agent (không phải SaaS / automation / chatbot / VA / thủ công)?** `<luận điểm 1–3 câu>`

| Trục fit | Có? (Yes/Weak/No) | Bằng chứng / lý do |
|---|---|---|
| Cần **phán đoán** (judgment, không phải rule cứng) | `<...>` | `<...>` |
| Cần **multi-step tool use** (gọi nhiều công cụ/bước nối tiếp) | `<...>` | `<...>` |
| Cần **trí nhớ / ngữ cảnh** xuyên nhiều lần tương tác | `<...>` | `<...>` |
| Xử lý **hội thoại ngôn ngữ tự nhiên lộn xộn** | `<...>` | `<...>` |
| Cần **chủ động follow-up** (proactive, không chỉ phản hồi) | `<...>` | `<...>` |
| Hưởng lợi từ **checkpoint người duyệt** (human-in-the-loop) | `<...>` | `<...>` |

- **Phán quyết fit:** `<Strong agent fit / Weak — reframe non-agent / Weak — pivot>`
- **Nếu yếu:** `<đề xuất: pivot use-case HOẶC reframe thành SaaS/automation thường — feed vào §8 Decision Gate>`

## 2. Sweep Log

<!-- Một dòng mỗi agent. Đây là PHẦN CHỨNG MINH cơ chế đã chạy. -->

| Agent | Scope | Queries (góc chính) | Sources fetched | Status |
|---|---|---|---|---|
| A | Market sizing & context | `<queries>` | `<n>` | `<coverage / kết>` |
| B | JTBD / pain | `<queries>` | `<n>` | `<...>` |
| C | Competitor + substitute/workaround | `<queries>` | `<n>` | `<...>` |
| D | Persona / WTP | `<queries>` | `<n>` | `<...>` |

## 3. Evidence Table

<!--
Mỗi dòng = một claim. Output chỉ được nói cái có dòng ở đây. Maps = output section nó feed.
PHÂN LOẠI CLAIM (cột "Lớp") — KHÔNG bắt cite từng câu, mà cite ĐÚNG loại:
  • MUST-CITE  → bắt buộc URL nguồn: market size, giá/pricing, traction đối thủ, quy định/regulation,
                 ngân sách/budget buyer, claim về mức độ adoption, trích dẫn pain (quote thật).
  • INFER      → được suy luận, KHÔNG cần URL nhưng ghi rõ "infer": hình dạng workflow, hành vi persona điển hình, giả định UX.
  • ASSUMPTION → PHẢI gắn nhãn giả định (chưa kiểm chứng): willingness-to-pay, độ cấp bách (urgency),
                 hành vi chuyển đổi (switching), khả thi tích hợp (integration feasibility), ROI vận hành.
Verify chỉ áp cho MUST-CITE: ✓ (≥2 nguồn độc lập) / single / unverified. INFER + ASSUMPTION ghi "—".
-->

| ID | Claim | Lớp (must-cite / infer / assumption) | Source URL | Source type | Date | Verify | Maps to output | Notes |
|---|---|---|---|---|---|---|---|---|
| E1 | `<claim>` | `<must-cite>` | `<url>` | `<báo cáo/vendor/forum/...>` | `<date>` | `<✓ / single / unverified>` | `<Boi-Canh §2 / MR §1 / ...>` | `<...>` |
| E2 | `<claim suy luận>` | `<infer>` | — | — | — | — | `<...>` | `<cơ sở suy luận>` |
| E3 | `<WTP / urgency / switching>` | `<assumption>` | — | — | — | — | `MR §0 / §8` | `<rủi ro nếu sai>` |

## 4. Evidence Strength

<!-- Trung thực về độ chắc. Phân biệt rõ cái đã verify vs single-source vs suy luận vs giả định. -->

- **Multi-source (✓):** `<liệt kê ID — claim chắc nhất>`
- **Single-source (single):** `<ID — cần verify thêm gì>`
- **Inferred (không nguồn, suy luận):** `<ID>`
- **Assumptions (chưa kiểm chứng):** `<ID — willingness-to-pay / urgency / switching / integration / ROI>`
- **Contradictions:** `<nguồn lệch nhau, ghi cả hai + cách xử>`

## 5. Substitute / Workaround Map

<!--
KHÔNG chỉ đối thủ AI trực tiếp. Liệt kê MỌI cách tệp user đang giải vấn đề hôm nay, kể cả "không làm gì".
Đây là thước đo thật cho pain: nếu workaround miễn phí + đủ tốt → pain yếu → tín hiệu pivot/kill.
Với SME Việt Nam: BẮT BUỘC soi Zalo, Facebook, TikTok, sàn TMĐT (marketplace), Google Sheets/Excel, follow-up thủ công.
-->

| Loại thay thế | Đang có / dùng? | Họ giải vấn đề thế nào | Chi phí (tiền/công) | Mạnh | Yếu (khe ta chen) | Nguồn / nhãn |
|---|---|---|---|---|---|---|
| AI tool trực tiếp | `<...>` | `<...>` | `<giá>` | `<...>` | `<...>` | [nguồn](url) |
| Vertical SaaS | `<...>` | `<...>` | `<...>` | `<...>` | `<...>` | [nguồn](url) |
| Agency / freelancer | `<...>` | `<...>` | `<...>` | `<...>` | `<...>` | [nguồn](url) |
| Nhân sự / admin (lao động người) | `<...>` | `<...>` | `<...>` | `<...>` | `<...>` | `<infer/assumption>` |
| Zalo / Facebook / inbox thủ công | `<...>` | `<...>` | `<...>` | `<...>` | `<...>` | [nguồn](url) |
| Google Sheets / Excel | `<...>` | `<...>` | `<...>` | `<...>` | `<...>` | `<infer>` |
| TikTok / sàn TMĐT (nếu liên quan) | `<...>` | `<...>` | `<...>` | `<...>` | `<...>` | [nguồn](url) |
| "Không làm gì" (do nothing) | `<...>` | `<chịu đau / bỏ qua>` | `<chi phí ẩn>` | `<...>` | `<...>` | `<assumption>` |

- **Workaround mạnh nhất:** `<cái khó đánh bại nhất — vì rẻ/đủ tốt/đã quen>`
- **Khe trống thật:** `<điều chưa cách nào phục vụ tốt — chỗ ta chen vào>`

## 6. Output Mapping

<!-- Mỗi output đủ nguyên liệu để gộp chưa? Trụ nào còn dựa giả định (ghi rõ trong output đó). -->

| Output | Đủ converge? | Evidence (ID) | Trụ còn dựa giả định |
|---|---|---|---|
| `Boi-Canh-Va-Van-De.md` | `<✓/✗>` | `<E#>` | `<...>` |
| `MR-<slug>-Problem-Solution.md` | `<✓/✗>` | `<E#>` | `<...>` |
| `Target-User-<slug>.md` | `<✓/✗>` | `<E#>` | `<...>` |
| `MVP-Coreloop.md` | `<✓/✗>` | `brief.md / <E#>` | `<...>` |

## 7. Assumptions and Risks

<!-- Cái output cần mà web không trả lời → primary research, KHÔNG bịa. Mỗi gap → ghi thẳng vào MR §0 + MR §3. -->

| Giả định / gap | Lớp | Nếu sai thì sao | Cách kiểm chứng (primary research) |
|---|---|---|---|
| `<willingness-to-pay / urgency / ...>` | `<assumption>` | `<tác động>` | `<phỏng vấn N user / khảo sát>` |
| `<thiếu market size / pricing thật>` | `<gap must-cite>` | `<tác động>` | `<nguồn cần tìm>` |

- **Questions for human:** `<câu hỏi cần user/chuyên gia trả lời>`
- **Biggest unresolved risk:** `<giả định rủi ro nhất nếu sai — feed thẳng vào §8>`

## 8. Decision Gate

<!--
CỔNG QUYẾT ĐỊNH — LÝ DO tồn tại của factory. Factory là cổng VÀO GRILL, không phải cổng BUILD:
Proceed = "đủ chắc để đáng grill", KHÔNG đòi WTP đã verify (WTP luôn = assumption ở khâu web).
QUY TẮC WTP: WTP/urgency/switching chưa kiểm KHÔNG phải lý do hạ Proceed — nó là cờ rủi ro #1 mang sang grill.
Chấm theo cây (đúng thứ tự), chọn ĐÚNG MỘT:
  1. Agent-fit yếu?                    → Pivot (reframe non-agent automation/SaaS/chatbot).
  2. Pain không đáng trả / không khe?  → Kill.
  3. Substitute RÕ RÀNG thắng (đủ tốt + tệp sẽ không rời, có bằng chứng)? → Pivot.
  4. Buyer/market quá rộng để grill?   → Narrow (vì SCOPE, KHÔNG vì thiếu WTP).
  5. Còn lại (fit + pain + khe thật, WTP chưa kiểm) → Proceed (default lành mạnh; WTP = cờ rủi ro #1).
"Substitute tồn tại" ≠ "substitute thắng" — mọi thị trường có cách-làm-cũ; chỉ Pivot khi có bằng chứng tệp sẽ KHÔNG trả tiền cho cái mới.
KHÔNG mặc định bừa (cả Proceed lẫn Narrow).
-->

- **Quyết định:** `<Proceed to /usecase-factory:grill-to-brief | Pivot use-case | Narrow buyer/market | Kill>`
- **Rationale:** `<2–4 câu vì sao — dựa pain intensity, agent fit, workaround strength, WTP signal>`
- **Confidence:** `<High / Medium / Low>`
- **Top evidence IDs:** `<E# E# E# — bằng chứng chống lưng quyết định>`
- **Biggest unresolved risk:** `<giả định nguy hiểm nhất còn treo (từ §7)>`
- **Nếu Pivot/Narrow:** `<hướng mới / buyer-market thu hẹp đề xuất>`

## 9. Handoff Recommendation

<!--
Bàn giao cho /usecase-factory:grill-to-brief — KHÔNG khung "tự động biến thành screen brief".
/usecase-factory:grill-to-brief CÓ QUYỀN reject / kill / narrow / pivot use-case. Liệt kê đúng cái grill phải chất vấn.
-->

- **Trạng thái:** `<đủ 4 input + dossier sẵn sàng cho grill / chưa đủ — lý do>`
- **`/usecase-factory:grill-to-brief` được phép:** reject · kill · narrow · pivot — KHÔNG mặc định convert thành screen-brief.
- **Grill phải chất vấn trước (theo thứ tự rủi ro):**
  - [ ] Buyer rõ chưa (ai ký tiền)?
  - [ ] Pain đủ mạnh (intensity + frequency)?
  - [ ] Willingness-to-pay có tín hiệu hay chỉ giả định?
  - [ ] Agent fit (§1) có thật không?
  - [ ] Data / integration feasibility?
  - [ ] GTM path (đường ra thị trường)?
  - [ ] Substitute/workaround (§5) có quá mạnh không?
- **Chạy tiếp (chỉ khi Decision = Proceed):** `/usecase-factory:agent-domain-spec <slug>` (agent-hóa nghiệp vụ → OpenClaw), rồi `/usecase-factory:grill-to-brief <slug>` (screen brief = projection của spec).
