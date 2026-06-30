---
name: copy-writer
description: Viết và chuẩn hoá UX microcopy (page title/subtitle, empty state, tooltip, CTA, nút, thông báo) theo best practices. Mỗi câu giải quyết đồng thời 2 phía — ý định người dùng (họ vào đây để làm gì) và giá trị sản phẩm (ta cung cấp gì). Dùng khi user nói "viết subtitle", "viết microcopy", "viết copy cho trang/nút", "đặt tiêu đề trang", "viết UX copy", "chuẩn hoá subtitle", "/usecase-factory:copy-writer", hoặc khi tạo/sửa nội dung tiêu đề–phụ đề–CTA hiển thị cho end-user trên sản phẩm.
---

# Copy Writer — UX Microcopy

Skill viết **microcopy hiển thị trên sản phẩm** cho end-user: page title, subtitle, empty state, tooltip, nút, CTA, thông báo. Khác `viet-tai-lieu` (tài liệu dài) — đây là **câu ngắn, đứng trên UI**, mỗi chữ phải có lý do.

## Khi nào dùng

- "viết subtitle / microcopy / copy cho trang / nút / tooltip / empty state"
- "đặt tiêu đề trang", "viết UX copy", "chuẩn hoá lại subtitle các trang"
- Khi tạo/sửa nội dung text hiển thị cho người dùng cuối trên UI sản phẩm.

**Không dùng cho:** tài liệu/spec/PRD (→ `viet-tai-lieu`), commit message, code comment, log kỹ thuật.

## Nguyên tắc lõi: một câu, hai phía

Mỗi dòng microcopy phải trả lời **đồng thời** 2 câu hỏi, gộp vào **một câu**:

1. **Phía người dùng (intent)** — Họ vào trang/bấm nút này để làm gì? Muốn tìm gì? Giải quyết vấn đề gì?
2. **Phía sản phẩm (value)** — Ta cung cấp được gì ở đây? Năng lực thật là gì?

> Câu tốt = giao điểm của intent người dùng và value sản phẩm. Không phải mô tả tính năng (feature), mà là **kết quả người dùng đạt được** nhờ tính năng đó.

**Công thức gộp:** `[Động từ mạnh / hành động chủ động] + [Đối tượng cần thao tác] + [Kết quả / giá trị đạt được]`. Ví dụ: "Kết nối kênh bán để agent trả lời khách tự động."

### WHY / WHAT / HOW

- **WHY** (lý do trang tồn tại) — thường đã rõ từ tên trang. Không lặp lại tên trang.
- **WHAT** (người dùng đạt được gì) — đây là phần subtitle phải nói. Lợi ích/kết quả, không phải cơ chế.
- **HOW** (làm cách nào) — chỉ chạm tới nếu cần, ngắn. Không giải thích quy trình.

Microcopy yếu = chỉ lặp WHY hoặc liệt kê HOW. Microcopy tốt = nói WHAT theo ngôn ngữ người dùng.

## Độ dài: tuỳ loại microcopy, tuỳ tác vụ

Không có một độ dài đúng cho mọi chỗ. Độ dài do **loại microcopy** + **trạng thái người dùng lúc đó** quyết định — không phải sở thích.

**Câu hỏi lọc: người dùng đang LÀM hay đang HỌC?**
- **Đang làm** (điền form, quét danh sách, bấm nút, đọc dashboard) → càng ít chữ càng tốt. Chữ là vật cản giữa họ và việc.
- **Đang học** (lần đầu gặp tính năng, đi tour, đọc hướng dẫn) → cho phép dài hơn, vì họ cần ngữ cảnh để hiểu, không vội thao tác.

| Loại | Độ dài | Khi nào |
| --- | --- | --- |
| **Nhãn / cụm từ** (title, nút, chip, KPI, tab, menu) | 1–4 từ, **không phải câu**, không chấm câu | Mọi nhãn điều hướng/hành động |
| **Một câu** (subtitle, mô tả step onboarding, empty-state, tooltip, helper) | **Đúng 1 câu**, ≤ ~12–14 từ, nói WHAT, không vế tack-on, không "—" thừa | Mặc định cho hầu hết microcopy mô tả. Người dùng đang làm, chỉ cần 1 dòng định hướng |
| **Nhiều câu** (tour/tutorial, welcome, giải thích khái niệm lần đầu, lỗi kèm cách sửa) | 2–3 câu, mỗi câu một ý | Người dùng đang học/được dẫn dắt; cần ngữ cảnh + bước tiếp theo. Vẫn cắt chặt, không lặp |

