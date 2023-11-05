if (localStorage.getItem("cookie") !== "") {
    document.cookie = localStorage.getItem("cookie")
} else {
    if (document.cookie === "") {
        window.location.href = window.location.origin
    } else {
        localStorage.setItem("cookie", document.cookie)
    }
}