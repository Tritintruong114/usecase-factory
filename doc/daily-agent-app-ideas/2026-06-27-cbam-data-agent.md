# CarbonPapertrail

## Slug
cbam-data-agent

## Một câu mô tả
Agent gom dữ liệu phát thải và chứng từ từ nhà cung cấp/nhà máy, kiểm tra thiếu sót, soạn gói trả lời CBAM/ESG cho buyer EU, rồi chờ trưởng nhóm compliance duyệt trước khi gửi.

## Tín hiệu vấn đề thị trường
- **Thị trường / địa lý đã quét:** Doanh nghiệp xuất khẩu Việt Nam và nhà cung cấp ngoài EU đang bán hàng vào EU; tham chiếu thêm tín hiệu toàn cầu từ doanh nghiệp nhập khẩu EU và nhà sản xuất nước thứ ba.
- **Nguồn tham khảo:**
  - https://taxation-customs.ec.europa.eu/carbon-border-adjustment-mechanism_en
  - https://www.energytransitionpartnership.org/wp-content/uploads/2024/06/20240318_Final-CBAM-Assessment-Report-final.pdf
  - https://www.businesseurope.eu/wp-content/uploads/2025/02/2024-05_cbam_implementation_-_businesseurope_survey_results_and_recommendations-0c7-1.pdf
  - https://www.corporatecomplianceinsights.com/cbam-supply-chain-hurdles-eu/
  - https://vietnamlawmagazine.vn/vietnams-textile-industry-faces-pressure-from-eus-new-rules-from-2028-79756.html
- **Nỗi đau lặp lại quan sát được:** Các quy định thương mại xanh của EU đang biến từ chính sách trừu tượng thành yêu cầu vận hành cụ thể: dữ liệu phát thải, thông tin nhà cung cấp, truy xuất nguồn gốc, chứng từ carbon và dữ liệu sản phẩm số. Nhiều nguồn cùng chỉ ra một điểm đau: thu thập dữ liệu phát thải chi tiết từ nhà sản xuất ở nước thứ ba rất khó, thủ công, phụ thuộc bảng tính, và nhiều nhà cung cấp nhỏ chưa hiểu cách cung cấp đúng dữ liệu.
- **Cách làm thay thế hiện tại:** Thuê tư vấn, dùng bảng tính rời rạc, điền bảng hỏi của buyer, gửi email qua lại với nhà máy, dùng giá trị phát thải mặc định khi còn được phép, và lưu chứng từ trong thư mục Drive/SharePoint thiếu chuẩn.
- **Vì sao vấn đề này hợp với agent:** Quy trình lặp lại, nhiều bên liên quan, nhiều tài liệu, có deadline, dễ thiếu dữ liệu và có rủi ro nếu trả lời sai. Nó cần agent biết đọc yêu cầu, phát hiện thiếu chứng từ, gọi công cụ để gom/chuẩn hoá file, chủ động nhắc nhà cung cấp, và luôn có con người duyệt trước khi gửi ra ngoài.
- **Độ tin cậy:** Trung bình. Áp lực quy định và nỗi đau thu thập dữ liệu có nguồn tốt; mức sẵn sàng chi trả và quy trình cụ thể của SME Việt Nam vẫn cần phỏng vấn.

## Người dùng mục tiêu
- **Phân khúc:** Đội compliance hoặc vận hành xuất khẩu tại SME sản xuất/xuất khẩu Việt Nam bán hàng cho buyer EU trong các chuỗi cung ứng dệt may, may mặc, linh kiện kim loại, bao bì hoặc ngành bị soi kỹ về bền vững.
- **Nhóm người dùng:** Power-user.
- **Thị trường / địa lý:** Doanh nghiệp xuất khẩu Việt Nam phục vụ buyer EU; có thể mở rộng sang nhà cung cấp ASEAN chịu yêu cầu chứng từ tương tự.
- **Người mua:** Giám đốc xuất khẩu, trưởng nhóm compliance hoặc chủ doanh nghiệp vận hành.
- **Người dùng trực tiếp:** Nhân sự compliance, admin xuất khẩu hoặc vận hành xuất khẩu chịu trách nhiệm trả lời bảng hỏi và gom chứng từ từ nhà máy/nhà cung cấp.

