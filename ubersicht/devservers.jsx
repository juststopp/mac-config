// Serveurs de dev en cours · clic = ouvrir dans le navigateur · Catppuccin Mocha
import { run, css } from "uebersicht";

export const command = `"$HOME/dotfiles/scripts/devservers"`;
export const refreshFrequency = 15000;

export const className = `
  left: 40px;
  bottom: 40px;
  font-family: "SF Pro Display", -apple-system, sans-serif;
  color: #cdd6f4;
  -webkit-font-smoothing: antialiased;
`;

const card = css`
  min-width: 300px; max-width: 420px; padding: 14px 14px 10px;
  background: rgba(30, 30, 46, 0.62);
  backdrop-filter: blur(28px) saturate(140%);
  -webkit-backdrop-filter: blur(28px) saturate(140%);
  border: 1px solid rgba(203, 166, 247, 0.22);
  border-radius: 22px;
  box-shadow: 0 12px 40px rgba(17, 17, 27, 0.45);
`;
const title = css`
  display: flex; align-items: center; gap: 8px; margin: 0 4px 8px;
  font-size: 11px; font-weight: 700; color: #7f849c; letter-spacing: 0.8px; text-transform: uppercase;
`;
const count = css`margin-left: auto; color: #a6e3a1;`;
const item = css`
  display: flex; align-items: center; gap: 10px; padding: 7px 8px; border-radius: 12px; cursor: pointer;
  &:hover { background: rgba(203, 166, 247, 0.14); }
`;
const dot = css`
  width: 8px; height: 8px; border-radius: 50%; background: #a6e3a1; flex: none;
  box-shadow: 0 0 8px rgba(166, 227, 161, 0.8);
`;
const port = css`font-family: "JetBrainsMono Nerd Font", monospace; font-size: 13px; font-weight: 700; color: #cba6f7; min-width: 48px;`;
const proj = css`font-size: 13px; font-weight: 600; flex: 1; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;`;
const tool = css`font-size: 11px; color: #a6adc8; background: #313244; padding: 2px 8px; border-radius: 8px;`;
const empty = css`
  display: inline-flex; align-items: center; gap: 8px; padding: 8px 14px; font-size: 12px; color: #7f849c;
  background: rgba(30, 30, 46, 0.45); border: 1px solid rgba(108, 112, 134, 0.25); border-radius: 14px;
`;

const Server = () => (
  <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round">
    <rect x="3" y="4" width="18" height="7" rx="2" /><rect x="3" y="13" width="18" height="7" rx="2" />
    <path d="M7 7.5h.01M7 16.5h.01" />
  </svg>
);

export const render = ({ output }) => {
  let servers;
  try { servers = JSON.parse(output); } catch (e) { return null; }
  if (!Array.isArray(servers)) return null;

  if (servers.length === 0) {
    return <div className={empty}><Server /> Aucun serveur de dev lancé</div>;
  }

  // Le port est un entier vérifié : il peut servir sans risque dans la commande
  const open = (p) => Number.isInteger(p) && run(`open "http://localhost:${p}"`);

  return (
    <div className={card}>
      <div className={title}><Server /> Serveurs de dev <span className={count}>{servers.length} actif{servers.length > 1 ? "s" : ""}</span></div>
      {servers.map((s) => (
        <div className={item} key={`${s.pid}-${s.port}`} onClick={() => open(s.port)} title={`Ouvrir http://localhost:${s.port}`}>
          <span className={dot} />
          <span className={port}>:{s.port}</span>
          <span className={proj}>{s.project}</span>
          <span className={tool}>{s.tool}</span>
        </div>
      ))}
    </div>
  );
};
