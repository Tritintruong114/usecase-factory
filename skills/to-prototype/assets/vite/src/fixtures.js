// Replace/adapt from mockups.data.js. Keep records here; keep static UI strings in copy.js.
export const EMPTY = {
  connected: false,
  products: 0,
  approved: 0,
  live: false,
  conversations: [],
};

export const SAMPLE = {
  connected: true,
  products: 12,
  approved: 3,
  live: true,
  conversations: [
    { id: 'c1', name: 'Minh Anh', channel: 'Facebook', intent: 'Hỏi giá gói học', status: 'cần duyệt', value: '1.200.000đ' },
    { id: 'c2', name: 'Quốc Bảo', channel: 'Zalo', intent: 'Muốn đặt lịch tư vấn', status: 'đang chốt', value: '890.000đ' },
  ],
};

export const FIXTURES = { empty: EMPTY, sample: SAMPLE };

export function seedState(mode) {
  const f = FIXTURES[mode];
  return typeof structuredClone === 'function' ? structuredClone(f) : JSON.parse(JSON.stringify(f));
}

export function buildChecklist(state) {
  return [
    { id: 'connected', label: state.connected ? 'Đã kết nối kênh bán hàng' : 'Kết nối Facebook/Zalo', done: state.connected, required: true },
    { id: 'products', label: state.products > 0 ? `Đã thêm ${state.products} sản phẩm` : 'Thêm sản phẩm/dịch vụ', done: state.products > 0, required: true },
    { id: 'approved', label: state.approved > 0 ? `Đã duyệt ${state.approved} câu trả lời mẫu` : 'Duyệt câu trả lời mẫu', done: state.approved > 0, required: false },
  ];
}

export function buildMetrics(state) {
  return [
    { label: 'Kênh đã nối', value: state.connected ? '1' : '0' },
    { label: 'Sản phẩm', value: String(state.products) },
    { label: 'Draft đã duyệt', value: String(state.approved) },
    { label: 'Agent', value: state.live ? 'Đang trực' : 'Đang nghỉ' },
  ];
}
