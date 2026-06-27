# QuoteFlow – Agent Báo Giá Xuất Khẩu Tự Động

## Slug
`export-quote-agent`

## One-liner
Agent tự động soạn báo giá xuất khẩu bằng tiếng Anh và lên lịch follow-up cho nhân viên sales SME thủy sản/nông sản Việt Nam khi nhận inquiry từ buyer nước ngoài.

## Target user
- **Segment:** Nhân viên kinh doanh xuất khẩu tại SME thủy sản/nông sản/thực phẩm chế biến Việt Nam (5–50 người)
- **Power-user hay end-user:** Power-user (sales lead hoặc trưởng phòng kinh doanh xuất khẩu)
- **Market / geography:** Việt Nam – các tỉnh trọng điểm xuất khẩu (TP.HCM, Cần Thơ, Đà Nẵng, Hải Phòng)
- **Buyer:** Giám đốc kinh doanh hoặc chủ doanh nghiệp SME
- **User:** Nhân viên sales xuất khẩu trực tiếp xử lý inquiry hằng ngày

## Pain hypothesis
- **Current workflow:** Nhận email/WhatsApp inquiry từ buyer → mở Excel kiểm tra bảng giá nguyên liệu → tra tỷ giá USD/EUR thủ công → tính giá FOB/CIF → soạn email báo giá tiếng Anh (thường dùng Google Translate) → gửi → ghi chú vào file Excel/notepad để nhớ follow-up → thường quên sau 3–5 ngày.
- **Specific pain:** Mỗi inquiry mất 30–60 phút; tỷ giá và giá nguyên liệu thay đổi hằng ngày dễ dẫn đến báo giá sai; tiếng Anh không chuyên nghiệp gây mất uy tín; quên follow-up → mất deal.
- **Frequency:** 3–15 inquiry/ngày trong mùa cao điểm (Q1, Q3).
- **Why now:** Áp lực cạnh tranh từ Thailand/Indonesia buộc SME Việt phải phản hồi nhanh hơn; tỷ giá biến động mạnh sau 2022 khiến sai số giá trở thành rủi ro tài chính thực.
- **Current substitutes:** Excel bảng giá + email tay + nhắc lịch Google Calendar; một số dùng CRM cơ bản (Bitrix24) nhưng không tự động soạn nội dung.

## Agent fit
- **Judgment:** **Yes** – Cần chọn điều khoản Incoterms phù hợp (FOB/CIF/EXW) dựa theo yêu cầu buyer và năng lực công ty, điều chỉnh tone báo giá theo từng thị trường (Nhật vs EU vs Mỹ).
- **Multi-step tool use:** **Yes** – Tra tỷ giá thực tế → đọc bảng giá nguyên liệu nội bộ → tính giá thành → soạn email tiếng Anh → tạo task follow-up.
- **Memory / context:** **Yes** – Cần nhớ lịch sử giao dịch với từng buyer (giá đã báo lần trước, điều khoản đã thỏa thuận, mặt hàng thường mua).
- **Messy conversation:** **Weak** – Inquiry đôi khi thiếu thông tin (không nêu số lượng, cảng đến, thời gian giao hàng), agent cần hỏi lại đúng điểm.
- **Proactive follow-up:** **Yes** – Tự lên lịch nhắc nhở sau 3 ngày nếu buyer chưa phản hồi, gửi follow-up email soạn sẵn.
- **Human checkpoint:** **Yes** – Nhân viên sales duyệt báo giá trước khi gửi (kiểm tra margin, điều khoản đặc biệt).