**Quy tắc chốt:**
- **Mô tả step onboarding, subtitle trang, empty-state → một câu.** Một việc + một lợi ích, hết. Mọi vế giải thích thêm ("agent dùng tên này để…", "có thể đổi sau") là **dư** — cắt.
- **Tour/hướng dẫn → được nhiều câu**, nhưng câu 1 nói *trang này là gì / để làm gì*, câu 2 nói *cái cần để ý* (nhãn việc, thao tác chính). Không kể quy trình từng bước.
- Khi nghi ngờ: viết bản dài rồi cắt tới khi xoá thêm một chữ là mất nghĩa. Đó là độ dài đúng.

## Quy trình viết / chuẩn hoá 1 dòng

1. **Xác định người đọc + intent**: ai đang đọc dòng này (người mới hay người thạo việc?) và họ vào đây mong điều gì? Người mới cần nhiều ngữ cảnh, ít jargon; người thạo cần ngắn, được dùng thuật ngữ họ đã quen. (1 câu nội bộ, không hiển thị)
2. **Xác định value**: sản phẩm cho họ điều gì thật sự?
3. **Gộp thành 1 câu** lấy người dùng làm chủ ngữ ngầm hoặc động từ hành động dẫn đầu.
4. **Cắt**: bỏ từ thừa, bỏ tên trang lặp lại, bỏ thuật ngữ kỹ thuật trừ khi user buộc phải biết.
5. **Kiểm voice**: nhất quán với các dòng cùng nhóm (cùng cấu trúc, cùng độ dài, cùng ngôi).

## Best practices

