// ChatGpt created this function for showing what elements are overflowing their containers.
(function() {
    function isOverflowing(el) {
        const curOverflow = el.style.overflow;
        if (!curOverflow || curOverflow === "visible") {
            el.style.overflow = "hidden";
        }
        const isOverflowing = el.scrollWidth > el.clientWidth || el.scrollHeight > el.clientHeight;
        el.style.overflow = curOverflow; // Revert overflow style
        return isOverflowing;
    }

    function findOverflowingElements() {
        const overflowingElements = [];
        const allElements = document.querySelectorAll("*");
        allElements.forEach(el => {
            if (isOverflowing(el)) {
                overflowingElements.push(el);
            }
        });
        return overflowingElements;
    }

    const overflowingElements = findOverflowingElements();
    console.log("Overflowing elements:", overflowingElements);
    overflowingElements.forEach(el => {
        el.style.outline = "2px solid red"; // Highlight overflowing elements
    });

    if (overflowingElements.length === 0) {
        console.log("No overflowing elements found!");
    }
})();
