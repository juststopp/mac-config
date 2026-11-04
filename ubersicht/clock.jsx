// Horloge + date · Catppuccin Mocha
import { css } from "uebersicht";

export const command = "LC_TIME=fr_FR.UTF-8 date '+%H:%M|%A %-d %B|%H'";
export const refreshFrequency = 10000;

export const className = `
  left: 44px;
  top: 64px;
  font-family: "SF Pro Display", -apple-system, sans-serif;
  color: #cdd6f4;
  -webkit-font-smoothing: antialiased;
  text-shadow: 0 4px 24px rgba(17, 17, 27, 0.55);
  user-select: none;
`;

const timeCls = css`
  font-size: 104px; font-weight: 200; letter-spacing: -3px; line-height: 1;
  background: linear-gradient(120deg, #cdd6f4 30%, #cba6f7 100%);
  -webkit-background-clip: text; -webkit-text-fill-color: transparent;
`;
const dateCls = css`font-size: 22px; font-weight: 500; color: #bac2de; margin: 6px 0 0 6px; text-transform: capitalize;`;
const helloCls = css`font-size: 15px; font-weight: 500; color: #cba6f7; margin: 4px 0 0 6px; letter-spacing: 0.3px;`;

const greeting = (h) => (h < 5 ? "Bonne nuit" : h < 12 ? "Bonjour" : h < 18 ? "Bon après-midi" : "Bonsoir");

export const render = ({ output }) => {
  const [time, date, hour] = (output || "").trim().split("|");
  if (!time) return null;
  return (
    <div>
      <div className={timeCls}>{time}</div>
      <div className={dateCls}>{date}</div>
      <div className={helloCls}>{greeting(parseInt(hour, 10))} ✦</div>
    </div>
  );
};
