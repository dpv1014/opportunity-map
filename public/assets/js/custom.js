document.addEventListener("DOMContentLoaded", function() {
    var toggler = document.querySelectorAll(".caret2");
    var i;

    for (i = 0; i < toggler.length; i++) {
        toggler[i].addEventListener("click", function() {
            this.parentElement.querySelector(".nested").classList.toggle("active");
            this.classList.toggle("caret2-down");
        });
    }
});
