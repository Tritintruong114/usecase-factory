export function Card({ children, className = '', ...props }) {
  return <section className={`card ${className}`} {...props}>{children}</section>;
}

export function Button({ children, variant = 'secondary', ...props }) {
  return <button className={`btn ${variant}`} {...props}>{children}</button>;
}

export function Pill({ children, tone = 'neutral' }) {
  return <span className={`pill ${tone}`}>{children}</span>;
}
