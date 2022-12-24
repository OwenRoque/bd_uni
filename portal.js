const isEmpty = (str) => str.trim() === '';

function acceder(){
    var usua = document.getElementById("usuario");
    var clave = document.getElementById("contrasena");
    usuaVal = usua.value;
    claveVal = clave.value;

    if (isEmpty(usuaVal)||isEmpty(claveVal)){
        alert("Todos los campos son obligatorios!");
        return;
    }

    //ajax -> agregar
    var contenido = document.getElementById("mensaje");
    if (window.XMLHttpRequest){
        ajax = new XMLHttpRequest;
    } else {
        ajax = new ActiveXObject("Microsoft.XMLHTTP");
    }

    ajax.onreadystatechange = function() {
        if (ajax.readyState == 4 && ajax.status == 200){
            if (ajax.responseText.trim() == "OK"){
                window.location.href = "dashboard.php";
            }
        }
    }

    ajax.open("POST", "validar_login.php");
    ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    ajax.send("usuario="+usuaVal+"&clave="+claveVal);
};

function asignar(){
    btnAcceder = document.getElementById('btnAcceder');
    btnAcceder.addEventListener("click",acceder);
};

window.addEventListener("load",asignar);