- **Lấy người dùng làm trung tâm** — "Tìm agent phù hợp" hơn "Danh sách agent".
- **Lợi ích, không phải tính năng** — nói kết quả họ đạt được, không nói cơ chế bên trong. Đặc biệt với câu trạng-thái/xác-nhận ("đã xong X"): tả việc agent/hệ thống làm được cho người dùng, đừng tả đường ống kỹ thuật. ❌ "Tin nhắn Facebook và Zalo về chung một luồng" (cơ chế) → ✅ "Agent trực 24/7, tư vấn và chăm sóc khách trên cả hai kênh" (kết quả).
- **Động từ hành động / từ quan trọng lên đầu (front-load).** Khi hợp, dẫn câu bằng động từ: Tìm / Quản lý / Kết nối / Thêm / Theo dõi. Người dùng quét UI từ trái sang, và trên mobile phần đuôi câu hay bị cắt ("…") — ý chính phải nằm ở đầu, không phải cuối.
- **Nút / CTA = động từ mạnh + danh từ cụ thể.** Nói rõ điều gì sẽ xảy ra, không để nút mơ hồ. Đặc biệt ở dialog xác nhận hành động phá huỷ: ❌ "Xác nhận" / "OK" → ✅ "Xoá ảnh", "Huỷ đơn hàng". Một từ trần ("Lưu", "Đóng") chỉ đủ khi đối tượng đã hiển nhiên.
- **Không dùng emoji hoặc ký tự tự chế trong nhãn nút.** ❌ `💾 Lưu cài đặt`, ❌ `Tạm dừng toàn bộ II` -> ✅ `Lưu cài đặt`, `Tạm dừng toàn bộ` (biểu tượng lưu/pause phải là asset SVG chuyên nghiệp do UI hiển thị, không dùng text/emoji lồng vào nhãn).
- **Tránh trùng lặp trạng thái trực quan.** Nếu một thành phần UI đã tự thể hiện rõ trạng thái (như nút gạt Toggle Switch đang sáng màu đỏ/xanh biểu thị ON/OFF), tuyệt đối không đặt thêm một nhãn pill text ghi trạng thái `Bật (toàn bộ)` bên cạnh. Việc này làm rối mắt và dư thừa thông tin.
- **Không lười biếng dùng dấu gạch chéo mập mờ.** ❌ `Giọng / phong cách` -> ✅ `Phong cách phản hồi` hoặc `Giọng điệu`. Chọn một từ ngữ rõ nghĩa nhất, tránh bắt người dùng phải đoán ý nghĩa của hai từ ghép lại bởi dấu gạch chéo.
- **Một câu, một ý.** Subtitle ≤ ~10–12 từ. Không dấu chấm than. Không marketing rỗng ("tuyệt vời", "mạnh mẽ nhất").
- **Không lặp tên trang** trong subtitle.
- **Không dùng ký hiệu toán tử / icon-chữ trong câu chữ.** Viết bằng chữ, không dùng `≥ ≤ > < = +` hay icon-glyph (`+ Thêm`, `🔒`, `⏸`, `ⓘ`, `✓`) lồng vào nhãn. ❌ "nối ≥1 kênh" → ✅ "kết nối ít nhất 1 kênh"; ❌ "đọc + xử lý" → ✅ "đọc và xử lý"; ❌ "+ Thêm điều kiện" → ✅ "Thêm điều kiện". Biểu tượng (cộng/khoá/pause/info) phải là asset SVG do UI render, không phải ký tự trong chuỗi.
- **Cụ thể hơn chung chung** — "Lên lịch để agent tự chạy" hơn "Tự động hoá công việc".
- **Nhất quán theo nhóm** — các trang cùng chức năng dùng cùng khuôn câu.
- **Không jargon** trừ khi đối tượng là kỹ thuật.
- **Nhãn tích hợp / app bên thứ ba** (tile cổng thanh toán, CRM, kênh…) → mô tả app **làm gì cho người dùng**, 3–4 từ, **không phô giao thức** (OAuth, Client ID/Secret, Open API, REST, webhook). Ví dụ: ❌ "Web/POS/Omnichannel · Open API" → ✅ "Bán hàng đa kênh".
- **Card chỉ số / KPI không cần hint.** Một metric card đã có nhãn + con số + delta là tự đủ nghĩa — đừng thêm dòng phụ giải thích "chỉ số này nghĩa là gì". Nếu nhãn cần một câu mới hiểu thì sửa nhãn, đừng đắp hint. Hint chỉ dành cho nơi người dùng đang học (onboarding, tour), không phải nơi đang quét số (dashboard).
- **Đừng phơi jargon vòng đời / trạng thái nội bộ cho end-user.** Tên các bước trong state machine của sản phẩm ("Nháp → Chạy thử → Hoạt động", "draft/audit/live") là ngôn ngữ nội bộ — nhồi nó thành breadcrumb trang trí (kèm `→`/`·`/`|` làm separator) chỉ gây nhiễu, không nói người dùng cần làm gì. Cắt, hoặc thay bằng một dòng nói rõ trạng thái hiện tại + việc kế ("Đang xem thử, chưa gửi khách"). Trạng thái hiện tại đã có ở badge/màu/nút thì đừng lặp lại dưới dạng dải tiến trình.
- **Section header trong trang không cần mô tả.** Tiêu đề nhóm (h2 chia khối trong một trang: "Việc cần làm hôm nay", "Hiệu suất Agent"…) đứng một mình là đủ — đừng thêm dòng subtitle bên dưới. Subtitle chỉ thuộc về **page header** (tiêu đề toàn trang), không phải mọi section. Nội dung trong khối tự nói lên section là gì.
- **Dấu "—" (gạch ngang dài) = cờ đỏ khi audit.** Mỗi lần thấy "—" trong một dòng microcopy, **dừng lại kiểm tra ngay dòng đó** trước khi đi tiếp: gạch ngang gần như luôn nối thêm một vế phụ (giải thích, điều kiện, ví dụ) vào câu vốn đã đủ ý. Hỏi: vế sau "—" có thêm thông tin người dùng cần để hành động không? **Không** → cắt cả vế. **Có** → tách thành câu riêng (subtitle/empty-state) hoặc viết lại cho liền mạch. Ngoại lệ hợp lệ: dải khoảng/giá dùng gạch nối ngắn "–" ("2–3 ngày", "8h–21h") — không phải vế tack-on.

## Dấu câu & viết hoa (áp dụng nhất quán, cho cả VI/EN)

**Dấu chấm cuối:**
- **Không chấm:** nhãn, nút, chip, tab, KPI, tiêu đề trang, tooltip chỉ gồm cụm từ ngắn (không phải câu).
- **Có chấm:** subtitle là một câu hoàn chỉnh, empty-state, helper, hướng dẫn nhiều câu. Mỗi câu một dấu chấm. Không dấu chấm than.

**Viết hoa — dùng Sentence case cho cả tiếng Việt lẫn tiếng Anh:** chỉ hoa chữ cái đầu câu/nhãn (+ tên riêng), phần còn lại thường. Gọn, hiện đại, dễ đọc.
- ❌ Title Case kiểu Anh: "Quản Lý Agent", "Find Your Agent" → ✅ "Quản lý agent", "Find your agent".
- Brand/tên riêng giữ nguyên cách viết gốc (xem mục bám sản phẩm).

