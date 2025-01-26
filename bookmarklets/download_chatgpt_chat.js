javascript:(async function() {
    const chatId = window.location.pathname.split('/').pop();

    async function downloadImage(imageUrl, imageName) {
        const response = await fetch(imageUrl);
        const blob = await response.blob();      
        const blobUrl = URL.createObjectURL(blob);
        const link = document.createElement("a");
        link.href = blobUrl;
        link.download = imageName;
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
        URL.revokeObjectURL(blobUrl);
    }

    const articles = document.querySelectorAll('article');
    const messages = [];

    let imageCount = 1;

    for (const article of articles) {
        const roleDiv = article.querySelector('[data-message-author-role]');
        const role = roleDiv ? roleDiv.getAttribute('data-message-author-role') : null;
        if (!role) {
            console.error('Role not found for article:', article);
            continue;
        }

        const imagesElements = article.querySelectorAll('img');
        const images = [];

        for (const img of imagesElements) {
            const fileName = `chatgpt_${chatId}_image_${imageCount++}.webp`;
            await downloadImage(img.src, fileName);
            images.push(fileName);
        }

        messages.push({ 
            role, 
            text: roleDiv.innerText,
            images,
         });
    }

    const chatData = {
        url: window.location.href,
        messages,
    };

    const chatDataBlob = new Blob([JSON.stringify(chatData)], { type: 'application/json' });
    const chatDataUrl = URL.createObjectURL(chatDataBlob);
    const downloadLink = document.createElement('a');
    downloadLink.href = chatDataUrl;
    downloadLink.download = chatId + '.json';
    document.body.appendChild(downloadLink);
    downloadLink.click();
    document.body.removeChild(downloadLink);
    URL.revokeObjectURL(chatDataUrl);
  })();
  