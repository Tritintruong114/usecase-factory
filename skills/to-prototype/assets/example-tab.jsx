// SCAFFOLD — the canonical hero tab. Clone per wired tab. Demonstrates the three
// things that make this a PROTOTYPE, not a static viewer:
//   1. reads lifted state (checklist/setup) via props — never its own copy
//   2. DERIVES the UI from state (ready, missing) — no hardcoded done flags
//   3. MORPHS between wireframe states (ov1 ↔ ov2) by `ready`, reachable by action
// All copy comes from COPY; all data from the `data`/`setup` props.

import React from 'react';
import { Card, Btn, ProgressBar, useToast } from '../../ui';
import { Muted, H3 } from './bits';
import { COPY } from './copy';

const C = COPY.overview;

export default function ExampleTab({ data, mode, go, onTestChat, checklist, setup, onAddProduct, onGoLive }) {
  const toast = useToast();
  const doneCount = checklist.filter((s) => s.done).length;
  const ready = checklist.filter((s) => s.req).every((s) => s.done);   // DERIVED gate
  const missing = checklist.filter((s) => s.req && !s.done).map((s) => s.id === 'connect' ? C.missConnect : C.missImport);

  // `mode === 'empty'` shows the onboarding card; it MORPHS to the ov2 look once
  // `ready`. Each step's CTA performs the real action that flips state.
  if (mode === 'empty') {
    return (
      <div style={{ display: 'grid', gap: 16 }}>
        <Card style={{ padding: 18 }}>
          <H3>{ready ? C.titleReady : C.titleStart}</H3>
          <Muted size={12.5}>{ready ? C.subReady(doneCount) : C.subStart(doneCount)}</Muted>
          <div style={{ margin: '10px 0 14px' }}><ProgressBar value={doneCount / 4 * 100} /></div>

          {checklist.map((s) => (
            <React.Fragment key={s.id}>
              <div style={{ display: 'flex', alignItems: 'center', gap: 10, padding: '9px 0', borderTop: '0.5px solid var(--cw-border)' }}>
                <span style={{ color: s.done ? 'var(--cw-green)' : 'var(--cw-ink-3)', width: 16, textAlign: 'center' }}>{s.done ? '✓' : '✗'}</span>
                <span style={{ flex: 1, fontSize: 13.5 }}>{s.req && <span style={{ color: 'var(--cw-accent)' }}>* </span>}{s.label}</span>
                <Btn variant={s.done ? 'secondary' : s.req ? 'primary' : 'secondary'} size="sm"
                  onClick={() => s.id === 'connect' ? go('connect') : s.id === 'import' ? onAddProduct() : toast({ title: COPY.toast.open(s.label) })}>{s.cta}</Btn>
              </div>
              {/* state-dependent inline element sits right where the wireframe puts it */}
              {ready && s.id === 'import' && (
                <div style={{ margin: '8px 0', padding: '10px 12px', borderRadius: 12, background: 'rgba(185,121,31,0.13)', display: 'flex', alignItems: 'center', gap: 10, flexWrap: 'wrap' }}>
                  <span style={{ flex: 1, minWidth: 0, fontSize: 12.5, color: '#b9791f' }}>{C.suggestProducts(setup.products)}</span>
                  <Btn variant="soft" size="sm" onClick={onTestChat}>{C.suggestCta}</Btn>
                </div>
              )}
            </React.Fragment>
          ))}

          {ready ? (
            <div style={{ marginTop: 14 }}><Btn variant="primary" size="lg" full onClick={onGoLive}>{C.goLive}</Btn></div>
          ) : (
            <div style={{ marginTop: 14, padding: '11px 13px', borderRadius: 11, background: 'var(--cw-card-2)', fontSize: 12.5, color: 'var(--cw-ink-2)' }}>
              {C.locked}<div style={{ marginTop: 6, fontSize: 11.5, color: 'var(--cw-ink-3)' }}>{C.legend(missing.join(', '))}</div>
            </div>
          )}
        </Card>
      </div>
    );
  }

  // `mode === 'sample'` = the live (ov3) view — KPIs, action queue, etc.
  return (
    <div style={{ display: 'grid', gap: 14 }}>
      <Card style={{ padding: 18 }}>
        <H3>{C.salesTitle}</H3>
        {/* … KPI grid from `data.kpi` … */}
      </Card>
    </div>
  );
}