## Thông báo lỗi

Lỗi là điểm chạm nhạy cảm — người dùng đang bực, copy phải gỡ chứ không làm nặng thêm. Một thông báo lỗi tốt trả lời đủ 3 ý, gọn:

1. **Chuyện gì xảy ra** — nói thẳng, không kỹ thuật ("Không gửi được tin nhắn").
2. **Vì sao / ở đâu** — chỉ đúng chỗ cần sửa nếu xác định được ("Số điện thoại thiếu mã vùng").
3. **Làm gì tiếp** — hướng khắc phục hoặc nút thử lại.

- **Không đổ lỗi người dùng.** ❌ "Bạn nhập sai định dạng" → ✅ "Email cần có dạng ten@vidu.com". Lấy hệ thống/đối tượng làm chủ ngữ, không phán xét người dùng.
- **Không phô lỗi kỹ thuật** (mã 500, stack trace, "null") cho end-user — chuyển thành điều họ làm được.
- Giữ register chuyên nghiệp-nhẹ; không "Rất tiếc!!!", không dấu chấm than.

## Register tiếng Việt: chuyên nghiệp-nhẹ

Microcopy tiếng Việt phải tự nhiên **nhưng vẫn chỉn chu** — không cứng/dịch sát, cũng không khẩu ngữ chợ búa. Ngưỡng đúng nằm giữa hai cực.

- **Tránh từ khẩu ngữ (nghe "chợ") / thiếu chỉn chu:** biến (X thành Y), mớ (việc/to-do), gom, bung (ý tưởng), dọn (danh sách), soi (góc nhìn), im (đang im, im lặng).
- **Tránh các từ ngữ hội thoại thông thường hoặc trò chơi:** ❌ `nhường bạn`, `nhường khách` -> ✅ `bàn giao`, `chuyển tiếp`, `chuyển cuộc trò chuyện`.
- **Không viết tắt động từ thành cụm cụt khẩu ngữ.** Cụm động từ–tân ngữ bị cắt nghe như nhắn vội, mất chỉn chu — viết đủ. ❌ `trả tin` (khách) → ✅ `Trả lời` (hoặc `Trả lời tin nhắn`); ❌ `Nối` (Facebook/kênh) → ✅ `Kết nối`; ❌ `chốt đơn nhanh` kiểu nói tắt → viết rõ hành động. Mẹo: nếu cụm chỉ "đọc trôi" khi nói miệng mà nhìn trên UI thấy cụt, đó là viết tắt — viết đủ động từ chuẩn.
- **Tuyệt đối tránh cấu trúc lười giải thích bắt người dùng tự suy luận.** ❌ `... và ngược lại.` -> ✅ Hãy diễn đạt tường minh toàn bộ khả năng hoặc hành động mà người dùng có thể thực hiện (Ví dụ: *"Bạn vẫn có thể cài đặt tự động trả lời cho từng hội thoại riêng lẻ."* thay vì *"Tắt toàn bộ vẫn bật được riêng một hội thoại, và ngược lại."*).
- **Tránh từ dịch sát/cứng:** chữa (lỗi → dùng *sửa*), tông (→ *giọng*), điểm chính (→ *ý chính*).
- **Ưu tiên động từ trung tính, sạch:** Sắp xếp, Tổng hợp, Chuyển, Rút gọn, Cô đọng, So sánh, Đề xuất, Viết, Sửa, Lập.
- **Chủ động hoá, bỏ thể bị động "được/bị" thừa.** Microcopy Việt hay dính cấu trúc dịch từ Anh ("đã được", "bị"). Cắt đi, lấy hành động/kết quả làm chủ.
  - ❌ "Tài khoản của bạn đã được kích hoạt thành công" → ✅ "Kích hoạt tài khoản thành công".
- **Bỏ chủ ngữ chỉ người dùng — đừng ép đại từ (chị / anh / bạn).** Trên UI, gắn đại từ ngôi-người-dùng vào mỗi dòng là over-specify: vừa thừa chữ, vừa đoán sai (giới tính/vai) khi tệp người dùng đa dạng. Dẫn câu bằng động từ hoặc tác nhân thật (agent / khách / hệ thống), để chủ ngữ "bạn" ngầm.
  - ❌ "Agent trả lời thay chị" → ✅ "Agent tự trả lời"; ❌ "cần chị xem lại" → ✅ "cần xem lại"; ❌ "giảm việc cho chị" → ✅ "giảm việc thủ công".
  - Chỉ giữ đại từ khi BỎ đi gây mơ hồ thật sự (vd phân biệt "tin khách gửi" vs "tin bạn gửi"). Khi buộc phải có, dùng "bạn" trung tính — không "chị/anh" (định giới).
  - **Văn nói/thoại của chính agent là ngoại lệ** — chat bubble agent nói với khách giữ xưng hô tự nhiên ("Dạ chị…"); quy tắc này chỉ áp cho chrome/nhãn/subtitle/KPI của dashboard.
