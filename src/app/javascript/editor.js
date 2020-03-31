require("codemirror/mode/ruby/ruby");
var CodeMirror = require("codemirror")
window.addEventListener('load', function() {
    Array.from(document.getElementsByClassName('codemirror')).forEach(function(element){
        CodeMirror.fromTextArea(element, {
            lineNumbers: true,
            viewportMargin: Infinity
        });
     })
})
