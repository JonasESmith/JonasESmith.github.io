// Deferred, non-critical. Everything here enhances already-rendered HTML.
(() => {
  const d = document, h = d.documentElement;
  const $ = (s, r = d) => r.querySelector(s), $$ = (s, r = d) => [...r.querySelectorAll(s)];
  const save = (k, v) => { try { localStorage[k] = v } catch (e) {} };
  const reduced = matchMedia("(prefers-reduced-motion:reduce)").matches;

  // --- Scheme palette (Cmd/Ctrl+P, footer button): search, ↑/↓ cycle, Enter closes.
  const pal = $("#schemes"), q = $("#pal-q"), rows = $$(".sc");
  const setScheme = id => { h.dataset.scheme = id; save("scheme", id) };
  const step = dir => {
    const vis = rows.filter(r => !r.hidden);
    if (!vis.length) return;
    const i = vis.findIndex(r => r.dataset.id === h.dataset.scheme);
    const next = vis[(i + dir + vis.length) % vis.length];
    setScheme(next.dataset.id);
    next.scrollIntoView({ block: "nearest" });
  };
  const filter = () => {
    const v = q.value.trim().toLowerCase();
    rows.forEach(r => { r.hidden = !r.textContent.toLowerCase().includes(v) });
  };
  q.addEventListener("input", filter);
  pal.addEventListener("toggle", e => {
    if (e.newState !== "open") return;
    q.value = ""; filter();
    if (matchMedia("(pointer:fine)").matches) q.focus();
  });

  // --- About card: smooth open/close. The card's height eases open, then each block of text fades
  // and rises in, staggered. Closing fades the text and eases back. Without JS (or with reduced
  // motion) the native <details> toggle still works, just instantly.
  const card = $(".card");
  if (card && !reduced) {
    const sum = $("summary", card), about = $(".about", card);
    const ease = "cubic-bezier(.2,.7,.2,1)";
    let size, fade;
    const done = () => { card.style.overflow = ""; size = fade = null };
    sum.addEventListener("click", e => {
      e.preventDefault();
      const opening = !card.open || card.classList.contains("closing");
      const from = card.offsetHeight;  // mid-animation height when interrupted
      size?.cancel(); fade?.cancel();
      card.style.overflow = "hidden";
      if (opening) {
        card.classList.remove("closing");
        card.open = true;
        const to = card.offsetHeight;
        size = card.animate({ height: [from + "px", to + "px"] }, { duration: 520, easing: ease });
        const blocks = [$("hr", about), ...$(".md", about).children];
        blocks.forEach((b, i) => b.animate(
          [{ opacity: 0, transform: "translateY(10px)", filter: "blur(4px)" }, { opacity: 1, transform: "none", filter: "none" }],
          { duration: 480, delay: 90 + i * 70, easing: ease, fill: "backwards" }));
        size.onfinish = done;
      } else {
        card.classList.add("closing");
        card.open = false; const to = card.offsetHeight; card.open = true;
        fade = about.animate({ opacity: [1, 0], transform: ["none", "translateY(-6px)"] }, { duration: 200, easing: "ease-in", fill: "forwards" });
        size = card.animate({ height: [from + "px", to + "px"] }, { duration: 420, easing: ease });
        size.onfinish = () => { card.open = false; card.classList.remove("closing"); fade.cancel(); done() };
      }
    });
  }

  // --- Lightbox over the project gallery.
  const lb = $("#lb"), shots = $$("[data-gallery]");
  let cur = 0;
  const show = i => {
    cur = (i + shots.length) % shots.length;
    const img = $(".lb-img", lb);
    img.src = shots[cur].href;
    img.alt = $("img", shots[cur]).alt;
    $(".lb-n", lb).textContent = `Image ${cur + 1} / ${shots.length}`;
  };
  if (lb) {
    let x0 = null;
    lb.addEventListener("pointerdown", e => { x0 = e.clientX });
    lb.addEventListener("pointerup", e => {
      if (x0 !== null && Math.abs(e.clientX - x0) > 50) show(cur + (e.clientX < x0 ? 1 : -1));
      x0 = null;
    });
  }

  d.addEventListener("click", e => {
    const shot = e.target.closest("[data-gallery]");
    if (shot && lb) { e.preventDefault(); show(shots.indexOf(shot)); lb.showModal(); return }
    if (e.target === lb) { lb.close(); return }  // backdrop click
    const b = e.target.closest("[data-act]");
    if (!b) return;
    switch (b.dataset.act) {
      case "mode": {
        const m = h.dataset.mode === "dark" ? "light" : "dark";
        h.dataset.mode = m; save("mode", m);
        break;
      }
      case "scheme": setScheme(b.dataset.id); break;
      case "prev": step(-1); break;
      case "next": step(1); break;
      case "follower": {
        const off = h.dataset.follower !== "off";
        if (off) h.dataset.follower = "off"; else delete h.dataset.follower;
        save("follower", off ? "0" : "1");
        break;
      }
      case "copy": {
        const code = $("code", b.closest(".code")).innerText;
        navigator.clipboard?.writeText(code).then(() => {
          b.classList.add("ok");
          setTimeout(() => b.classList.remove("ok"), 2000);
        });
        break;
      }
      case "lb-close": lb.close(); break;
      case "lb-prev": show(cur - 1); break;
      case "lb-next": show(cur + 1); break;
    }
  });

  d.addEventListener("keydown", e => {
    if ((e.metaKey || e.ctrlKey) && e.key.toLowerCase() === "p") {
      e.preventDefault();  // also replaces prevent_default.js (no print dialog)
      pal.togglePopover();
      return;
    }
    if (pal.matches(":popover-open")) {
      if (e.key === "ArrowUp" || e.key === "ArrowDown") { e.preventDefault(); step(e.key === "ArrowUp" ? -1 : 1) }
      else if (e.key === "Enter") pal.hidePopover();
    } else if (lb?.open && (e.key === "ArrowLeft" || e.key === "ArrowRight")) {
      show(cur + (e.key === "ArrowRight" ? 1 : -1));
    }
  });

  // --- Cursor follower: exponential lerp ≈ Flutter's 700ms / 1400ms easeOutCubic lag.
  // Hidden until the first mouse move, then placed at the cursor and faded in (no sweep from a corner).
  // The rAF loop runs only while catching up. Touch / reduced motion: fade in at rest, no tracking.
  const glow = $(".glow");
  const reveal = () => requestAnimationFrame(() => glow.classList.add("on"));
  if (matchMedia("(pointer:fine)").matches && !reduced) {
    const g1 = $(".g1"), g2 = $(".g2"), grain = $(".gr>b");
    let tx = 0, ty = 0, raf = 0, last = 0, started = false;
    const p1 = [0, 0], p2 = [0, 0];
    const place = () => {
      g1.style.transform = `translate(${p1[0]}px,${p1[1]}px)`;
      grain.style.transform = `translate(${-p1[0]}px,${-p1[1]}px)`;  // grain stays put; the glow moves over it
      g2.style.transform = `translate(${p2[0]}px,${p2[1]}px)`;
    };
    const tick = t => {
      const dt = Math.min(64, last ? t - last : 16); last = t;
      const k1 = 1 - Math.exp(-dt / 230), k2 = 1 - Math.exp(-dt / 460);
      p1[0] += (tx - p1[0]) * k1; p1[1] += (ty - p1[1]) * k1;
      p2[0] += (tx - p2[0]) * k2; p2[1] += (ty - p2[1]) * k2;
      place();
      if (Math.abs(tx - p2[0]) + Math.abs(ty - p2[1]) > 0.5) raf = requestAnimationFrame(tick);
      else { raf = 0; last = 0 }
    };
    addEventListener("pointermove", e => {
      if (e.pointerType !== "mouse") return;
      tx = e.clientX; ty = e.clientY;
      if (!started) {
        started = true;
        p1[0] = p2[0] = tx; p1[1] = p2[1] = ty;
        place(); reveal();
        return;
      }
      if (!raf) raf = requestAnimationFrame(tick);
    }, { passive: true });
  } else {
    reveal();
  }

  // --- Build-time values go stale between deploys; refresh them.
  const day = 864e5, now = Date.now();
  $$("[data-birth]").forEach(e => {
    const age = Math.floor((now - Date.parse(e.dataset.birth)) / day / 365.25 * 10) / 10;
    e.textContent = "v" + age.toFixed(1);
  });
  $$("[data-since]").forEach(e => {
    e.textContent = ((now - Date.parse(e.dataset.since)) / day / 365.25).toFixed(1) + " y";
  });
})();
