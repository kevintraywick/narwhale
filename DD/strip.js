// Shared session strip — populates any #sess-strip element with session links.
// Marks the current session active when ?id= is present in the URL (session.html).
(async () => {
    const strip = document.getElementById('sess-strip');
    if (!strip) return;
    try {
        const r = await fetch('/DD/api.php?key=sessions');
        const sessions = r.ok ? await r.json() : [];
        const currentId = new URLSearchParams(location.search).get('id');
        sessions.forEach(s => {
            const a = document.createElement('a');
            a.href = `/DD/session.html?id=${s.id}`;
            a.textContent = s.title || `Session ${s.number}`;
            if (s.id === currentId) a.classList.add('active');
            strip.appendChild(a);
        });
    } catch {}
})();
