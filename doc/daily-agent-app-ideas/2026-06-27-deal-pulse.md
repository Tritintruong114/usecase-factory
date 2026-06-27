# DealPulse

## Slug
deal-pulse

## One-liner
Agent rà soát pipeline B2B mỗi sáng, gom ngữ cảnh từ CRM và email, soạn draft follow-up có lý do, rồi chờ founder phê duyệt trước khi gửi.

## Target user
- **Segment:** Founder hoặc Sales Lead tại startup / agency B2B quy mô 3–30 người, tự làm sales hoặc quản lý team sales nhỏ
- **Power-user or end-user:** Power-user
- **Market / geography:** Việt Nam (mở rộng tiếp sang SEA)
- **Buyer:** Founder / Head of Sales
- **User:** Người trực tiếp phụ trách pipeline (thường chính là founder)

---

## Pain hypothesis
- **Current workflow:** Mỗi sáng, sales mở CRM (thường là Google Sheet, Notion, hoặc HubSpot dùng chưa hết tính năng), lọc deal không có hoạt động mới, mở từng email thread để nhớ lại context, rồi tự ngồi soạn tin nhắn follow-up cho từng khách.
- **Specific pain:** Mất 1–2 giờ mỗi sáng chỉ để "nhớ lại" trạng thái deal và soạn follow-up; kết quả là nhiều deal rơi vào im lặng vì không ai bắt kịp — không phải vì không muốn, mà vì không đủ tay.
- **Frequency:** Hàng ngày với sales full-time, 2–3 lần/tuần với founder kiêm sales.
- **Why now:** Công cụ CRM phổ thông tại Việt Nam bị dùng như bảng tính tĩnh, không có intelligence; founder ngại setup automation phức tạp nhưng đang cần thứ gì đó "nghĩ thay" mình về deal nào cần đụng tới hôm nay.
- **Current substitutes:** Nhắc lịch thủ công trong Google Calendar, Notion reminder, hoặc quản lý bằng trí nhớ và cảm giác.

---

## Agent fit
| Trục | Đánh giá | Lý do ngắn |
|---|---|---|
| **Judgment** | Yes | Cần đọc tone email thread (im lặng vs. hỏi thêm) để chọn đúng hành động và độ ưu tiên |
| **Multi-step tool use** | Yes | Đọc CRM → kéo email → kiểm lịch họp → soạn draft → đề xuất kênh gửi |
| **Memory / context** | Yes | Phải nhớ lịch sử deal, cam kết trước đó, pattern phản hồi của từng khách |
| **Messy conversation** | Yes | Email thread thực tế lộn xộn, nhiều CC, ngôn ngữ hỗn Việt–Anh |
| **Proactive follow-up** | Yes | Agent tự trigger theo lịch hoặc khi deal quá hạn cập nhật — không cần người dùng khởi động |
| **Human checkpoint** | Yes | Founder phê duyệt từng draft trước khi gửi; không có gì rời hộp thư mà không có người ký |

---

## Agent flow
- **Trigger:** 8h sáng mỗi ngày làm việc (có thể config), hoặc ngay khi một deal vượt ngưỡng stale (mặc định: 3 ngày không có hoạt động).
- **Context / memory:** Kéo danh sách deal từ CRM, đọc email thread gần nhất của từng deal, tra lịch sử ghi chú và stage, nhớ pattern: khách này thường trả lời buổi chiều, hay hỏi về pricing, deal tương tự trước đây đã mất vì delay follow-up.
- **Plan:** Phân loại từng deal theo mức độ rủi ro (hot / warm / cold / lost-risk), xác định hành động phù hợp (re-engage nhẹ / nudge proposal / yêu cầu họp / escalate tới founder), chọn tone và kênh theo context.
- **Tools / integrations:** CRM API (HubSpot hoặc Google Sheet), Gmail API, Google Calendar API, Claude API để phân tích thread và soạn thảo.
- **Decision points:** Deal này có nên drop không? Gửi email hay nhắn LinkedIn/Zalo? Founder có cần review trực tiếp không hay sales tự xử được?
- **Human checkpoint:** Founder/sales nhận **morning digest** — danh sách deal cần xử lý hôm nay, mỗi item gồm: tên deal, last activity, draft follow-up, lý do đề xuất → **Approve / Chỉnh sửa / Bỏ qua** từng item trước khi bất cứ thứ gì được gửi đi.
- **Action:** Gửi email đã được approve (hoặc lưu vào Draft nếu founder chọn chỉnh thêm), cập nhật CRM stage và thêm ghi chú tự động.
- **Follow-up:** Sau 2–3 ngày không có phản hồi từ khách, agent tự tạo reminder tiếp theo và đề xuất hành động leo thang (ví dụ: gửi lại proposal với góc nhìn mới, đề xuất demo ngắn).
- **Memory / learning update:** Ghi lại: draft nào được approve ngay vs. bị chỉnh nhiều; deal nào bị skip liên tục (tín hiệu drop); pattern phản hồi của từng khách → dùng để cải thiện draft và mức ưu tiên lần sau.
- **Failure handling:** Không đọc được email thread (lỗi permission) → báo ngay trong digest và skip deal đó thay vì im lặng. CRM không cập nhật được → log lỗi rõ ràng, không silent fail. Gmail rate limit → queue và thử lại sau 15 phút.

