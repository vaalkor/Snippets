function handleEscapeKey(event) {
    if (event.key === "Escape") {
      const closeButton = document.querySelector('[aria-label="Close"]');
      
      if (closeButton) closeButton.click();
    }
  }
  
  document.addEventListener('keydown', handleEscapeKey);
  