# Customer Value & Fear Map — ws-<slug>

<!--
Field key + section heading giữ NGUYÊN — /usecase-factory:grill-to-customer-value điền theo đúng shape này.
Chỉ value điền tiếng Việt. Xoá mọi <placeholder> + comment hướng dẫn khi điền.
File này KHÔNG nằm trong pipeline bắt buộc — không skill nào tự động đọc nó.
-->

> Phase: grill (persona simulation + interview) — ĐỘC LẬP, không bắt buộc trong pipeline chính. Chạy được bất cứ lúc nào sau /usecase-factory:run.
> Source: appendix/dossier.md · <context doc> · <MR doc> · <target-user doc> · <MVP-coreloop doc> [· brief.md]
> Số câu hỏi đã hỏi trong buổi grill: <n> (ngưỡng tối thiểu 12)

## 0. Persona concept đã chọn

- **Persona:** <trích từ Target User doc — ai, hồ sơ nghiệp vụ>
- **Khoảnh khắc:** <trích từ Context doc — timeline cụ thể, vd "tối muộn, xem lại tin nhắn tồn từ trưa">
- **Vì sao chọn concept này:** <1-2 câu — neo vào job ưu tiên CAO nhất>

## 1. Customer value cốt lõi

- **Một câu:** <core value — lý do sâu nhất khách mua, KHÔNG phải một feature>
- **Điều kiện "không làm được thì vứt":** <cái duy nhất; thiếu nó thì mọi giá trị khác không có cơ hội được nhìn thấy>
- **Evidence:** <must-cite/infer/assumption — kèm ID dossier nếu must-cite>
- **Đã ổn định qua ≥2 vòng thu hẹp:** <có/không — nếu không, giải thích vì sao vẫn ghi>

## 2. Giá trị của agent app (theo lớp)

| Lớp giá trị | Mô tả | Evidence |
|---|---|---|
| Chức năng (functional) | <...> | <must-cite/infer/assumption> |
| Kinh tế (economic) | <...> | <...> |
| Niềm tin (trust/emotional) | <...> | <...> |

## 3. Nỗi sợ (ranked, #1 = dealbreaker)

| # | Nỗi sợ | Vì sao (root cause) | Job/vấn đề gốc | Mức độ |
|---|---|---|---|---|
| 1 | <...> | <...> | J<#> | Dealbreaker |
| 2 | <...> | <...> | J<#> | Manageable |
| … | | | | |

## 4. Cơ hội

| Cơ hội | Vì sao đối thủ/workaround chưa lấp | Nguồn |
|---|---|---|
| <...> | <...> | <dossier §5 Substitute Map / Target-User đối thủ> |

## 5. Vấn đề (pain thực tế — phân biệt với nỗi sợ cảm nhận ở mục 3)

| Vấn đề | Job (J#) | Ưu tiên | Nguồn |
|---|---|---|---|
| <...> | J<#> | Cao/TB/Thấp | <...> |

## 6. Tính năng lớn — giải nỗi sợ

- <tên nhóm feature> → giải nỗi sợ #<n> — <lý do 1 câu>
- …

## 7. Tính năng lớn — deliver customer value

- <tên nhóm feature> → deliver customer value cốt lõi (mục 1) — <lý do 1 câu>
- …

## 8. Bảng chi tiết (feature-centric traceability)

| Feature | Giải nỗi sợ nào | Deliver value nào | Vấn đề/Job gốc | Ưu tiên | Evidence |
|---|---|---|---|---|---|
| <...> | <#n hoặc "—"> | <có/không> | J<#> | Must/Should | must-cite/infer/assumption |

## 9. Hành trình grill (tóm tắt hội tụ)

<Tóm tắt trung thực: bắt đầu từ đâu (draft đóng vai lớp 1), câu hỏi/câu trả lời nào làm đổi hướng, vì sao hội tụ về kết quả này — không chỉ chép lại kết luận cuối cùng.>

- **Điểm hội tụ customer value:** <câu hỏi/vòng nào làm nó ổn định>
- **Điểm hội tụ nỗi sợ #1:** <câu hỏi/vòng nào làm nó ổn định>

## 10. Related

- <link dossier, 4 doc, brief.md>
- Gợi ý dùng tiếp (không bắt buộc, không skill nào tự đọc file này): nỗi sợ ở mục 3 có thể tham khảo thủ công khi chạy `/usecase-factory:agent-domain-spec` (đầu vào cho guardrail/approval policy); customer value ở mục 1 có thể tham khảo khi chạy `/usecase-factory:grill-to-brief` (đầu vào cho purpose của từng màn).
