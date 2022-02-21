//= link_tree ../images
//= link_directory ../stylesheets .css
//= link_tree ../../javascript .js
//= link_tree ../../../vendor/javascript .js

let pages = document.querySelectorAll(".pages > a");
let account = document.querySelector(".account");
let hamburger = document.querySelector("#hamburger");

hamburger.addEventListener("click", function () {
    console.log("test");
    for (let i = 0; i < pages.length; i++) {
        pages[i].classList.toggle("hidden");
    }
    //pages.classList.toggle("hidden");
    account.classList.toggle("hidden");
});
