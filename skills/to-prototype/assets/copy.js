// SCAFFOLD — copy to new-design/src/workspaces/<ws>/copy.js and fill from the
// wireframe. Content layer: every static UI string lives here so wording is
// edited in ONE place (mirrors the mockups.data.js content/engine split).
// Components import { COPY }; interpolated strings are functions.
//
// Data-bound copy (list rows, KPI numbers, pulse, status-enum keys) does NOT go
// here — it lives with its records in fixtures.js / bits.jsx.

export const COPY = {
  header: {
    emoji: '🏪',
    title: '<Workspace title>',
    subtitle: '<one-line subtitle>',
    runOn: '▶ Đang trực',
    runOff: '⏸ Đang nghỉ',
    runTip: 'Bật/tắt nhân viên trực',
  },

  tabs: {
    // one key per tab id used in index.jsx TABS
    overview: 'Tổng quan',
    // …
    soon: 'soon',
    soonTip: 'Ngoài phạm vi pilot',
  },

  demo: { label: 'Dữ liệu demo', empty: 'Trống', sample: 'Có dữ liệu' },

  // every toast string the prototype fires
  toast: {
    goLiveOn: '…',
    goLiveOff: '…',
    open: (x) => 'Mở ' + x,
  },

  // global "test the agent" sandbox modal
  sandbox: {
    title: '🧪 Chat thử',
    seed: [{ who: 'cust', text: '…' }, { who: 'agent', text: '…' }],
    reply: '…',
    placeholder: '…',
    send: 'Gửi',
    note: 'Sandbox — không gửi ra khách thật.',
  },

  // per-tab groups — one object per hero tab, interpolated strings as functions
  overview: {
    titleReady: '…',
    titleStart: '…',
    subReady: (n) => `Đã xong ${n}/4 (đủ phần bắt buộc)`,
    subStart: (n) => `… · Đã xong ${n}/4`,
    // …
  },
};

export default COPY;
