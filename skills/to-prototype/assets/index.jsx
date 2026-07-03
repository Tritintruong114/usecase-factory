// SCAFFOLD — copy to new-design/src/workspaces/<ws>/index.jsx. The dashboard:
// header + tab strip + content router + floating demo-data toggle + global
// sandbox. It OWNS the lifted, manipulable state and passes derived data +
// handlers down to each tab. Mounts in new-design's `mock` screen panel.

import React, { useState, useEffect } from 'react';
import { Icon, Btn, useToast } from '../../ui';
import { FIXTURES, seedSetup, buildChecklist } from './fixtures';
import { COPY } from './copy';
import ExampleTab from './example-tab';
// import OtherTab from './other-tab';

// wired = a real hero tab; false = "soon" (out of pilot scope, shown disabled).
const TABS = [
  { id: 'overview', label: COPY.tabs.overview, icon: 'chart', wired: true },
  // { id: 'conv', label: COPY.tabs.conv, icon: 'message', wired: true },
  // { id: 'product', label: COPY.tabs.product, icon: 'inbox', wired: false },
];

function Seg({ value, onChange, options }) {
  return (
    <div style={{ display: 'inline-flex', padding: 3, borderRadius: 10, background: 'var(--cw-card-2)', border: '0.5px solid var(--cw-border)' }}>
      {options.map((o) => {
        const on = o.value === value;
        return (
          <button key={o.value} onClick={() => onChange(o.value)} className="cw-press"
            style={{ height: 28, padding: '0 12px', borderRadius: 7, border: 'none', cursor: 'pointer', fontFamily: 'var(--cw-sans)',
              fontSize: 12.5, fontWeight: 600, background: on ? 'var(--cw-card)' : 'transparent', color: on ? 'var(--cw-ink)' : 'var(--cw-ink-3)',
              boxShadow: on ? 'var(--cw-shadow-sm)' : 'none', transition: 'all .14s ease' }}>
            {o.label}
          </button>
        );
      })}
    </div>
  );
}

function Sandbox({ onClose }) {
  const [msgs, setMsgs] = useState(COPY.sandbox.seed);
  const [draft, setDraft] = useState('');
  function send() {
    if (!draft.trim()) return;
    const q = draft.trim(); setDraft('');
    setMsgs((m) => [...m, { who: 'cust', text: q }]);
    setTimeout(() => setMsgs((m) => [...m, { who: 'agent', text: COPY.sandbox.reply }]), 450);
  }
  return (
    <div onClick={onClose} style={{ position: 'fixed', inset: 0, zIndex: 150, background: 'var(--cw-scrim)', display: 'flex', alignItems: 'center', justifyContent: 'center', padding: 24 }}>
      <div onClick={(e) => e.stopPropagation()} className="cw-pop" style={{ width: 420, maxWidth: '100%', background: 'var(--cw-card)', borderRadius: 16, boxShadow: 'var(--cw-shadow)', border: '0.5px solid var(--cw-border)', display: 'flex', flexDirection: 'column', maxHeight: '80vh' }}>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', padding: '15px 18px', borderBottom: '0.5px solid var(--cw-border)' }}>
          <b>{COPY.sandbox.title}</b>
          <button onClick={onClose} style={{ border: 'none', background: 'none', cursor: 'pointer', color: 'var(--cw-ink-3)' }}><Icon name="x" size={18} /></button>
        </div>
        <div style={{ flex: 1, overflow: 'auto', padding: 16, display: 'flex', flexDirection: 'column', gap: 8 }}>
          {msgs.map((b, i) => (
            <div key={i} style={{ alignSelf: b.who === 'cust' ? 'flex-start' : 'flex-end', maxWidth: '80%',
              background: b.who === 'cust' ? 'var(--cw-card-2)' : 'var(--cw-accent-soft)', borderRadius: 13, padding: '8px 12px', fontSize: 13.5 }}>{b.text}</div>
          ))}
        </div>
        <div style={{ padding: 12, borderTop: '0.5px solid var(--cw-border)', display: 'flex', gap: 8 }}>
          <input value={draft} onChange={(e) => setDraft(e.target.value)} onKeyDown={(e) => e.key === 'Enter' && send()}
            placeholder={COPY.sandbox.placeholder} style={{ flex: 1, height: 38, padding: '0 12px', borderRadius: 9, border: '0.5px solid var(--cw-border-strong)', background: 'var(--cw-bg)', color: 'var(--cw-ink)', fontFamily: 'var(--cw-sans)', fontSize: 13.5, outline: 'none' }} />
          <Btn variant="primary" icon="send" onClick={send}>{COPY.sandbox.send}</Btn>
        </div>
        <div style={{ padding: '0 16px 14px', fontSize: 11.5, color: 'var(--cw-ink-3)' }}>{COPY.sandbox.note}</div>
      </div>
    </div>
  );
}

