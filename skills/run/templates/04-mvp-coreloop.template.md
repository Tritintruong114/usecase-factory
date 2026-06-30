---
title: MVP & Core Loop — <Tên use-case>
type: mvp-coreloop
tags: [mvp, core-loop, scope, <domain>]
categories: [Index]
date: <YYYY-MM-DD>
status: draft
---

<!--
INPUT #4 của /usecase-factory:grill-to-brief — "MVP & Core Loop".
Mục đích: khoá SCOPE v0 + VÒNG LẶP GIÁ TRỊ. Là spine để grill vẽ cut line + biết màn nào gánh "pull" của loop.
NẾU đã có brief.md: core loop + cut line LẤY TỪ ĐÓ, doc này chỉ nở ra — không tự chế lại.
File đặt tại doc/ws-<slug>/MVP-Coreloop.md
-->

# MVP & Core Loop — <Tên use-case>

> Input #4 của `/usecase-factory:grill-to-brief` (cùng bộ với Context · MR · Target-User).
> Khoá **scope v0** + **core loop**; màn nằm trên loop = non-negotiable v0.

## 1. Tóm tắt scope một câu

<Một câu: v0 ship trọn cái gì + KHÔNG ship cái gì.>

## 2. Core loop (vòng lặp giá trị)

<!-- Vòng lặp đóng: trigger → action → payoff → return. 3-5 bước, kèm "lực kéo" (pull) khiến user quay lại.
     Đây là backbone — UI/noti chỉ dẫn xuất. -->

```
<Bước 1> → <Bước 2> → <Bước 3> → <Bước 4> → ↺

  1. <Bước 1> (trigger + action)   <user làm gì / sản phẩm làm gì>
  2. <Bước 2> (action + payoff)    <...>
  3. <Bước 3> (action)             <...>
  4. <Bước 4> (payoff + return)    <... → quay lại bước 1>

  Lực kéo quay lại (pull):  <điều khiến user mở lại sản phẩm>
```

<!-- Nếu sản phẩm có nhiều lớp loop lồng nhau (runtime / mặt-khách / mặt-vận-hành), liệt kê bảng ngắn. Bỏ nếu chỉ 1 lớp. -->

## 3. Phạm vi MVP

<!-- Tách HÀNH VI NỀN (không phải màn) khỏi MÀN. Grill chỉ vẽ màn; hành vi nền là context. -->

### A. Hành vi (chạy nền — KHÔNG phải màn)

| # | Hành vi | Chốt |
|---|---|---|
| A1 | <hành vi> | <quyết định> |
| A2 | <hành vi> | <quyết định> |

### B. Màn v0

| Màn | Vai trò trong loop |
|---|---|
| <S1> | <bước loop / cổng setup nó phục vụ> |
| <S2> | <...> |

## 4. Cổng / điều kiện kích hoạt (nếu có)

<!-- Nếu sản phẩm có "gate" trước khi chạy thật (kiểm thử, onboarding bắt buộc, trạng thái nháp→chạy) — mô tả ở đây.
     Bỏ section nếu không có. -->

| Trạng thái | Hệ thống làm gì |
|---|---|
| <Nháp> | <...> |
| <Sẵn sàng> | <...> |
| <Đang chạy> | <...> |

**Sàn tối thiểu để bật:** <điều kiện thấp nhất, KHÔNG đòi full setup>.

## 5. Ngoài phạm vi MVP (defer)

- **Màn riêng:** <...>
- **Trong màn:** <...>
- **Hành vi:** <...>

## 6. Màn gánh "lực kéo" của loop (non-negotiable v0)

- **Trên loop (bắt buộc):** <các màn map vào bước loop §2>
- **Điều kiện bật loop (bắt buộc):** <các màn setup>
- **Đường cắt:** mọi thứ ở §5 nằm ngoài v0. Màn mới grill đề xuất phải trace về một bước loop §2 hoặc một cổng §4, không thì cắt.

## 7. Related

- [[Boi-Canh-Va-Van-De]] · [[MR-<slug>-Problem-Solution]] · [[Target-User-<slug>]]
- [[brief.md]] (nếu có — source of truth cho core loop + scope)
</content>
