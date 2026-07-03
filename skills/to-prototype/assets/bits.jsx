// SCAFFOLD — copy to new-design/src/workspaces/<ws>/bits.jsx. ws-specific
// primitives layered on top of new-design's shared primitives (../../ui).
// Keep these thin; reach for ../../ui (Card/Btn/Chip/Pill/Switch/Icon) first.

import React from 'react';
import { Pill } from '../../ui';

// Example: channel badge. Replace with whatever small ws-specific bits you need.
const CH = {
  fb:   { bg: '#dceafe', fg: '#3b6cc4', label: 'f' },
  zalo: { bg: '#e3f0ff', fg: '#0068ff', label: 'Z' },
};
export function ChannelBadge({ id, size = 22 }) {
  const m = CH[id]; if (!m) return null;
  return (
    <span style={{ width: size, height: size, borderRadius: 6, background: m.bg, color: m.fg, display: 'inline-flex',
      alignItems: 'center', justifyContent: 'center', fontSize: size * 0.58, fontWeight: 800, flex: 'none', fontFamily: 'Georgia, serif' }}>
      {m.label}
    </span>
  );
}

// Status pill — the KEYS here are the data vocabulary (they match the `status`
// values in fixtures.js records), so they intentionally stay as VN literals.
const STATUS = {
  'đang chốt': { color: 'var(--cw-green)', bg: 'var(--cw-green-soft)' },
  // …
};
export function StatusPill({ status }) {
  const s = STATUS[status] || {};
  return <Pill color={s.color} bg={s.bg}>{status}</Pill>;
}

export function Muted({ children, size = 13, style }) {
  return <span style={{ color: 'var(--cw-ink-2)', fontSize: size, ...style }}>{children}</span>;
}
export function H3({ children, style }) {
  return <h3 style={{ margin: '0 0 8px', fontSize: 15, fontWeight: 700, letterSpacing: '-0.01em', ...style }}>{children}</h3>;
}