## Giả thuyết nỗi đau
- **Quy trình hiện tại:** Buyer EU gửi bảng hỏi hoặc yêu cầu chứng từ liên quan CBAM/ESG/DPP. Nhân sự compliance chuyển câu hỏi cho nhà máy/nhà cung cấp, đuổi theo dữ liệu năng lượng/nguyên liệu/quy trình còn thiếu, gom PDF/Excel, đổi tên file, đối chiếu câu trả lời mâu thuẫn, rồi tự soạn phản hồi gửi buyer.
- **Nỗi đau cụ thể:** Phần đau không chỉ là hiểu luật; phần nặng nhất là điều phối hằng ngày: hỏi đúng người về đúng dữ liệu, nhận ra trường nào còn thiếu, dịch yêu cầu của buyer thành ngôn ngữ nhà máy hiểu được, nhắc follow-up và giữ audit trail.
- **Tần suất:** Hàng tháng hoặc hàng quý với buyer có yêu cầu CBAM; tăng mạnh khi onboarding buyer mới, gia hạn compliance hằng năm, chuẩn bị audit hoặc khi quy định thay đổi.
- **Vì sao là lúc này:** CBAM bước vào giai đoạn compliance từ năm 2026, trong khi yêu cầu bền vững và Digital Product Passport của EU đang ép exporter xây hạ tầng dữ liệu sớm hơn thay vì xử lý chứng từ kiểu một lần.
- **Cách thay thế hiện tại:** Email thread, Excel tracker, thư mục Drive dùng chung, template do tư vấn chuẩn bị, phần mềm ESG cho doanh nghiệp lớn, và upload thủ công lên portal của buyer.

## Độ phù hợp với agent
| Trục | Đánh giá | Lý do ngắn |
|---|---|---|
| Cần phán đoán | Có | Cần quyết định chứng từ có trả lời đúng yêu cầu buyer không, dữ liệu nào còn thiếu, và gap nào cần escalate. |
| Cần dùng nhiều công cụ / nhiều bước | Có | Đọc request của buyer, parse spreadsheet/PDF, tra tracker nội bộ, email nhà cung cấp, cập nhật folder chứng từ, soạn phản hồi. |
| Cần trí nhớ / ngữ cảnh | Có | Cần nhớ lịch sử supplier, câu trả lời cũ, template đã được buyer chấp nhận, preference của từng buyer và gap audit trước đây. |
| Có hội thoại hoặc dữ liệu lộn xộn | Có | Nhà cung cấp thường trả lời thiếu, trễ, đa ngôn ngữ hoặc gửi file rải rác. |
| Cần chủ động theo dõi | Có | Agent nên chase supplier trước deadline và escalate request bị stale. |
| Cần điểm duyệt của con người | Có | Trưởng nhóm compliance phải duyệt mọi phản hồi gửi buyer hoặc upload lên portal. |

## Luồng agent
- **Kích hoạt:** Có yêu cầu compliance mới từ buyer qua email, file export từ portal hoặc bảng hỏi upload thủ công; hoặc lịch kiểm tra trước deadline báo cáo CBAM/ESG.
- **Ngữ cảnh / trí nhớ:** Hồ sơ buyer, danh sách supplier, câu trả lời đã gửi trước đây, template chứng từ được chấp nhận, mapping sản phẩm/nguyên liệu, các trường dữ liệu phát thải, deadline và rule escalate.
- **Kế hoạch:** Phân loại loại request, map từng trường dữ liệu sang owner/supplier, tìm chứng từ có thể tái sử dụng, lập danh sách gap và lên lịch nhắc.
- **Công cụ / tích hợp:** Gmail/Outlook, Google Drive/SharePoint, Google Sheets/Excel, parser PDF/OCR, danh bạ supplier, checklist từ buyer portal nếu có.
- **Điểm ra quyết định:** Trường dữ liệu này đã có evidence cũ chưa? Câu trả lời của supplier đủ chưa? Thiếu field này có chặn submission không? Có cần escalate lên compliance lead hoặc quản lý nhà máy không?
- **Điểm duyệt của con người:** Compliance lead nhận gói review gồm field đã hoàn tất, field thiếu, evidence chưa chắc, draft trả lời buyer và log follow-up supplier. Họ duyệt, sửa hoặc reject trước khi gửi.
- **Hành động:** Gửi follow-up cho supplier, sắp xếp folder chứng từ, soạn phản hồi cho buyer, tạo audit trail và chuẩn bị file đính kèm sẵn để upload.
- **Theo dõi tiếp:** Tự nhắc supplier ngày 2/ngày 5, escalate trước deadline và mở lại task nếu buyer hỏi thêm.
- **Cập nhật trí nhớ / học từ phản hồi:** Lưu câu trả lời được chấp nhận, evidence bị reject, độ tin cậy phản hồi của supplier, cách diễn đạt theo từng buyer và mapping evidence có thể tái sử dụng.
- **Xử lý lỗi:** Nếu không parse được tài liệu, flag để review thủ công. Nếu dữ liệu supplier mâu thuẫn, đánh dấu contradiction thay vì tự chọn. Nếu lỗi quyền email/Drive, hiển thị item bị ảnh hưởng trong review queue.

