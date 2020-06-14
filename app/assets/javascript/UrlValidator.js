function validateURL(str) {
    var pattern = new RegExp('^(https?:\\/\\/)?'+ // protocol
        '((([a-z\\d]([a-z\\d-]*[a-z\\d])*)\\.?)+[a-z]{2,}|'+ // domain name
        '((\\d{1,3}\\.){3}\\d{1,3}))'+ // OR ip (v4) address
        '(\\:\\d+)?(\\/[-a-z\\d%_.~+]*)*'+ // port and path
        '(\\?[;&a-z\\d%_.~+=-]*)?'+ // query string
        '(\\#[-a-z\\d_]*)?$','i');
    if(!pattern.test(str)) {
        const button = document.getElementById('submission');
        button.disabled = true;
        const message = document.getElementById('error_message');
        message.style.display = "block";
    } else {
        const button = document.getElementById('submission');
        button.disabled = false;
        const message = document.getElementById('error_message');
        message.style.display = "none";
    }
}