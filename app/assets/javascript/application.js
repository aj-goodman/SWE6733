// Entry point for the build script in your package.json
import "./controllers/index"
import * as bootstrap from "bootstrap"

var alertList = document.querySelectorAll('.alert')
var alerts =  [].slice.call(alertList).map(function (element) {
    return new bootstrap.Alert(element)
})

let toast = document.querySelector(".alert");

if (toast !== null) {
    setTimeout(() =>{
        toast.classList.add("active");
    }, 100)
    setTimeout(() =>{
        toast.classList.remove("active");
    }, 4000)
    setTimeout(() =>{
        toast.remove()
    }, 4500)
}