## Bề mặt điều khiển / luồng người dùng
- **Bề mặt chính:** Inbox yêu cầu compliance hiển thị request đang mở, buyer, deadline, phần trăm hoàn tất và mức rủi ro.
- **Hàng đợi duyệt:** Checklist theo từng field với trạng thái: đã có evidence, đang chờ supplier, cần người phán đoán, dữ liệu mâu thuẫn, sẵn sàng gửi.
- **Hành động duyệt / can thiệp:** Duyệt phản hồi, sửa câu trả lời, yêu cầu thêm evidence, gán owner supplier, escalate, đánh dấu không áp dụng, gửi hoặc submit.
- **Lịch sử / audit trail:** Log đầy đủ từng request gửi supplier, file đính kèm, chỉnh sửa, duyệt và phản hồi đã gửi theo buyer/sản phẩm/request.
- **Cài đặt:** Danh bạ supplier, nhịp nhắc, template được duyệt, ngôn ngữ theo buyer, field evidence bắt buộc và ngưỡng escalate.
- **Xử lý ngoại lệ:** Supplier không rõ owner thì route về compliance lead; dữ liệu phát thải mâu thuẫn thì tạo flag; sát deadline mà còn thiếu dữ liệu thì tạo escalation khẩn.

## Phạm vi MVP
- **Vòng lặp lõi v0:** Upload/paste yêu cầu buyer → agent trích field cần trả lời → map sang supplier/evidence tracker → soạn email follow-up supplier → tạo checklist review → compliance lead duyệt → agent gửi request supplier và chuẩn bị draft phản hồi buyer.
- **Bắt buộc có:** Tích hợp email và Drive, parser bảng hỏi, mapping danh bạ supplier, checklist review, lịch nhắc, cổng duyệt, audit log.
- **Chưa làm ở v0:** Engine tính carbon đầy đủ, đảm bảo đúng pháp lý CBAM, tự động submit portal, tích hợp ERP, theo dõi phát thải thời gian thực, tư vấn pháp lý thay chuyên gia.
- **Dữ liệu cần có:** 5-10 bảng hỏi buyer thật, danh sách supplier hiện tại, mẫu chứng từ, phản hồi đã được buyer chấp nhận trước đây, rule escalate của compliance owner.

## Câu hỏi rủi ro cho usecase-factory
- **Độ rõ của người mua:** Người mua là exporter Việt Nam, importer EU hay consultant phục vụ nhiều exporter?
- **Cường độ nỗi đau:** Việc gom evidence có đủ thường xuyên và đau với nhóm ngoài ngành CBAM rủi ro cao không, hay hiện tại chủ yếu vẫn do consultant xử lý?
- **Sẵn sàng chi trả:** SME có trả tiền cho workflow automation trước khi bị phạt trực tiếp không, hay chỉ mua khi buyer EU đưa điều khoản bắt buộc vào hợp đồng?
- **Sức mạnh của cách thay thế:** Nhiều nền tảng ESG/CBAM đã phục vụ doanh nghiệp lớn; wedge phải là supplier follow-up và đóng gói evidence nhẹ cho SME.
- **Tính khả thi:** Parse bảng hỏi buyer và PDF supplier là khả thi, nhưng tính đúng sai pháp lý/quy định phải để con người duyệt.
- **Wedge GTM:** Bắt đầu bằng một vertical hẹp có áp lực buyer EU rõ và quy trình chứng từ lặp lại, ví dụ exporter dệt may chuẩn bị cho DPP/ESG hoặc manufacturer CBAM-adjacent.

## Lệnh chạy factory
```bash
/usecase-factory:run cbam-data-agent "Agent gom dữ liệu phát thải, chứng từ ESG/CBAM và supplier follow-up cho compliance/export operations team tại SME Việt Nam bán vào EU"
```
