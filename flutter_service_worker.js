'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "d74eb2e643ee22e7ca319dfed6a30698",
"version.json": "009c9e65172e010890f7f65fde438006",
"index.html": "1bbcbd1aee2269b8c204d28f8dcd55fe",
"/": "1bbcbd1aee2269b8c204d28f8dcd55fe",
"main.dart.js": "2601c3b230433ea9310ca155a8377a55",
"prevent_default.js": "4eead4b4f3ce792bb2a736c47b83d77d",
"404.html": "c75a1ff55b6833f1ae89b0c2cf6d8a53",
"flutter.js": "383e55f7f3cce5be08fcf1f3881f585c",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "d40c47d1c161f94dbcb13094d37f1f55",
"assets/images/design.png": "a80bffde896f4777b5f1d10f13a4700a",
"assets/images/chisel.png": "290e79394b98e8f96d23e16eecf1a310",
"assets/images/python.png": "7ed7279e46619d48710dca21a38a9c0c",
"assets/images/dagger.png": "f7e3babf55c44f5d1c00ea048a19a0c5",
"assets/images/images/flutter_logo.png": "478970b138ad955405d4efda115125bf",
"assets/images/images/2.0x/flutter_logo.png": "4efb9624185aff46ca4bf5ab96496736",
"assets/images/images/3.0x/flutter_logo.png": "b8ead818b15b6518ac627b53376b42f2",
"assets/images/rust.png": "3e86aa84894e6feaf9e2cb2f9c5d41c2",
"assets/images/pakmo/01.png": "cde37c45dd91d3ee283c7714b46737c9",
"assets/images/pakmo/02.png": "c702308be5feb9dfb8548b006376b619",
"assets/images/rcg/app_mac.png": "b0bb170d44e774c27f1653efffac67d4",
"assets/images/rcg/records_page.png": "9ca68e1110ffdd77c46f5afc00e503c6",
"assets/images/rcg/session_running.png": "ff062baf0c1e7d9dfab32326fa575a9f",
"assets/images/rcg/tabata_running.png": "d4943fc5da05e1c909e64e1f4e01056e",
"assets/images/rcg/new_exercise.png": "80c8fc1560189b2b66c120361d91588b",
"assets/images/rcg/sessions_page.png": "c817b6ba746bb340b7610380b90d0d71",
"assets/images/rcg/sessions_running_light.png": "6a6279fa9b19638ef4c838b1360fd286",
"assets/images/rcg/workouts.png": "a52c81630cb4430241995e908863ad76",
"assets/images/rcg/log_climb.png": "34f9f1d0947d74491fd4899cbaf0b349",
"assets/images/rcg/repeater_setup.png": "0a642bbb7d82c22bf025e35e6eff9aad",
"assets/images/bfs/bfs_items.png": "6daf576a27e57054215b91bb53f11c1e",
"assets/images/bfs/bfs_notes_page.png": "c87d7db879ff673f5c3ef2349bcbb833",
"assets/images/bfs/bfs_player.png": "986e5c26b23495c99c765bb84664f52e",
"assets/images/bfs/bfs_item_page.png": "a05a4c526c821e6526b52ffc52ec4b44",
"assets/images/net.png": "5b5ac2b4ed923c08887abb68a0fe661b",
"assets/images/profile.jpeg": "5b58b29efee3271828b4968768ffb5eb",
"assets/images/rcg.png": "5861ea8cb28cd77686e21642594e82cc",
"assets/images/eqalink_logo.png": "793f6135f582c1c408ae104697b70702",
"assets/images/pencil.png": "6841924be286a3d1c5c7f1b632918100",
"assets/images/eqalink/01.png": "3c3138df60de51dedb663476ec120f3c",
"assets/images/eqalink/03.png": "453238b10fe329a9d404cd8b7815a8ea",
"assets/images/eqalink/02.png": "f945d9f572e7b7d013b13489f74743aa",
"assets/images/eqalink/06.png": "9fe8981dae1602737720e49de339bd51",
"assets/images/eqalink/07.png": "92a08c92808c3e72e64ae7807562e53b",
"assets/images/eqalink/05.png": "805e49729807247d8297c1e779fdd0fd",
"assets/images/eqalink/04.png": "8f220147edaf58e155303f39677a9173",
"assets/images/eqalink/08.png": "62025d7dc59771953b40ae06f58e3182",
"assets/images/compressed/pakmo/01.jpeg": "fb63f2ce250337c32e2c4a5b2e657232",
"assets/images/compressed/pakmo/02.jpeg": "c702308be5feb9dfb8548b006376b619",
"assets/images/compressed/rcg/repeater_setup.jpeg": "00a269579493725df040c92d154e7685",
"assets/images/compressed/rcg/workouts.jpeg": "c33f46c2a0b4a6f3e8a5497927579f91",
"assets/images/compressed/rcg/sessions_page.jpeg": "8c4d03bbb1de929c320d52c5611fc1cb",
"assets/images/compressed/rcg/records_page.jpeg": "a8304ca5beeae3f43b0663d38818c375",
"assets/images/compressed/rcg/tabata_running.jpeg": "aa6ee7bfedd1f9033d03d5471fef0abf",
"assets/images/compressed/rcg/new_exercise.jpeg": "2d4c725086b9c93de52c46350beac295",
"assets/images/compressed/rcg/sessions_running_light.jpeg": "ad5f03a72b2af0873910de6f23ef97b0",
"assets/images/compressed/rcg/app_mac.jpeg": "243435d50817f008d9936607c0e7d14e",
"assets/images/compressed/rcg/log_climb.jpeg": "d96e2c1d1d82083eef3f950ffa9bb71a",
"assets/images/compressed/rcg/session_running.jpeg": "4d4f00a62c55b8dcb7d9557bbc6dfa7f",
"assets/images/compressed/bfs/bfs_items.jpeg": "57fe90159109fdf8ec528a06351ea83a",
"assets/images/compressed/bfs/bfs_player.jpeg": "4b5d708450549ff84a1e9caa869d4933",
"assets/images/compressed/bfs/bfs_item_page.jpeg": "a385f588b239f52d326af9bd0977a3fa",
"assets/images/compressed/bfs/bfs_notes_page.jpeg": "12460c434f5c7c157246a6cc2cc4642a",
"assets/images/compressed/eqalink/06.jpeg": "8a6ef4f09bf948049aab476d4ac37d73",
"assets/images/compressed/eqalink/07.jpeg": "9445669c55845f8eef4b688543e862a7",
"assets/images/compressed/eqalink/01.jpeg": "bf40ff5f8768adfd70d9955d28dc94c5",
"assets/images/compressed/eqalink/02.jpeg": "377c5219a8f8e50d326409af2d7813cf",
"assets/images/compressed/eqalink/03.jpeg": "e4ad80e0a39d7a27fc733e74b4a7fe00",
"assets/images/compressed/eqalink/04.jpeg": "31b8412878ae5851c2907d0aa61e0063",
"assets/images/compressed/eqalink/08.jpeg": "44603b5b4c93c59081651eb8d2d81ed0",
"assets/images/compressed/eqalink/05.jpeg": "0524a38c60fcd4053b38adad879273d2",
"assets/images/box.png": "78abdd696e5a7d4d25a587bdb1774ce2",
"assets/AssetManifest.json": "82123cfb68a95438a3875ce436808545",
"assets/NOTICES": "21e433d5bf04b537fa4dbcd4379be99d",
"assets/FontManifest.json": "5a32d4310a6f5d9a6b651e75ba0d7372",
"assets/AssetManifest.bin.json": "949846aaaaffd652dd194cae98151320",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "121b4be3cc7b88cd4cc575b724549401",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "f64498717e6c01212b978f59f1ea6de4",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "f3307f62ddff94d2cd8b103daf8d1b0f",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "6bdbf7b9923a988624e59e508f150eab",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "2d31b424dad498edb03f5c5dc1547e25",
"assets/fonts/MaterialIcons-Regular.otf": "091f60cc21ca658a4f50925ab225e52b",
"canvaskit/skwasm.js": "5d4f9263ec93efeb022bb14a3881d240",
"canvaskit/skwasm.js.symbols": "c3c05bd50bdf59da8626bbe446ce65a3",
"canvaskit/canvaskit.js.symbols": "74a84c23f5ada42fe063514c587968c6",
"canvaskit/skwasm.wasm": "4051bfc27ba29bf420d17aa0c3a98bce",
"canvaskit/chromium/canvaskit.js.symbols": "ee7e331f7f5bbf5ec937737542112372",
"canvaskit/chromium/canvaskit.js": "901bb9e28fac643b7da75ecfd3339f3f",
"canvaskit/chromium/canvaskit.wasm": "399e2344480862e2dfa26f12fa5891d7",
"canvaskit/canvaskit.js": "738255d00768497e86aa4ca510cce1e1",
"canvaskit/canvaskit.wasm": "9251bb81ae8464c4df3b072f84aa969b",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
