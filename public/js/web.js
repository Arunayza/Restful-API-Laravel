function openPopup(title, sinopsis, posterUrl) {
    document.getElementById("popup-title").innerText = title;
    document.getElementById(
        "popup-sinopsis"
    ).innerHTML = `<strong>Sinopsis:</strong><br>${sinopsis}`;
    document.getElementById("popup-poster").src = posterUrl
        ? posterUrl
        : "default_poster.png";
    document.getElementById("popup").classList.add("show");
}

function closePopup() {
    document.getElementById("popup").classList.remove("show");
}
