// Deferred, non-critical: theme controls + live date labels. (P4 adds palette keys, cursor follower, lightbox.)
(() => {
  const d = document, h = d.documentElement;
  const save = (k, v) => { try { localStorage[k] = v } catch (e) {} };

  d.addEventListener("click", e => {
    const b = e.target.closest("[data-act]");
    if (!b) return;
    const act = b.dataset.act;
    if (act === "mode") {
      const m = h.dataset.mode === "dark" ? "light" : "dark";
      h.dataset.mode = m; save("mode", m);
    } else if (act === "scheme") {
      h.dataset.scheme = b.dataset.id; save("scheme", b.dataset.id);
    } else if (act === "follower") {
      const off = h.dataset.follower !== "off";
      if (off) h.dataset.follower = "off"; else delete h.dataset.follower;
      save("follower", off ? "0" : "1");
    }
  });

  // Build-time values go stale between deploys; refresh them.
  const day = 864e5, now = Date.now();
  d.querySelectorAll("[data-birth]").forEach(e => {
    const t = Math.floor((now - Date.parse(e.dataset.birth)) / day);
    e.textContent = "v" + Math.floor(t / 365) + "." + (t % 365);
  });
  d.querySelectorAll("[data-since]").forEach(e => {
    e.textContent = ((now - Date.parse(e.dataset.since)) / day / 365.25).toFixed(1) + " y";
  });
})();