export function WsDashboard() {
  const [tab, setTab] = useState('overview');
  const [mode, setMode] = useState('empty');
  const [sandbox, setSandbox] = useState(false);
  const [run, setRun] = useState(false);
  // Lifted, manipulable state — seeded by demo mode, overridden by user action.
  const [setup, setSetup] = useState(() => seedSetup('empty'));
  const toast = useToast();
  const data = FIXTURES[mode];
  const checklist = buildChecklist(setup);          // DERIVED — actions flip steps
  const openTest = () => setSandbox(true);
  const addProducts = () => { setSetup((s) => ({ ...s, products: s.products + 12 })); toast({ title: COPY.toast.addProducts }); };

  useEffect(() => { setRun(mode === 'sample'); setSetup(seedSetup(mode)); }, [mode]);
  const toggleRun = () => setRun((r) => { const n = !r; toast({ title: n ? COPY.toast.goLiveOn : COPY.toast.goLiveOff }); return n; });

  return (
    <div style={{ height: '100%', display: 'flex', flexDirection: 'column', minHeight: 0, position: 'relative' }}>
      <div style={{ display: 'flex', alignItems: 'center', gap: 12, padding: '16px 18px 12px', flex: 'none' }}>
        <span style={{ width: 38, height: 38, borderRadius: 11, background: 'var(--cw-card-2)', display: 'inline-flex', alignItems: 'center', justifyContent: 'center', fontSize: 20, flex: 'none' }}>{COPY.header.emoji}</span>
        <div style={{ flex: 1, minWidth: 0 }}>
          <div style={{ fontSize: 18, fontWeight: 750, letterSpacing: '-0.015em', color: 'var(--cw-ink)' }}>{COPY.header.title}</div>
          <div style={{ fontSize: 13, color: 'var(--cw-ink-2)', marginTop: 1 }}>{COPY.header.subtitle}</div>
        </div>
        <button onClick={toggleRun} className="cw-press" title={COPY.header.runTip}
          style={{ display: 'inline-flex', alignItems: 'center', gap: 7, height: 34, padding: '0 14px', borderRadius: 999, cursor: 'pointer',
            fontFamily: 'var(--cw-sans)', fontSize: 13, fontWeight: 600, border: '0.5px solid transparent',
            background: run ? 'var(--cw-green-soft)' : 'var(--cw-card-2)', color: run ? 'var(--cw-green)' : 'var(--cw-ink-2)' }}>
          {run ? COPY.header.runOn : COPY.header.runOff}
        </button>
      </div>

      <div style={{ display: 'flex', alignItems: 'center', gap: 10, padding: '0 18px 10px', borderBottom: '0.5px solid var(--cw-border)', flex: 'none' }}>
        <div className="cw-tabs" style={{ flex: 1, minWidth: 0, display: 'flex', alignItems: 'center', gap: 3, overflowX: 'auto' }}>
          {TABS.map((t) => {
            const on = tab === t.id;
            return (
              <button key={t.id} onClick={() => t.wired && setTab(t.id)} disabled={!t.wired} className="cw-press"
                title={t.wired ? '' : COPY.tabs.soonTip}
                style={{ display: 'inline-flex', alignItems: 'center', gap: 7, height: 36, padding: '0 13px', borderRadius: 11,
                  cursor: t.wired ? 'pointer' : 'not-allowed', fontFamily: 'var(--cw-sans)', fontSize: 13.5, fontWeight: on ? 700 : 500,
                  whiteSpace: 'nowrap', border: '0.5px solid transparent', background: 'transparent',
                  color: on ? 'var(--cw-accent)' : t.wired ? 'var(--cw-ink-2)' : 'var(--cw-ink-3)', opacity: t.wired ? 1 : 0.55 }}>
                <Icon name={t.icon} size={16} style={{ color: on ? 'var(--cw-accent)' : 'var(--cw-ink-3)' }} />{t.label}
                {!t.wired && <span style={{ fontSize: 10, color: 'var(--cw-ink-3)' }}>{COPY.tabs.soon}</span>}
              </button>
            );
          })}
        </div>
      </div>

      <div key={tab + mode} className="cw-fade" style={{ flex: 1, minHeight: 0, overflow: 'auto', padding: 20 }}>
        {tab === 'overview' && <ExampleTab data={data} mode={mode} go={setTab} onTestChat={openTest} checklist={checklist} setup={setup} onAddProduct={addProducts} onGoLive={toggleRun} />}
        {/* {tab === 'conv' && <OtherTab data={data} mode={mode} setup={setup} setSetup={setSetup} />} */}
      </div>

      <div style={{ position: 'absolute', right: 18, bottom: 16, zIndex: 40, display: 'inline-flex', alignItems: 'center', gap: 8,
        padding: '7px 9px 7px 12px', borderRadius: 12, background: 'var(--cw-glass-2)', backdropFilter: 'blur(12px)',
        border: '0.5px solid var(--cw-border)', boxShadow: 'var(--cw-shadow)' }}>
        <span style={{ fontSize: 11, fontWeight: 600, color: 'var(--cw-ink-3)', letterSpacing: '0.04em', textTransform: 'uppercase' }}>{COPY.demo.label}</span>
        <Seg value={mode} onChange={setMode} options={[{ value: 'empty', label: COPY.demo.empty }, { value: 'sample', label: COPY.demo.sample }]} />
      </div>

      {sandbox && <Sandbox onClose={() => setSandbox(false)} />}
    </div>
  );
}

export default WsDashboard;
