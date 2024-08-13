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

async function readCache(cacheName){
    let totalSize = 0;
    let totalKeys = 0;
    let openCache = await caches.open('test_cache1');
    let keys = await openCache.keys();
    for(let request of keys){
        let response = await openCache.match(request);
        if(response){
            let blob = await response.blob();
            totalSize += (blob.size/(1048576));
            totalKeys++;
        }
    }
    return {
        numKeys: totalKeys,
        totalSizeMB: totalSize
    }
}

caches.open('test_cache1').then(cache => {
    total = 0;
    totalKeys = 0;
    // function 
    cache.keys().then(requests => {
        Promise.all(requests
            .filter(x => request.url.includes('openstreetmap'))
            .map(x => cache.match(x).then(response => {

            }))
        );
        requests.forEach(request => {
            if(!request.url.includes('openstreetmap')) return;
            cache.match(request).then(response => {
                if (response) {
                    response.blob().then(blob => {
                        total += (blob.size/(1048576));
                        totalKeys++;
                        console.log(`Keys: ${totalKeys}, Total: ${total}MB`);
                    });
                }
            });
        });
    });
});

caches.open('test_cache1').then(cache => {
    cache.keys().then(requests => {

        requests.forEach(request => {
            console.log('Cached request:', request.url);
        });

    });
});