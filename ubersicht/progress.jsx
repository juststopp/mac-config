// Progression du temps : journée, semaine, mois, année · Catppuccin Mocha
import { css } from "uebersicht";

export const command = "date +%s";
export const refreshFrequency = 60000;

export const className = `
  left: 50px;
  top: 250px;
  width: 290px;
  font-family: "SF Pro Display", -apple-system, sans-serif;
  color: #cdd6f4;
  -webkit-font-smoothing: antialiased;
  user-select: none;
`;

const row = css`margin-bottom: 11px;`;
const head = css`display: flex; justify-content: space-between; font-size: 12px; margin-bottom: 5px;`;
const name = css`color: #bac2de; font-weight: 600; letter-spacing: 0.4px;`;
const pctCls = css`color: #7f849c; font-variant-numeric: tabular-nums;`;
const track = css`height: 5px; border-radius: 3px; background: rgba(69, 71, 90, 0.75); overflow: hidden;`;
const foot = css`font-size: 11px; color: #7f849c; margin-top: 4px;`;

const pct = (start, end, now) => Math.min(100, Math.max(0, ((now - start) / (end - start)) * 100));

export const render = () => {
  const now = new Date();
  const y = now.getFullYear(), m = now.getMonth(), d = now.getDate();
  const dayStart = new Date(y, m, d);
  const weekStart = new Date(y, m, d - ((now.getDay() + 6) % 7)); // semaine du lundi
  const items = [
    { label: "Journée", value: pct(dayStart, new Date(y, m, d + 1), now), color: "#cba6f7" },
    { label: "Semaine", value: pct(weekStart, new Date(weekStart.getFullYear(), weekStart.getMonth(), weekStart.getDate() + 7), now), color: "#89b4fa" },
    { label: "Mois", value: pct(new Date(y, m, 1), new Date(y, m + 1, 1), now), color: "#94e2d5" },
    { label: "Année", value: pct(new Date(y, 0, 1), new Date(y + 1, 0, 1), now), color: "#fab387" },
  ];
  const daysLeft = Math.ceil((new Date(y + 1, 0, 1) - now) / 86400000);

  return (
    <div>
      {items.map((it) => (
        <div className={row} key={it.label}>
          <div className={head}>
            <span className={name}>{it.label}</span>
            <span className={pctCls}>{Math.floor(it.value)} %</span>
          </div>
          <div className={track}>
            <div style={{ width: `${it.value}%`, height: "100%", borderRadius: 3,
              background: `linear-gradient(90deg, ${it.color}99, ${it.color})` }} />
          </div>
        </div>
      ))}
      <div className={foot}>Encore {daysLeft} jours avant {y + 1}</div>
    </div>
  );
};
