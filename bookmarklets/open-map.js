javascript:(function(){
    const href = window.location.href;
    let lat, lon, zoom, source = "";

    function createButton(text, url) {
        const btn = document.createElement('button');
        btn.textContent = text;
        btn.style.margin = '8px';
        btn.style.padding = '10px 20px';
        btn.style.fontSize = '16px';
        btn.style.cursor = 'pointer';
        btn.onclick = () => {
            window.open(url, '_blank');
            document.body.removeChild(modal);
            document.body.removeChild(overlay);
        };
        return btn;
    }

    const googleMatch = href.match(/\/@([-0-9.]+),([-0-9.]+),([0-9.]+)z/);
    if (googleMatch) {
        lat = googleMatch[1];
        lon = googleMatch[2];
        zoom = googleMatch[3];
        source = "google";
    }

    const osmMatch = href.match(/#map=([0-9.]+)\/([-0-9.]+)\/([-0-9.]+)/);
    if (osmMatch) {
        zoom = osmMatch[1];
        lat = osmMatch[2];
        lon = osmMatch[3];
        source = "osm";
    }

    const osmapsMatch = href.match(/\?lat=([-0-9.]+)&lon=([-0-9.]+)&zoom=([0-9.]+)/);
    if (osmapsMatch) {
        lat = osmapsMatch[1];
        lon = osmapsMatch[2];
        zoom = osmapsMatch[3];
        source = "osmaps";
    }

    const chillbaggerMatch = href.match(/#!\/?\?lat=([-0-9.]+)&lng=([-0-9.]+)&zoom=([0-9.]+)/);
    if (chillbaggerMatch) {
        lat = chillbaggerMatch[1];
        lon = chillbaggerMatch[2];
        zoom = chillbaggerMatch[3];
        source = "chillbagger";
    }

    if (!(lat && lon && zoom)) {
        alert("Couldn't detect lat/lon/zoom from this page.");
        return;
    }

    const links = {
        google: `https://www.google.com/maps/@${lat},${lon},${zoom}z`,
        osm: `https://www.openstreetmap.org/#map=${zoom}/${lat}/${lon}`,
        osmaps: `https://explore.osmaps.com/create-route?lat=${lat}&lon=${lon}&zoom=${zoom}&style=Standard&type=2d`,
        chillbagger: `https://static.chillbagger.co.uk/#!?lat=${lat}&lng=${lon}&zoom=${zoom}`
    };

    const overlay = document.createElement('div');
    overlay.style.position = 'fixed';
    overlay.style.top = '0';
    overlay.style.left = '0';
    overlay.style.width = '100vw';
    overlay.style.height = '100vh';
    overlay.style.backgroundColor = 'rgba(0,0,0,0.5)';
    overlay.style.zIndex = '9999';

    const modal = document.createElement('div');
    modal.style.position = 'fixed';
    modal.style.top = '50%';
    modal.style.left = '50%';
    modal.style.transform = 'translate(-50%, -50%)';
    modal.style.backgroundColor = 'white';
    modal.style.padding = '20px';
    modal.style.borderRadius = '10px';
    modal.style.boxShadow = '0 0 20px rgba(0,0,0,0.5)';
    modal.style.textAlign = 'center';
    modal.style.zIndex = '10000';

    const title = document.createElement('div');
    title.textContent = 'Open location in:';
    title.style.marginBottom = '20px';
    title.style.fontSize = '18px';
    title.style.fontWeight = 'bold';
    modal.appendChild(title);

    for (const [key, url] of Object.entries(links)) {
        if (key !== source) {
            let niceName = "";
            if (key === "google") niceName = "Google Maps";
            if (key === "osm") niceName = "OpenStreetMap";
            if (key === "osmaps") niceName = "OS Maps";
            if (key === "chillbagger") niceName = "Chillbagger";
            modal.appendChild(createButton(niceName, url));
        }
    }

    overlay.onclick = () => {
        document.body.removeChild(modal);
        document.body.removeChild(overlay);
    };

    document.body.appendChild(overlay);
    document.body.appendChild(modal);
})();
