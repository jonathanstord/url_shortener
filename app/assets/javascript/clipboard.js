function copyToClipboard(containerid ) {
    const range = document.createRange();
    range.selectNode(document.getElementById(containerid));
    window.getSelection().removeAllRanges();
    window.getSelection().addRange(range);
    document.execCommand('copy');
    const message = document.getElementById('copied');
    message.style.display = "block";
}
