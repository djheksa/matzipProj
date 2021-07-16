const openBtn = document.getElementById("login_open");
const modal = document.querySelector(".loginModal");

const openModal = () => {
    modal.classList.remove("hide");
}
openBtn.addEventListener("click",openModal);


const closeBtn = document.querySelector(".loginModal_close");
const closeBg = document.querySelector(".login_bg");

const closeModal = () => {
    modal.classList.add("hide");
}

closeBtn.addEventListener("click",closeModal);
closeBg.addEventListener("click",closeModal);


