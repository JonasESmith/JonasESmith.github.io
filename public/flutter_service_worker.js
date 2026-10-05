// Kill switch for the retired Flutter site's service worker.
// Browsers re-check this script on navigation; this version wipes the Flutter caches,
// unregisters itself and reloads open tabs so returning visitors get the static site.
self.addEventListener("install", () => self.skipWaiting());
self.addEventListener("activate", event => {
  event.waitUntil((async () => {
    for (const key of await caches.keys()) await caches.delete(key);
    await self.registration.unregister();
    for (const client of await self.clients.matchAll({ type: "window" })) client.navigate(client.url);
  })());
});
