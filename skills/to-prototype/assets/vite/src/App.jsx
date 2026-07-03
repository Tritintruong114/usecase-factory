import { useEffect, useState } from 'react';
import { COPY } from './copy.js';
import { seedState } from './fixtures.js';
import Overview from './components/Overview.jsx';
import Sandbox from './components/Sandbox.jsx';

export default function App() {
  const [mode, setMode] = useState('empty');
  const [state, setState] = useState(() => seedState('empty'));
  const [tab, setTab] = useState('overview');
  const [sandbox, setSandbox] = useState(false);

  useEffect(() => setState(seedState(mode)), [mode]);

  return (
    <main className="app-shell">
      <header className="topbar">
        <div>
          <p className="eyebrow">{COPY.app.eyebrow}</p>
          <h1>{COPY.app.title}</h1>
          <p>{COPY.app.subtitle}</p>
        </div>
        <div className="segmented" aria-label={COPY.demo.label}>
          <span>{COPY.demo.label}</span>
          <button className={mode === 'empty' ? 'active' : ''} onClick={() => setMode('empty')}>{COPY.demo.empty}</button>
          <button className={mode === 'sample' ? 'active' : ''} onClick={() => setMode('sample')}>{COPY.demo.sample}</button>
        </div>
      </header>

      <nav className="tabs">
        <button className={tab === 'overview' ? 'active' : ''} onClick={() => setTab('overview')}>{COPY.tabs.overview}</button>
        <button disabled>{COPY.tabs.conversations} <small>{COPY.tabs.soon}</small></button>
        <button disabled>{COPY.tabs.settings} <small>{COPY.tabs.soon}</small></button>
      </nav>

      {tab === 'overview' && <Overview state={state} setState={setState} onSandbox={() => setSandbox(true)} />}
      {sandbox && <Sandbox onClose={() => setSandbox(false)} />}
    </main>
  );
}