---

## Control surface / user flow
- **Primary surface:** Daily digest qua Slack message hoặc web app nhỏ — hiển thị danh sách deal cần xử lý hôm nay theo thứ tự ưu tiên.
- **Review queue:** Mỗi item trong digest gồm: tên khách + tên deal, ngày hoạt động cuối, tóm tắt thread 2–3 dòng, draft follow-up, lý do đề xuất, và 3 nút hành động.
- **Approval / override actions:** **Gửi ngay** (approve draft), **Chỉnh** (mở editor inline rồi gửi), **Snooze** (bỏ qua N ngày), **Drop deal** (mark lost và ngừng theo dõi).
- **History / audit trail:** Log đầy đủ: email nào đã gửi, ai approve, lúc mấy giờ, deal ở stage nào tại thời điểm đó.
- **Settings:** Cấu hình ngưỡng stale (N ngày), giờ trigger, kênh nhận digest (Slack / email), tone mặc định (formal / casual), ngôn ngữ draft (Việt / Anh / song ngữ), danh sách deal cần exclude.
- **Exception handling:** Deal không rõ owner → gán cho founder mặc định và đánh dấu để clarify. Email thread quá dài (>50 email) → agent tóm tắt và gắn nhãn "cần đọc kỹ thêm" thay vì bỏ qua.

---

## MVP scope
- **v0 core loop:** Mỗi sáng, agent đọc Google Sheet CRM + Gmail, chọn 3–5 deal stale nhất, soạn draft follow-up bằng Claude kèm lý do 1 câu, gửi digest lên Slack để founder approve/skip từng item, sau khi approve thì gửi email và ghi chú vào Sheet.
- **Must have:** Google Sheet + Gmail integration, daily trigger lúc 8h, draft follow-up có lý do, approve/skip action trong Slack, ghi chú tự động vào CRM sau khi gửi.
- **Explicitly not v0:** HubSpot integration, pattern learning tự động, multi-language switching, Zalo/LinkedIn channel, mobile app, deal scoring phức tạp.
- **Data needed:** OAuth quyền đọc/ghi Google Sheet và Gmail của user; template tone mặc định do founder cung cấp lần đầu.

---

## Risk questions for usecase-factory
- **Buyer clarity:** Hypothesis — founder B2B startup/agency Việt Nam tự làm sales hoặc quản lý team nhỏ, đang thấy pipeline "chảy máu" vì thiếu follow-up kịp lúc.
- **Pain intensity:** Hypothesis — pain rõ khi pipeline có 10+ deal đang chạy song song; có thể bị xem là "nice to have" nếu pipeline còn nhỏ hoặc founder chưa tracking nghiêm túc.
- **Willingness to pay:** Chưa rõ — cần validate xem founder Việt sẵn sàng trả cho automation intelligence hay vẫn muốn tự ghép bằng Zapier/Make/n8n.
- **Substitute strength:** Zapier + HubSpot sequences khá mạnh nhưng cần setup kỹ thuật cao và không có judgment; Google Sheet + Calendar reminder phổ biến nhưng không scalable.
- **Feasibility:** Khả thi cao với Gmail + Google Sheet API trong v0; phức tạp hơn khi tích hợp CRM proprietary hoặc xử lý thread đa ngôn ngữ lộn xộn.
- **GTM wedge:** Cộng đồng founder/sales B2B Việt Nam (Vietnam Founders, Startup.vn, các group sales B2B SaaS trên Facebook) — dễ tiếp cận nếu có demo video thực tế chạy trên pipeline thật.

---

## Factory command
```bash
/usecase-factory:run deal-pulse "Agent rà soát pipeline B2B mỗi sáng, tổng hợp context từ CRM và Gmail, soạn draft follow-up kèm lý do, chờ founder phê duyệt trước khi gửi — dành cho founder và sales lead startup B2B tại Việt Nam"
```
