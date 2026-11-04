// Failles activement exploitées (catalogue public CISA KEV) · clic = fiche NVD · Catppuccin Mocha
import { run, css } from "uebersicht";

export const command = `"$HOME/dotfiles/scripts/kev" 6`;
export const refreshFrequency = 30 * 60 * 1000; // le script garde un cache de 6 h

export const className = `
  right: 40px;
  top: 64px;
  width: 400px;
  font-family: "SF Pro Display", -apple-system, sans-serif;
  color: #cdd6f4;
  -webkit-font-smoothing: antialiased;
`;

const card = css`
  padding: 14px 14px 8px;
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
const sub = css`margin-left: auto; font-weight: 500; text-transform: none; letter-spacing: 0;`;
const item = css`
  padding: 8px; border-radius: 12px; cursor: pointer;
  &:hover { background: rgba(243, 139, 168, 0.12); }
`;
const top = css`display: flex; align-items: center; gap: 8px;`;
const cve = css`font-family: "JetBrainsMono Nerd Font", monospace; font-size: 12.5px; font-weight: 700; color: #f38ba8;`;
const vendor = css`font-size: 12.5px; font-weight: 600; flex: 1; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;`;
const date = css`font-size: 11px; color: #7f849c; flex: none;`;
const desc = css`font-size: 11.5px; color: #a6adc8; margin-top: 3px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;`;
const badge = css`font-size: 10px; font-weight: 700; color: #1e1e2e; background: #fab387; padding: 1px 6px; border-radius: 6px; flex: none;`;
const error = css`font-size: 12px; color: #7f849c; padding: 4px 8px 8px;`;

const Shield = () => (
  <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinejoin="round">
    <path d="M12 3 4 6v6c0 4.5 3.4 8.2 8 9 4.6-.8 8-4.5 8-9V6z" /><path d="M12 8v5M12 16h.01" strokeLinecap="round" />
  </svg>
);

const ago = (iso) => {
  const days = Math.round((new Date().setHours(0, 0, 0, 0) - new Date(`${iso}T00:00:00`)) / 86400000);
  if (isNaN(days)) return iso;
  if (days <= 0) return "aujourd'hui";
  if (days === 1) return "hier";
  if (days < 7) return `il y a ${days} j`;
  return new Date(`${iso}T00:00:00`).toLocaleDateString("fr-FR", { day: "numeric", month: "short" });
};

// Seul un identifiant CVE strictement valide est utilisé dans la commande « open »
const openNvd = (id) => /^CVE-\d{4}-\d{4,7}$/.test(id) && run(`open "https://nvd.nist.gov/vuln/detail/${id}"`);

export const render = ({ output }) => {
  let data;
  try { data = JSON.parse(output); } catch (e) { return null; }

  return (
    <div className={card}>
      <div className={title}>
        <Shield /> Failles exploitées
        <span className={sub}>CISA KEV{data.total ? ` · ${data.total}` : ""}</span>
      </div>
      {data.error ? <div className={error}>{data.error}</div> : null}
      {(data.items || []).map((v) => (
        <div className={item} key={v.cve} onClick={() => openNvd(v.cve)} title={`${v.name} — ouvrir la fiche NVD`}>
          <div className={top}>
            <span className={cve}>{v.cve}</span>
            <span className={vendor}>{v.vendor} {v.product}</span>
            {v.ransomware ? <span className={badge}>rançongiciel</span> : null}
            <span className={date}>{ago(v.date)}</span>
          </div>
          <div className={desc}>{v.name}</div>
        </div>
      ))}
    </div>
  );
};
