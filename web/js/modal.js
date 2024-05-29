
let modais = ["modalCadastro", "modalVisualiza", "modalUpdate"];

function abreModal(modal) {
    document.getElementById(modal).style.display = "block";
}
function fechaModal(modal) {
    document.getElementById(modal).style.display = "none";
}
document.body.onclick = function(event) {
    console.log(event.target);
    if (modais.includes(event.target.id)) {
      fechaModal(event.target.id);

    }
}