function fontSizeChanged(size) {
    console.log("font changed size = " + size);
    var pixelSize = size + "px";
    document.getElementById('content').style.setProperty("font-size", pixelSize);
}

function setUpCSS(css) {
    head = document.head || document.getElementsByTagName('head')[0],
    style = document.createElement('style');

    head.appendChild(style);

    style.type = 'text/css';
    if (style.styleSheet){
        style.styleSheet.cssText = css;
    } else {
        style.appendChild(document.createTextNode(css));
    }
}
