import { useState } from 'react';
import { COPY } from '../copy.js';
import { Button } from './bits.jsx';

export default function Sandbox({ onClose }) {
  const [messages, setMessages] = useState([
    { who: 'customer', text: 'Shop còn gói nào phù hợp cho người mới không?' },
    { who: 'agent', text: COPY.sandbox.reply },
  ]);
  const [draft, setDraft] = useState('');

  function send() {
    const text = draft.trim();
    if (!text) return;
    setDraft('');
    setMessages((m) => [...m, { who: 'customer', text }, { who: 'agent', text: COPY.sandbox.reply }]);
  }

  return (
    <div className="modal-backdrop" onClick={onClose}>
      <div className="modal" onClick={(e) => e.stopPropagation()}>
        <div className="modal-head"><b>{COPY.sandbox.title}</b><button onClick={onClose}>×</button></div>
        <div className="chat-log">
          {messages.map((m, i) => <div key={i} className={`bubble ${m.who}`}>{m.text}</div>)}
        </div>
        <div className="composer">
          <input value={draft} onChange={(e) => setDraft(e.target.value)} onKeyDown={(e) => e.key === 'Enter' && send()} placeholder={COPY.sandbox.placeholder} />
          <Button variant="primary" onClick={send}>{COPY.sandbox.send}</Button>
        </div>
        <p className="note">{COPY.sandbox.note}</p>
      </div>
    </div>
  );
}