- **Lược "các / những" khi ngữ cảnh đã rõ số nhiều.** Danh từ trần đủ nghĩa, không cần đánh dấu số nhiều như tiếng Anh.
  - ❌ "Quản lý các agent của bạn" → ✅ "Quản lý agent của bạn".
- **Cách kiểm:** đọc to lên. Nghe như nói chuyện ngoài chợ → đổi động từ. Nghe như Google Translate → viết lại cho thuần Việt.

> Ví dụ: ❌ "Biến mớ việc lộn xộn thành kế hoạch" / ❌ "Chữa lỗi văn bản" → ✅ "Sắp xếp việc cần làm thành kế hoạch ngày rõ ràng" / ✅ "Sửa lỗi chính tả, ngữ pháp".

Lưu ý: **prompt mẫu** (câu user tự gõ) được phép giọng thoải mái hơn subtitle, nhưng vẫn tránh nhóm từ "chợ" để đồng bộ voice.

## Bám sản phẩm có sẵn (dynamic — đừng hardcode)

Khi viết/chuẩn hoá copy **trong một sản phẩm đã có code**, đừng phát minh từ mới: đi tìm convention đang có rồi bám + đồng bộ theo. Mỗi lần làm phải tự suy ra từ codebase hiện tại — không tin một glossary cũ vì sản phẩm luôn đổi.

1. **Quét trước khi viết.** `grep` codebase xem cùng một thứ đang được gọi những kiểu nào (nhãn thực thể, CTA, cách gọi nhân vật). Nếu một thứ có ≥2 tên → đó là nợ cần đồng bộ, không phải tự do sáng tác.
2. **Một thực thể = một tên, song song khắp màn.** Chọn một khuôn rồi áp mọi nơi nó xuất hiện (vd cùng dạng `"[Đối tượng] cần [hành động]"`). Người dùng đi giữa các màn không được thấy cùng một việc mang 3 tên.
3. **Phân biệt 2 lớp — đừng đồng bộ nhầm:**
   - **Nhãn việc / tin báo** = call-to-action → dùng thể "cần…" ("Đơn cần duyệt").
   - **Trạng thái** (status pill, chip) = mô tả tình trạng → thể "chờ…/đang…" ("Đang chờ duyệt"). Hai lớp này được phép khác chữ; gộp làm một là sai.
4. **Tên cơ chế ≠ nhãn hành động.** Một tính năng có thể có tên nội bộ (vd "bàn giao") dùng ở trang cấu hình, nhưng nhãn việc cho người dùng nói theo kết quả ("Hội thoại cần người"). Giữ cả hai, đúng ngữ cảnh.
5. **Dựng "dàn nhân vật" của sản phẩm.** Xác định rõ: ai là người dùng (chủ thể "bạn"), ai là tác nhân (agent/bot), ai là bên thứ ba (khách). Cố định đại từ + register cho từng vai và giữ nhất quán. Không gọi tác nhân bằng đại từ xuồng xã ("nó") — gọi bằng tên hoặc "agent".
6. **Tên riêng sản phẩm/brand giữ nguyên** kể cả khi lệch ngôn ngữ (vd một tính năng AI có tên tiếng Anh giữa UI Việt). Đây là quyết định đặt tên — hỏi chủ sản phẩm trước khi Việt hoá, đừng tự đổi.

> **Glossary cụ thể của từng dự án sống ở project memory / CLAUDE.md, không nằm trong skill này.** Trước khi chuẩn hoá, đọc memory dự án để lấy bộ tên + dàn nhân vật đã chốt; nếu chưa có thì suy ra từ codebase rồi đề xuất lưu lại.

## Song ngữ (nếu cần VI / EN)

- Dịch theo **nghĩa và ý định**, không dịch từng chữ.
- Giữ **song song cấu trúc**: cả 2 ngôn ngữ cùng dạng (cùng mở đầu bằng động từ, cùng độ dài tương đối).
- EN dùng giọng sản phẩm chuẩn: ngắn, động từ mệnh lệnh ("Find…", "Manage…", "Connect…"), "your" cho sở hữu người dùng.

