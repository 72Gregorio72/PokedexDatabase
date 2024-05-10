document.addEventListener("DOMContentLoaded", function() {
function getAverageColor(imageElement, ratio) {
    const canvas = document.createElement("canvas")

    let height = canvas.height = imageElement.naturalHeight
    let width = canvas.width = imageElement.naturalWidth

    const context = canvas.getContext("2d")
    context.drawImage(imageElement, 0, 0)

    let data, length
    let i = -4,
        count = 0

    try {
        data = context.getImageData(0, 0, width, height)
        length = data.data.length
    } catch (err) {
        console.error(err)
        return {
            R: 0,
            G: 0,
            B: 0
        }
    }
    let R, G, B
    R = G = B = 0

    while ((i += ratio * 4) < length) {
        ++count

        R += data.data[i]
        G += data.data[i + 1]
        B += data.data[i + 2]
    }

    R = ~~(R / count)
    G = ~~(G / count)
    B = ~~(B / count)

    return {
        R,
        G,
        B
    }
}

const image = document.getElementById("PokemonImage");
const progressBarHP = document.getElementsByClassName("progress-barHp-fill")[0];
const progressBarATK = document.getElementsByClassName("progress-barAttack-fill")[0];
const progressBarDEF = document.getElementsByClassName("progress-barDefence-fill")[0];
const progressBarSPD = document.getElementsByClassName("progress-barSpeed-fill")[0];
const progressBarSATK = document.getElementsByClassName("progress-barSpecialATK-fill")[0];
const progressBarSDEF = document.getElementsByClassName("progress-barSpecialDEF-fill")[0];

const progressBarHP1 = document.getElementsByClassName("progress-barHp-fill")[1];
const progressBarATK1 = document.getElementsByClassName("progress-barAttack-fill")[1];
const progressBarDEF1 = document.getElementsByClassName("progress-barDefence-fill")[1];
const progressBarSPD1 = document.getElementsByClassName("progress-barSpeed-fill")[1];
const progressBarSATK1 = document.getElementsByClassName("progress-barSpecialATK-fill")[1];
const progressBarSDEF1 = document.getElementsByClassName("progress-barSpecialDEF-fill")[1];

// Funzione per controllare se l'immagine è stata caricata
function isImageLoaded(img) {
    return img.complete && img.naturalHeight !== 0;
}

function applyColorToProgressBars(img) {
    const { R, G, B } = getAverageColor(img, 4);
    progressBarHP.style.backgroundColor = `rgb(${R + 100}, ${G + 100}, ${B + 100})`;
    progressBarATK.style.backgroundColor = `rgb(${R + 100}, ${G + 100}, ${B + 100})`;
    progressBarDEF.style.backgroundColor = `rgb(${R + 100}, ${G + 100}, ${B + 100})`;
    progressBarSPD.style.backgroundColor = `rgb(${R + 100}, ${G + 100}, ${B + 100})`;
    progressBarSATK.style.backgroundColor = `rgb(${R + 100}, ${G + 100}, ${B + 100})`;
    progressBarSDEF.style.backgroundColor = `rgb(${R + 100}, ${G + 100}, ${B + 100})`;

    if(progressBarHP1 != null) {
        progressBarHP1.style.backgroundColor = `rgb(${R + 100}, ${G + 100}, ${B + 100})`;
        progressBarATK1.style.backgroundColor = `rgb(${R + 100}, ${G + 100}, ${B + 100})`;
        progressBarDEF1.style.backgroundColor = `rgb(${R + 100}, ${G + 100}, ${B + 100})`;
        progressBarSPD1.style.backgroundColor = `rgb(${R + 100}, ${G + 100}, ${B + 100})`;
        progressBarSATK1.style.backgroundColor = `rgb(${R + 100}, ${G + 100}, ${B + 100})`;
        progressBarSDEF1.style.backgroundColor = `rgb(${R + 100}, ${G + 100}, ${B + 100})`;
    }

// Applica il nuovo colore
    for (let i = 0; i < 12; i++) {
        const first_half = document.getElementsByClassName("first-half")[i];
        first_half.style.backgroundColor = `rgb(${R}, ${G}, ${B})`;
    }

    for (let i = 0; i < document.getElementsByClassName("PokeImg").length; i++) {
        const pokeImg = document.getElementsByClassName("PokeImg")[i];
        pokeImg.style.backgroundColor = `rgb(${R + 100}, ${G + 100}, ${B + 100})`;
    }

    for (let i = 0; i < document.getElementsByClassName("PokeText").length; i++) {
        const pokeText = document.getElementsByClassName("PokeText")[i];
        pokeText.style.Color = `rgb(${R - 100}, ${G - 100}, ${B - 100})`;
    }
}

// Controlla se l'immagine è già stata caricata
if (isImageLoaded(image)) {
    applyColorToProgressBars(image);
} else {
    // Attendi il caricamento dell'immagine e applica i colori
    image.onload = () => {
        applyColorToProgressBars(image);
    };
}
});