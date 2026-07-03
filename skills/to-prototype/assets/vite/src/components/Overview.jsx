import { COPY } from '../copy.js';
import { buildChecklist, buildMetrics } from '../fixtures.js';
import { Button, Card, Pill } from './bits.jsx';

export default function Overview({ state, setState, onSandbox }) {
  const checklist = buildChecklist(state);
  const metrics = buildMetrics(state);
  const ready = checklist.filter((x) => x.required).every((x) => x.done);

  return (
    <div className="grid">
      <Card className="hero-card">
        <div>
          <p className="eyebrow">{ready ? 'Sẵn sàng chạy thử' : 'Cần hoàn tất thiết lập'}</p>
          <h2>{ready ? 'Agent đã đủ điều kiện để trực thử' : 'Biến mockup thành workflow thao tác được'}</h2>
          <p className="muted">Các nút bên dưới thay đổi state thật để kiểm tra flow, không gọi backend.</p>
        </div>
        <div className="hero-actions">
          <Button variant="primary" onClick={() => setState((s) => ({ ...s, connected: true }))}>{COPY.actions.connect}</Button>
          <Button onClick={() => setState((s) => ({ ...s, products: s.products + 6 }))}>{COPY.actions.addProduct}</Button>
          <Button onClick={() => setState((s) => ({ ...s, approved: s.approved + 1 }))}>{COPY.actions.approve}</Button>
        </div>
      </Card>

      <div className="metrics">
        {metrics.map((m) => <Card key={m.label}><span className="metric-label">{m.label}</span><strong>{m.value}</strong></Card>)}
      </div>

      <Card>
        <h3>Checklist</h3>
        <div className="checklist">
          {checklist.map((item) => <div key={item.id} className="check-row"><span>{item.done ? '✓' : '○'}</span><span>{item.label}</span>{item.required && <Pill tone="accent">bắt buộc</Pill>}</div>)}
        </div>
      </Card>

      <Card>
        <h3>Hàng đợi hội thoại</h3>
        {state.conversations.length === 0 ? <p className="muted">Chưa có hội thoại demo. Bật “Có dữ liệu” hoặc thêm dữ liệu từ mockups.data.js.</p> : (
          <div className="rows">
            {state.conversations.map((c) => <div key={c.id} className="row"><div><b>{c.name}</b><p>{c.channel} · {c.intent}</p></div><Pill tone="green">{c.status}</Pill><b>{c.value}</b></div>)}
          </div>
        )}
        <div className="footer-actions"><Button onClick={onSandbox}>{COPY.actions.test}</Button><Button variant={state.live ? 'secondary' : 'primary'} onClick={() => setState((s) => ({ ...s, live: !s.live }))}>{state.live ? COPY.actions.pause : COPY.actions.goLive}</Button></div>
      </Card>
    </div>
  );
}
