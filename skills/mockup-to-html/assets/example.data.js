/* SCHEMA EXAMPLE — copy to doc/ws-<name>/mockups.data.js and replace content.
   One global object. Each screen's `html` value is an HTML string built from the
   engine's primitives (.card .btn .pill .kpi .conv .modalbox .togglebox table …).
   Use template literals (backticks) so multi-line HTML stays readable. Labels =
   the wireframe's i18n strings — do NOT invent new product copy. */
window.WIREFRAME = {
  meta: {
    title: "Tên use-case",
    subtitle: "ws-<name> · wireframe",
    source: "doc/ws-<name>/mockups.md",
    styleRef: "new-design/",
    avatar: "🏪",
    runSwitch: true,          // drop (or false) if no live/rest concept
    restLabel: "⏸ Nghỉ", runLabel: "▶ Trực", goLiveLabel: "Lên sóng ▸",
  },

  // top-level screen groups (top tabs) — order = tab order, first is active
  tabs: [
    { id: "overview", label: "▣ Tổng quan" },
    { id: "conv",     label: "Hội thoại" },
  ],

  // per-tab: states (the .stateswitch) + the HTML for each state.
  // EVERY state/modal/empty/done in mockups.md must appear here.
  screens: {
    overview: {
      states: [
        { id: "ov1", label: "S1 · First-run" },
        { id: "ov2", label: "S2 · Đã lên sóng" },
      ],
      html: {
        ov1: `
          <div class="grid2">
            <div class="card">
              <h3>🚀 Bắt đầu nhanh</h3>
              <div class="small muted">Hoàn tất 2 bước để lên sóng · 0/4</div>
              <div class="progbar"><i style="width:0%"></i></div>
              <div class="step"><span class="mk">✗</span><span class="lb"><span class="req">*</span> Kết nối kênh</span><button class="btn pri">Kết nối ▸</button></div>
              <div class="step"><span class="mk">✗</span><span class="lb"><span class="req">*</span> Nhập sản phẩm</span><button class="btn pri">Nhập ▸</button></div>
              <div class="gap"></div>
              <div class="locked">🔒 Lên sóng — cần: Kết nối + Nhập SP</div>
            </div>
            <div class="card">
              <h3>📊 Số liệu (xem trước)</h3>
              <div class="preview-note">░ Agent đang Nghỉ — số liệu = 0.</div>
              <div class="gridkpi">
                <div class="kpi dim"><div class="lab">Tỉ lệ chốt</div><div class="val">0%</div></div>
                <div class="kpi dim"><div class="lab">Ca chờ coach</div><div class="val">0</div></div>
              </div>
            </div>
          </div>`,
        ov2: `
          <div class="card" style="margin-bottom:12px"><div class="between"><div>✓ <b>Đã lên sóng</b> · 5/5</div><button class="btn">Chi tiết ▾</button></div></div>
          <div class="card">
            <h3>💰 Đơn &amp; chốt</h3>
            <div class="grid3">
              <div class="kpi"><div class="lab">Đơn chốt</div><div class="val">57 <span class="up">▴8</span></div></div>
              <div class="kpi"><div class="lab">Tỉ lệ chốt</div><div class="val">38% <span class="up">▴4</span></div></div>
              <div class="kpi"><div class="lab">DM → chốt</div><div class="val">142→57</div></div>
            </div>
          </div>`,
      },
    },

    conv: {
      states: [
        { id: "cv1", label: "S1 · Trống" },
        { id: "cv2", label: "S2 · Master-detail" },
      ],
      html: {
        cv1: `
          <div class="conv">
            <div class="list"><div class="lhead"><input class="selbox" placeholder="🔍 tìm…"></div>
              <div class="empty small">(trống)</div></div>
            <div class="detail"><div class="empty"><div class="big">💬</div><b>Chưa có hội thoại</b>
              <div class="muted small">Khách nhắn FB/Zalo hiện ở đây.</div></div></div>
          </div>`,
        cv2: `
          <div class="conv">
            <div class="list">
              <div class="convitem sel"><div class="row"><span class="badge bd-fb">FB</span><b>Mai Anh</b></div>
                <div class="q">"Áo còn M ko?"</div><div><span class="pill p-ok">chốt</span></div></div>
              <div class="convitem"><div class="row"><span class="badge bd-za">Za</span><b>Tuấn Hùng</b></div>
                <div><span class="pill p-warn">thương lượng</span></div></div>
            </div>
            <div class="detail">
              <div class="between"><div><b>Mai Anh</b> · <span class="badge bd-fb">FB</span></div><span class="pill p-ok">● đang chốt</span></div>
              <div class="bubbles">
                <div class="bub cust">Áo còn size M ko?</div>
                <div class="bub agent">Dạ còn ạ 🥰</div>
              </div>
              <div class="row"><button class="btn pri">🛒 Agent lên đơn</button><button class="btn">🧪 Chat thử</button></div>
            </div>
          </div>`,
      },
    },
  },
};
