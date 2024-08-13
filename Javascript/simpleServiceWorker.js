'use strict';

const staticCache = 'test_cache1';
const dynamicCache = 'dynamic_cache';

// List of URLs to precache
const PRECACHE_URLS = [
    // Local files
    '/',
    '/index.html',
    '/index.css'
];

const CURRENT_CACHES = [staticCache, dynamicCache];

// Install event - caching resources
self.addEventListener('install', event => {
  event.waitUntil(
    caches.open(staticCache)
        .then(cache => cache.addAll(PRECACHE_URLS))
        .then(self.skipWaiting()),
  );
});

// Activate event - cleaning up old caches
self.addEventListener('activate', event => {
    event.waitUntil(
        caches.keys().then(cacheNames => {
            return cacheNames.filter(cacheName => !CURRENT_CACHES.includes(cacheName));
        }).then(cachesToDelete => {
            return Promise.all(cachesToDelete.map(cacheToDelete => {
                return caches.delete(cacheToDelete);
            }));
        }).then(() => self.clients.claim())
    );
});

self.addEventListener('fetch', (event) => {
        event.respondWith(caches.open(staticCache).then(cache => {
            // Go to the network first
            return fetch(event.request.url).then((fetchedResponse) => {
                cache.put(event.request, fetchedResponse.clone());

                return fetchedResponse;
            }).catch(() => {
                // If the network is unavailable, get
                return cache.match(event.request.url);
            });
        }));
    }
);
