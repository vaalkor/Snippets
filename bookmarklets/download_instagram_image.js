// This first one didn't work properly...
// javascript:(function() {
//     var imageUrl = prompt("Enter the image URL:");
//     if (imageUrl) {
//         var link = document.createElement("a");
//         link.href = imageUrl;
//         link.download = "image.jpg";
//         document.body.appendChild(link);
//         link.click();
//         document.body.removeChild(link);
//     }
// })();

javascript:(function() {
    var image = document.querySelector('[role=\'dialog\'] img');
    var imageUrl = image.src;
    var imageName = 'ig_download_' + imageUrl.split('/').pop().split('.')[0] + '.jpeg';

    var img = new Image();
    img.crossOrigin = "Anonymous";
    img.onload = function() {
        var canvas = document.createElement("canvas");
        canvas.width = this.width;
        canvas.height = this.height;
        var ctx = canvas.getContext("2d");
        ctx.drawImage(this, 0, 0);
        var link = document.createElement("a");
        link.href = canvas.toDataURL("image/jpeg");
        link.download = imageName;
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
    };
    img.src = imageUrl;
})();