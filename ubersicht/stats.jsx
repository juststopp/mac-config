// CPU · RAM · disque · batterie · Catppuccin Mocha
import { css } from "uebersicht";

export const command = `"$HOME/dotfiles/scripts/sysstats"`;
export const refreshFrequency = 5000;

export const className = `
  right: 40px;
  bottom: 40px;
  font-family: "SF Pro Display", -apple-system, sans-serif;
  color: #cdd6f4;
  -webkit-font-smoothing: antialiased;
`;

const wrap = css`
  display: flex; gap: 10px; padding: 12px;
  background: rgba(30, 30, 46, 0.62);
  backdrop-filter: blur(28px) saturate(140%);
  -webkit-backdrop-filter: blur(28px) saturate(140%);
  border: 1px solid rgba(203, 166, 247, 0.22);
  border-radius: 22px;
  box-shadow: 0 12px 40px rgba(17, 17, 27, 0.45);
`;
const tile = css`width: 74px; display: flex; flex-direction: column; align-items: center; gap: 6px;`;
const label = css`font-size: 11px; color: #7f849c; font-weight: 600; letter-spacing: 0.6px; text-transform: uppercase;`;
const value = css`font-size: 13px; font-weight: 700; font-variant-numeric: tabular-nums;`;

// Anneau de progression
const Ring = ({ pct, color }) => {
  const r = 22, c = 2 * Math.PI * r;
  return (
    <svg width="56" height="56" viewBox="0 0 56 56">
      <circle cx="28" cy="28" r={r} fill="none" stroke="#45475a" strokeWidth="5" />
      <circle cx="28" cy="28" r={r} fill="none" stroke={color} strokeWidth="5" strokeLinecap="round"
        strokeDasharray={`${(Math.max(0, Math.min(100, pct)) / 100) * c} ${c}`} transform="rotate(-90 28 28)" />
    </svg>
  );
};

const level = (pct, warn, crit) => (pct >= crit ? "#f38ba8" : pct >= warn ? "#fab387" : null);

export const render = ({ output }) => {
  let s;
  try { s = JSON.parse(output); } catch (e) { return null; }
  const tiles = [
    { name: "CPU", pct: s.cpu, text: `${s.cpu}%`, color: level(s.cpu, 60, 85) || "#89b4fa" },
    { name: "RAM", pct: s.mem, text: `${s.mem}%`, color: level(s.mem, 75, 90) || "#cba6f7" },
    { name: "Disque", pct: s.diskPct, text: `${s.diskFree} Go`, color: level(s.diskPct, 80, 90) || "#a6e3a1" },
    { name: s.charging ? "Secteur" : "Batterie", pct: s.batt, text: `${s.batt}%`,
      color: s.charging ? "#f9e2af" : level(100 - s.batt, 70, 85) || "#94e2d5" },
  ];
  return (
    <div className={wrap}>
      {tiles.map((t) => (
        <div className={tile} key={t.name}>
          <Ring pct={t.pct} color={t.color} />
          <div className={value}>{t.text}</div>
          <div className={label}>{t.name}</div>
        </div>
      ))}
    </div>
  );
};
