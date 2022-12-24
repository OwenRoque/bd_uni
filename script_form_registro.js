console.clear();
const isEmpty = (str) => str.trim() === '';

function validar () {
    var dni = document.getElementById("dni");
    var nombres = document.getElementById("nombres");
    var apellidos = document.getElementById("apellidos");
    var email = document.getElementById("email");
    var telefono = document.getElementById("telefono");

    dniVal = dni.value;
    nombreVal = nombres.value;
    apellidoVal = apellidos.value;
    emailVal = email.value;
    telefonoVal = telefono.value;

    tablaUsuarios = document.getElementById("tablaUsuarios");

    if( isEmpty(dniVal) || isEmpty(nombreVal) || isEmpty(apellidoVal) || isEmpty(emailVal) || isEmpty(telefonoVal)){
        alert("Todos los campos son OBLIGATORIOS!!!");
        return;
    }
    if (dniVal.length != 8){
        alert("DNI no válido, intente nuevamente.");
        return;
    }
    if (nombreVal.length<=3){
        alert("Nombres mayores a 3 caracteres!");
        return;
    }
    else if (apellidoVal.length<=3){
        alert("Apellidos mayores a 3 caracteres!");
        return;
    }
    else if(telefonoVal.length != 9){
        alert("Ingrese su número de 9 dígitos!");
        return;
    }
    else if((emailVal.includes('.')==false)||(emailVal.includes('@')==false)){
        alert("Formato incorrecto de email. Revise Nuevamente.");
        return;
    }

    //ajax -> agregar
    var contenido = document.getElementById("contenido");
    if (window.XMLHttpRequest){
        ajax = new XMLHttpRequest;
    } else {
        ajax = new ActiveXObject("Microsoft.XMLHTTP");
    }

    ajax.onreadystatechange = function() {
        if (ajax.readyState == 4 && ajax.status == 200){
            contenido.innerHTML = ajax.responseText;
        } else {
            contenido.innerHTML = "<img width='50px' height='50px' src='img/cargando.gif' class='img-thumbnail mx-auto d-block' />"
        }
    }

    ajax.open("POST", "insertar_mostrar.php");
    ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    ajax.send("dni="+dniVal+"&nombres="+nombreVal+"&apellidos="+apellidoVal+"&email="+emailVal+"&telefono="+telefonoVal);
};

function asignar(){
    btnAgregar = document.getElementById('btnAgregar');
    btnAgregar.addEventListener("click",validar);
};

window.addEventListener("load",asignar);