## Agent app concept
- **Trigger:** Nhân viên forward email inquiry vào hệ thống, hoặc paste nội dung WhatsApp vào giao diện agent.
- **Inputs:** Nội dung inquiry (mặt hàng, số lượng, cảng đến, thời gian giao hàng), bảng giá nguyên liệu nội bộ (Google Sheet / Excel upload), tỷ giá thực tế (API Vietcombank hoặc ExchangeRate API).
- **Tools / integrations:** Google Sheets (bảng giá nội bộ), ExchangeRate API, Gmail/SMTP (gửi email), Google Calendar hoặc task queue (follow-up scheduler), tùy chọn: kết nối Zalo OA nếu buyer liên lạc qua Zalo.
- **Agent loop:**
  1. Phân tích inquiry → trích xuất: mặt hàng, số lượng, Incoterms yêu cầu, cảng, deadline.
  2. Nếu thiếu thông tin → hỏi nhân viên sales (không hỏi thẳng buyer).
  3. Tra bảng giá nội bộ + tỷ giá hiện tại → tính giá đề xuất.
  4. Soạn email báo giá tiếng Anh (chuyên nghiệp, đúng format thương mại quốc tế).
  5. Trình nhân viên duyệt (hiển thị bản nháp + breakdown tính giá).
  6. Sau khi duyệt → gửi email + tạo task follow-up sau 3 ngày.
  7. Nếu buyer reply → nhắc nhân viên và đề xuất bước tiếp theo.
- **Human approval point:** Nhân viên sales xem bản nháp báo giá và số liệu tính giá, có thể chỉnh sửa trước khi ký duyệt gửi.
- **Output:** Email báo giá tiếng Anh hoàn chỉnh + task follow-up có deadline + bản ghi lưu lịch sử inquiry.
- **Success metric:** Thời gian từ nhận inquiry đến gửi báo giá giảm từ 45 phút xuống dưới 10 phút; tỷ lệ quên follow-up về 0.

## MVP scope
- **v0 core loop:** Nhận text inquiry (paste tay) → tính giá từ Google Sheet → soạn email nháp → nhân viên duyệt → gửi → tạo reminder follow-up trên Google Calendar.
- **Must have:** Parser trích xuất thông tin inquiry, kết nối Google Sheets bảng giá, tích hợp tỷ giá thực, email template tiếng Anh chuẩn thương mại, giao diện duyệt/chỉnh sửa đơn giản.
- **Explicitly not v0:** Tích hợp Zalo OA, tự động đọc email inbox (phức tạp về OAuth + spam risk), CRM pipeline view, phân tích win/loss rate.
- **Data needed:** Bảng giá nguyên liệu mẫu của 1–2 doanh nghiệp pilot, 20–30 email inquiry thực để kiểm tra parser, danh sách Incoterms phổ biến theo từng thị trường.

## Risk questions for usecase-factory
- **Buyer clarity:** Chủ SME có sẵn sàng trả tool riêng khi đã dùng Excel miễn phí không? Hay cần đóng gói vào gói dịch vụ xuất khẩu lớn hơn?
- **Pain intensity:** Nhân viên sales có thực sự cảm thấy đây là pain lớn nhất, hay vấn đề chính là thiếu lead hơn là xử lý chậm? (hypothesis – cần verify)
- **Willingness to pay:** SME thủy sản thường nhạy giá; mức sẵn lòng chi trả cho SaaS nội bộ chưa rõ – cần phỏng vấn.
- **Substitute strength:** Excel + Google Translate hiện tại "đủ dùng" với nhiều người; switching cost thấp nhưng thói quen mạnh.
- **Feasibility:** Parser inquiry tiếng Anh/Nhật/Hàn đa dạng format có thể cần fine-tune; bảng giá nội bộ mỗi công ty một cấu trúc khác nhau → onboarding phức tạp.
- **GTM wedge:** Tiếp cận qua hiệp hội xuất khẩu (VASEP cho thủy sản, Agroviet cho nông sản) hoặc các đơn vị tư vấn logistics xuất khẩu có thể là kênh phù hợp hơn self-serve.

## Factory command
```bash
/usecase-factory:run export-quote-agent "Agent tự động soạn báo giá xuất khẩu tiếng Anh và follow-up cho sales SME thủy sản/nông sản Việt Nam"
```
