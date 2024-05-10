// Rimuovi la funzione getData e utilizza direttamente le variabili JSP

const stats = ['Speed', 'Special Defense', 'Special Attack', 'Defense', 'Attack', 'HP'];

const $screen = document.querySelector('#screen');
const $image = document.querySelector('#image');
const $pokedex = document.querySelector('#pokedex');
const $light = document.querySelector('#light');
const speech = window.speechSynthesis;
const graphColor = document.getElementById('graphColor');
console.log(document.getElementById('graphColor'));

window.addEventListener('DOMContentLoaded', () => {
    $pokedex.classList.add('is-active');

    // Utilizza direttamente le variabili JSP per ottenere i dati
    const pokemonName = '<%= pokemonName %>';
    const pokemonStats = [<%= hp %>, <%= attack %>, <%= defence %>, <%= speed %>, <%= specialATK %>, <%= specialDEF %>];
    const pokemonImage = '<%= image %>';

    $light.classList.add('is-animated');

    const dataset = {
        label: pokemonName,
        data: pokemonStats,
        backgroundColor: document.getElementById('graphColor'),
    }
    const chart = createChart(dataset, stats);
    $image.setAttribute('src', pokemonImage);
    $screen.style.backgroundImage = '';
});

const chartContext = document.querySelector('#stats').getContext('2d');
function createChart(dataset, labels) {
    return new Chart(chartContext, {
        type: 'radar',
        data: {
            labels: stats,
            datasets: [dataset]
        },
        options: {
            maintainAspectRatio: false,
        }
    })
}