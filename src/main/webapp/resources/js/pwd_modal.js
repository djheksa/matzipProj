const openPwBtn = document.getElementById("pwd_open");
const pwModal = document.querySelector(".pwModal");

const openPwModal = () => {
    pwModal.classList.remove("hidden");
}
openPwBtn.addEventListener("click",openPwModal);


const closePwBtn = document.querySelector(".closePwModal");
const closePwBg = document.querySelector(".pwBg");

const closePwModal = () => {
    pwModal.classList.add("hidden");
}

closePwBtn.addEventListener("click",closePwModal);
closePwBg.addEventListener("click",closePwModal);
