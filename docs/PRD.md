# PDF Financials Tracker (Cloudflare) — PRD (MVP)

## 0) Product thesis (1 dòng)
- Biến PDF báo cáo tài chính → dữ liệu chuẩn hóa → dashboard YoY/QoQ, để theo dõi doanh nghiệp nhanh và ra quyết định đầu tư dựa trên thay đổi.

## 1) Target persona
- Long-term stock investor (1–50 mã theo dõi), cần đọc BCTC nhanh, so sánh theo quý/năm, lưu lịch sử và “audit trail”.

## 2) Jobs-to-be-done (JTBD)
- Import PDF BCTC (quý/năm) theo công ty.
- Extract bảng số → chuẩn hóa metric (IS/BS/CF + ratios cơ bản).
- Lưu theo Company + Period (YYYY-Qn / FY).
- Xem YoY/QoQ deltas & trend.
- (Sau) Flag insights quan trọng bằng rules.

## 3) Top use cases (MVP)
1) Upload PDF → lưu trữ → tạo Import Run.
2) Agent extract dữ liệu (text-table v0) → user review/edit → commit.
3) Dashboard: YoY/QoQ bảng + chart (v1: bảng là đủ).
4) Xem lịch sử import + versioning + ai commit.
5) Export data (CSV/JSON) cho tự phân tích.

## 4) Success metrics (MVP, có số)
- Tạo được timeline cho 1 công ty: ≥ 8 kỳ (2 năm theo quý) trong ≤ 30 phút thao tác tổng.
- % import thành công (có commit được): ≥ 80% với PDF text-selectable.
- Thời gian upload → dashboard usable: p50 ≤ 3 phút (text mode).
- Data duplication = 0 khi import lại cùng file (idempotent).
- 0 lỗi dữ liệu “âm/dương sai quy ước” trên 20 metric trọng yếu (do validation).

## 5) Non-goals (v1)
- Không lấy giá thị trường realtime.
- Không tích hợp broker.
- Không ML phức tạp; insights chỉ rules-based sau MVP.
- Không auto-map 100% line items ngay; cho phép user map/edit.

## 6) Constraints & NFRs
- Deploy Cloudflare: Pages + Workers + D1 + R2 (+ Queues nếu async).
- Multi-company, multi-report timeline.
- Auditability: ai import/commit, từ file nào, version nào.
- Data correctness > fancy UI.
- Auth tối giản (email magic link hoặc passwordless) hoặc “single user mode” cho MVP.

## 7) Key decisions (phải chốt sớm)
- Canonical taxonomy metric v1: chọn ~30–60 metric lõi (IS/BS/CF).
- Period normalization: YYYY-Qn + FY; fiscal year khác calendar xử lý thế nào.
- Extraction v0 chỉ support text PDFs; OCR để milestone sau.
