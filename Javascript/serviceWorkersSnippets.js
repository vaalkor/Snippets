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
    let openCache = await caches.open(cacheName);
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
    cache.keys().then(requests => {

        requests.forEach(request => {
            console.log('Cached request:', request.url);
        });

    });
});