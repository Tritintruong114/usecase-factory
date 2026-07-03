// SCAFFOLD — copy to new-design/src/workspaces/<ws>/fixtures.js and fill from
// mockups.data.js. Data layer: the two demo record-sets the dashboard reads,
// PLUS the live-state helpers that make the prototype manipulable.
//
// Copy mirrors the wireframe — do NOT invent new product copy here.

export const EMPTY = {
  live: false,
  // baseline connections / counts the seed reads:
  channels: { fb: { connected: false }, zalo: { connected: false } },
  kpi: { ordersClosed: '0', closeRate: '0%', orders: '0', volume: 'FB 0 · Zalo 0' },
  actionQueue: [],
  conversations: [],
};

export const SAMPLE = {
  live: true,
  period: { range: '08/06–14/06', prevRange: '01/06–07/06' },
  channels: { fb: { connected: false }, zalo: { connected: true, oa: '<OA name>' } },
  kpi: { ordersClosed: '57', ordersClosedDelta: '▴8', closeRate: '38%', orders: '57/142' },
  pulse: '🤖 …',
  actionQueue: [/* { id, icon, label, cta, to } */],
  conversations: [/* { id, channel, name, … , bubbles:[…] } */],
};

export const FIXTURES = { empty: EMPTY, sample: SAMPLE };

// --- Live, manipulable onboarding state -----------------------------------
// THE point of the prototype. Seed the live state from the demo mode, then let
// user actions (connect a channel, add a product) override it. The dashboard
// derives the UI (checklist, banners) from this — so any action flips a step.

export function seedSetup(mode) {
  const f = FIXTURES[mode];
  return {
    fb: { connected: f.channels.fb.connected },
    zalo: f.channels.zalo.connected ? { connected: true, oa: f.channels.zalo.oa } : { connected: false },
    products: mode === 'sample' ? 12 : 0,
  };
}

// Derive the onboarding checklist from live state — labels + done flags are
// computed, never hardcoded, so connecting/adding flips the matching step.
export function buildChecklist(setup) {
  const chans = [setup.zalo.connected && 'Zalo', setup.fb.connected && 'Facebook'].filter(Boolean);
  const channelDone = chans.length > 0;
  const prodDone = setup.products > 0;
  return [
    { id: 'connect', req: true, done: channelDone, cta: channelDone ? 'Quản lý ▸' : 'Kết nối ▸',
      label: channelDone ? `Đã kết nối ${chans.join(' + ')}` : 'Kết nối Facebook / Zalo' },
    { id: 'import', req: true, done: prodDone, cta: prodDone ? 'Thêm nữa ▸' : 'Thêm ▸',
      label: prodDone ? `Đã thêm ${setup.products} sản phẩm` : 'Thêm sản phẩm' },
    // optional steps stay false (their own UI / out of pilot scope)
  ];
}
