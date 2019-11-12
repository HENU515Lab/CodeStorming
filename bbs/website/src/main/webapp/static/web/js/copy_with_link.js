$(document).ready(function () {

    function addLink(event) {
        event.preventDefault();

        let pagelink = "\n\n作者：" + article_author + '\n'
            + "链接：" + document.location.href + '\n'
            + "来源：" + "AcWing\n"
            + "著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。";

        let copytext = document.getSelection().toString();
        if (copytext.length > 300){
            copytext += pagelink;
        }

        if (event.originalEvent.clipboardData) {
            event.originalEvent.clipboardData.setData('Text', copytext);
        }
    }

    $('.copy-with-link').on('copy', addLink);
});