## Định dạng đầu ra

Khi chuẩn hoá nhiều dòng (vd subtitle nhiều trang), trả về **bảng** để quản lý:

| Trang/Vị trí | Title | Subtitle (VI) | Subtitle (EN) |
| --- | --- | --- | --- |

Khi viết 1 dòng lẻ: đưa câu chốt + (nếu hữu ích) 1–2 phương án thay thế ngắn để chọn.

## Checklist trước khi chốt

- [ ] Câu trả lời được "người dùng đạt gì ở đây?" (WHAT), không chỉ lặp tên trang (WHY).
- [ ] Có cả intent người dùng lẫn value sản phẩm.
- [ ] Đúng độ dài theo loại: nhãn = cụm từ; subtitle/mô tả step/empty-state = **1 câu** (không vế tack-on, không "—" thừa); tour/hướng dẫn = được 2–3 câu.
- [ ] Không thừa chữ, không jargon, không lặp tên trang.
- [ ] Nhất quán voice với các dòng cùng nhóm.
- [ ] Không trùng lặp trạng thái trực quan (như hiển thị text trạng thái sát cạnh nút gạt Toggle Switch đã rõ trạng thái).
- [ ] Không sử dụng nhãn mập mờ chứa dấu gạch chéo `/`. Nhãn nút không sử dụng emoji hoặc ký tự văn bản tự chế làm icon.
- [ ] (Dự án có sẵn) Đã grep codebase, bám bộ tên đang dùng; một thực thể chỉ một tên xuyên màn; không lẫn nhãn việc ("cần…") với trạng thái ("chờ…"); không gọi agent là "nó".
- [ ] (Tiếng Việt) Đọc to nghe tự nhiên-chỉn chu — không từ "chợ" (biến/mớ/gom/bung/dọn/im), không dịch sát (chữa/tông); câu chủ động, không "đã được/bị" thừa, không "các/những" thừa.
- [ ] (Tiếng Việt) Không viết tắt động từ thành cụm cụt khẩu ngữ — "trả tin" → "Trả lời"; viết đủ cụm động từ–tân ngữ.
- [ ] Quét dấu "—": mỗi dòng có gạch ngang dài phải kiểm lại ngay — cắt vế tack-on hoặc tách câu. Chỉ chừa gạch nối dải "–" (2–3 ngày).
- [ ] Không phơi jargon vòng đời/trạng thái nội bộ ("Nháp → Chạy thử → Hoạt động", draft/audit/live) dạng breadcrumb trang trí cho end-user; không dùng `→`/`·`/`|` làm separator tiến trình. Trạng thái đã có ở badge/nút thì không lặp.
- [ ] (Tiếng Việt) Không sử dụng cụm từ lười biếng bắt suy luận ngược như "và ngược lại". Giải thích thẳng khả năng và giới hạn thực tế.
- [ ] (Tiếng Việt) Tránh các từ ngữ giao tiếp thông thường kiểu trò chơi ("nhường bạn", "nhường khách"). Dùng từ ngữ sản phẩm chuẩn mực như "bàn giao", "chuyển tiếp".
- [ ] (Tiếng Việt) Không ép chủ ngữ ngôi-người-dùng (chị/anh/bạn) vào chrome/nhãn/subtitle/KPI — dẫn bằng động từ, để "bạn" ngầm; chỉ giữ khi bỏ đi gây mơ hồ, và dùng "bạn" trung tính. Ngoại lệ: lời thoại agent nói với khách.
- [ ] Dấu câu đúng: nhãn/nút/title không chấm; subtitle/empty-state một câu có chấm; không dấu chấm than.
- [ ] Viết hoa Sentence case (VI lẫn EN), chỉ hoa đầu câu + tên riêng.
- [ ] Ý chính/động từ nằm đầu câu (front-load), chịu được cắt đuôi trên mobile.
- [ ] (Nút/CTA) Động từ mạnh + danh từ cụ thể, nói rõ điều sẽ xảy ra — không "Xác nhận/OK" mơ hồ ở hành động phá huỷ.
- [ ] (Thông báo lỗi) Đủ chuyện gì / vì sao / làm gì tiếp; không đổ lỗi người dùng; không phô lỗi kỹ thuật.
- [ ] (Song ngữ) VI/EN song song cấu trúc, dịch theo ý.