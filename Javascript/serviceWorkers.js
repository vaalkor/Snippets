caches.keys().then(cacheNames => {
    console.log('Cache names:', cacheNames);
});

caches.open('my-cache-name').then(cache => {
    cache.keys().then(requests => {
        requests.forEach(request => {
            console.log('Cached request:', request.url);
        });
    });
});

caches.open('my-cache-name').then(cache => {
    cache.keys().then(requests => {
        requests.forEach(request => {
            cache.match(request).then(response => {
                if (response) {
                    response.blob().then(blob => {
                        console.log('Size of', request.url, 'is', blob.size, 'bytes');
                    });
                }
            });
        });
    });
});