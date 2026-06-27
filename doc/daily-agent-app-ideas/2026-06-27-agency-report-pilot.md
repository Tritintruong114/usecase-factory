# ReportPilot

## Slug
`agency-report-pilot`

## Một câu mô tả
Agent tự động kéo dữ liệu từ nhiều nền tảng quảng cáo, viết phần nhận xét chiến lược có ngữ cảnh từng client, và gửi báo cáo hàng tuần/tháng sau khi account manager duyệt một lần.

---

## Tín hiệu vấn đề thị trường

- **Thị trường / địa lý đã quét:** Thị trường agency digital marketing toàn cầu; có xác nhận hệ sinh thái agency tại Việt Nam (HCMC, Hà Nội) qua Clutch.co và TechBehemoths.
- **Nguồn tham khảo:**
  - [Agency Reporting Automation: 11 Best Tools & Platforms (2026) — Improvado](https://improvado.io/blog/agency-reporting-automation)
  - [How Marketing Agencies Are Using AI to Automate Client Reporting — DataStaq AI](https://datastaqai.com/blog/agency-client-reporting-automation)
  - [Solving 5 Big Pain Points of Digital Marketing Agencies — Repstack](https://repstack.co/solving-5-big-pain-points-of-digital-marketing-agencies/)
  - [Client Reporting Best Practices That Redefine Agency Success — Swydo](https://www.swydo.com/blog/client-reporting-best-practices/)
- **Nỗi đau lặp lại quan sát được:**
  - Account manager dành hơn 20% thời gian làm việc mỗi tuần để kéo số liệu từ GA4, Meta Ads, Google Ads, TikTok Ads rồi copy thủ công vào Google Slides hoặc Excel.
  - Một agency 10 người ước tính mất 8–12 giờ/tuần chỉ để tổng hợp số, format và viết nhận xét — để client đọc trong 90 giây (nguồn: DataStaq AI, 2025).
  - 42,86% client không hài lòng với báo cáo agency: quá nhiều chỉ số không có diễn giải, không có khuyến nghị hành động, template một-cho-tất-cả (nguồn: Swydo/Repstack).
  - Báo cáo thủ công là một trong các lý do chính khiến agency mất client: agency theo retainer mất khoảng 18% client/năm, agency theo project mất gần 42%/năm (nguồn: Repstack).
- **Cách làm thay thế hiện tại:** Xuất CSV thủ công → dán vào Google Slides/Canva → viết nhận xét → gửi email. Một số agency dùng AgencyAnalytics hoặc Swydo để tổng hợp số nhưng vẫn phải viết phần nhận xét chiến lược thủ công.
- **Vì sao vấn đề này hợp với agent:** Trigger định kỳ rõ ràng, dữ liệu phân tán nhiều nguồn, phần nhận xét đòi hỏi phán đoán ngữ cảnh theo từng client — không chỉ là automation đơn thuần; human checkpoint tự nhiên trước khi gửi.
- **Độ tin cậy:** Cao — nhiều nguồn độc lập xác nhận cùng một nỗi đau; gap giữa "tổng hợp số" và "viết narrative" đã được nhiều bài viết trong ngành gọi tên.

---

## Người dùng mục tiêu

- **Phân khúc:** Power user — operators
- **Nhóm người dùng:** Account manager và agency owner tại digital marketing agency quy mô nhỏ–vừa (5–50 người, quản lý 10–40 client account)
- **Thị trường / địa lý:** Toàn cầu; Việt Nam (HCMC, Hà Nội) là thị trường cụ thể có thể tiếp cận sớm
- **Người mua:** Agency owner / Head of Account
- **Người dùng trực tiếp:** Account manager

---

## Giả thuyết nỗi đau

- **Quy trình hiện tại:** Mỗi tuần hoặc tháng, account manager đăng nhập riêng từng platform, xuất số liệu, dán vào file template của agency, viết đoạn nhận xét giải thích biến động, format, gửi email hoặc link cho client — lặp lại với toàn bộ portfolio.
- **Nỗi đau cụ thể:**
  1. Phần lớn thời gian là kéo–dán–format cơ học, không phải tư duy chiến lược.
  2. Nhận xét thường chung chung vì thiếu thời gian phân tích sâu; client không hành động được từ báo cáo.
  3. Deadline báo cáo của nhiều client trùng nhau → chất lượng không đồng đều.
  4. Khi số liệu xấu, account manager không biết cách frame để giữ quan hệ.
- **Tần suất:** Hàng tuần hoặc hàng tháng, lặp lại với mỗi client — không bao giờ biến mất.
- **Vì sao là lúc này:** GA4 API, Meta Marketing API, Google Ads API đã ổn định và có SDK tốt; LLM đủ năng lực để viết nhận xét có ngữ cảnh chất lượng cao; thị trường agency Việt Nam đang tăng trưởng nhanh và bắt đầu tìm cách nâng năng suất không cần tuyển thêm người.
- **Cách thay thế hiện tại:** AgencyAnalytics, Swydo (tổng hợp số nhưng không viết narrative); Looker Studio (tự build dashboard, không có phần nhận xét); Google Slides thủ công.

---

## Độ phù hợp với agent

- **Cần phán đoán:** Có — agent phải quyết định biến động nào là bất thường thực sự vs. nhiễu tracking, điểm nào đáng highlight cho từng client cụ thể, tone phù hợp với từng mối quan hệ.
- **Cần dùng nhiều công cụ / nhiều bước:** Có — GA4 API, Meta Marketing API, Google Ads API, TikTok Ads API, Google Sheets/Notion (ghi chú campaign), email API hoặc Slack (giao nhận) đan xen trong một luồng duy nhất.
- **Cần trí nhớ / ngữ cảnh:** Có — mục tiêu KPI của client, baseline kỳ trước, phong cách giao tiếp ưa thích, lịch sử bất thường đã giải thích, ghi chú campaign đang chạy.
- **Có hội thoại hoặc dữ liệu lộn xộn:** Có — dữ liệu từ nhiều platform với schema khác nhau, ghi chú campaign không chuẩn hoá, đôi khi thiếu dữ liệu một platform.
- **Cần chủ động theo dõi:** Có — agent tự chạy theo lịch, theo dõi client đã đọc báo cáo chưa, nhắc khi không có phản hồi.
- **Cần điểm duyệt của con người:** Có — account manager review và approve bản thảo trước khi gửi client; đây là điểm kiểm soát quan hệ quan trọng, không thể bỏ qua.

---

## Luồng agent

- **Kích hoạt:** Lịch định kỳ (ví dụ: mỗi thứ Hai 8h sáng cho báo cáo tuần trước) hoặc account manager trigger thủ công cho một client cụ thể.
- **Ngữ cảnh / trí nhớ:** Tải mục tiêu KPI đã cam kết với client, số liệu baseline kỳ trước, ghi chú campaign đang hoạt động, phong cách báo cáo đã lưu (tone, độ chi tiết), lịch sử các bất thường đã được giải thích.
- **Kế hoạch:**
  1. Kéo số liệu từ toàn bộ platform đã kết nối cho kỳ báo cáo.
  2. So sánh với baseline kỳ trước và mục tiêu đã cam kết.
  3. Xác định top 3–5 điểm đáng nêu: wins, concerns, anomalies.
  4. Viết nhận xét narrative từng section — giải thích biến động, frame theo mục tiêu client, đề xuất hành động.
  5. Format vào template của agency.
  6. Đánh dấu các mục cần account manager chú ý đặc biệt trước khi gửi.
- **Công cụ / tích hợp:** GA4 API, Meta Marketing API, Google Ads API, TikTok Ads API, Google Sheets hoặc Notion (ghi chú campaign), email API (gửi báo cáo).
- **Điểm ra quyết định:** Biến động có phải lỗi tracking hay thay đổi thực? Win nào đáng highlight prominently? Tone cho client này: thẳng thắn hay nhẹ nhàng? Có nên đề xuất thay đổi ngân sách không?
- **Điểm duyệt của con người:** Account manager nhận bản thảo trong review queue — đọc toàn bộ, chỉnh inline nếu cần, bấm **Duyệt & Gửi** hoặc **Trả về agent** kèm ghi chú.
- **Hành động:** Gửi báo cáo đến client (email hoặc link Notion), ghi log delivery vào hệ thống nội bộ, tạo reminder cho cuộc gọi review nếu số liệu đáng lo ngại.
- **Theo dõi tiếp:** Kiểm tra client đã đọc email chưa (open tracking), nhắc account manager nếu không có phản hồi sau N ngày, gợi ý lịch call nếu cần.
- **Cập nhật trí nhớ / học từ phản hồi:** Lưu loại nhận xét nào client phản hồi tích cực, cập nhật phong cách giao tiếp ưa thích, đánh dấu bất thường nào là false alarm để giảm noise lần sau.
- **Xử lý lỗi:** API không khả dụng → tạo báo cáo một phần với ghi chú data gap rõ ràng; dữ liệu nghi ngờ lỗi tracking → flag trước khi generate, không tự suy diễn; thiếu credentials → cảnh báo account manager ngay, không silent fail.

---

## Bề mặt điều khiển / luồng người dùng

- **Bề mặt chính:** Review queue — danh sách bản thảo báo cáo đang chờ duyệt, sắp xếp theo deadline gửi client; mỗi item hiển thị client name, kỳ báo cáo, số điểm agent cần chú ý, thời gian đọc ước tính.
- **Hàng đợi duyệt:** Bản thảo full report với các section được highlight (wins màu xanh, concerns màu đỏ, agent notes màu vàng); account manager đọc và chỉnh sửa text inline.
- **Hành động duyệt / can thiệp:** Duyệt & Gửi / Sửa rồi Duyệt / Trả về agent kèm ghi chú / Tạm hoãn gửi.
- **Lịch sử / audit trail:** Log đầy đủ từng báo cáo: thời điểm kéo dữ liệu, thời điểm tạo bản thảo, ai đã chỉnh sửa gì, thời điểm gửi, thời điểm client mở.
- **Cài đặt:** Kết nối platform API theo từng client, cấu hình lịch báo cáo, template agency, ngưỡng flag bất thường (%), phong cách nhận xét (tone, độ chi tiết).
- **Xử lý ngoại lệ:** Account manager có thể skip kỳ này, merge với kỳ tới, hoặc ghi chú lý do hoãn; cảnh báo nếu dữ liệu kỳ này thiếu >20% so với kỳ trước.

---

## Phạm vi MVP

- **Vòng lặp lõi v0:** Kết nối ≥2 platform (GA4 + Meta Ads) → pull dữ liệu tự động theo lịch → tạo bản thảo narrative → account manager duyệt một lần → gửi email.
- **Bắt buộc có:** Kết nối GA4 API và Meta Ads API, template báo cáo cơ bản, review queue cho account manager, flow duyệt một click, delivery qua email, lưu baseline kỳ trước.
- **Chưa làm ở v0:** TikTok Ads, Google Ads, branded PDF, đa ngôn ngữ (EN/VI), client portal tự đọc, learning tự động từ phản hồi, white-label.
- **Dữ liệu cần có:** API credentials của từng platform theo từng client, mục tiêu KPI đã xác định từ onboarding, lịch gửi báo cáo theo từng client.

---

## Câu hỏi rủi ro cho usecase-factory

- **Độ rõ của người mua:** Trung bình — agency owner quyết định mua nhưng account manager mới là người cần thuyết phục hàng ngày; cần validate cả hai bên.
- **Cường độ nỗi đau:** Cao — 20%+ thời gian tuần bị chiếm; nhưng nhiều agency đã "chịu đựng quen" với quy trình thủ công và chưa thấy giải pháp thuyết phục.
- **Sẵn sàng chi trả:** Trung bình — agency đã quen trả tiền tool (AgencyAnalytics ~$179/tháng); wedge là narrative layer mà tool hiện tại không cung cấp, cần chứng minh ROI thời gian cụ thể.
- **Sức mạnh của cách thay thế:** Trung bình — AgencyAnalytics/Swydo giải quyết data assembly nhưng không giải quyết commentary; gap thực sự tồn tại và chưa có tool nào lấp đầy.
- **Tính khả thi:** Cao — các API chính đã public và có SDK tốt; phần thách thức là prompt engineering để narrative đủ chất lượng và nhất quán với từng client.
- **Wedge GTM:** Bắt đầu với một agency pilot (1 agency, 3–5 client account); chứng minh tiết kiệm ≥6 giờ/tuần và tăng điểm hài lòng client trước khi mở rộng.

---

## Lệnh chạy factory

```bash
/usecase-factory:run agency-report-pilot "agent tự động pull dữ liệu đa platform và viết narrative báo cáo client hàng tuần cho account manager tại digital marketing agency"
```
