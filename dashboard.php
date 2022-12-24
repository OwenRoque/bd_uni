<?php
    session_start();
    require_once("usuarios.php");
    $p = new usuarios();
    $nombre = $_SESSION['nombre'];
    $datos = $p->obtenCursosUsuario($_SESSION['usuario']);
    
?>
<!DOCTYPE html>
 <html>

 <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Start your development with a Dashboard for Bootstrap 4.">
    <meta name="author" content="Creative Tim">
    <meta name="csrf-token" content="6IWxX4zypyu1JdATpIqP4MmgwCaI62Z7BdyiLyKK" />
    <title>Dashboard</title>
    <!-- Favicon -->
    <link rel="icon" href="./assets/img/brand/favicon.ico" type="image/png">
    <!-- Fonts -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700">
    <!-- Icons -->
    <link rel="stylesheet" href="./assets/vendor/nucleo/css/nucleo.css" type="text/css">
    <link rel="stylesheet" href="./assets/vendor/@fortawesome/fontawesome-free/css/all.min.css" type="text/css">
    <!-- Page plugins -->
     <!-- Recibe contenido de una sección llamada 'styles' -->
    <!-- Argon CSS -->
    <link rel="stylesheet" href="./assets/css/argon.css?v=1.1.0" type="text/css">
    <link rel="stylesheet" href="./assets/vendor/sweetalert2/dist/sweetalert2.min.css" type="text/css">
    <!-- Core -->
    <script src="./assets/vendor/jquery/dist/jquery.min.js"></script>

</head>
 <body>
    <!-- Sidenav -->
    <nav class="sidenav navbar navbar-vertical fixed-left navbar-expand-xs navbar-light bg-white" id="sidenav-main">
        <div class="scroll-wrapper scrollbar-inner" style="position: relative;"><div class="scrollbar-inner scroll-content" style="height: 921px; margin-bottom: 0px; margin-right: 0px; max-height: none;">
            <!-- Brand -->
            <div class="sidenav-header d-flex align-items-center">
                <a class="navbar-brand" href="#">
                    <img height="100" width="150" src="./assets/img/brand/logo-unsa-alternative.png" class="navbar-brand-img" alt="...">
                </a>
                <div class="ml-auto">
                    <!-- Sidenav toggler -->
                    <div class="sidenav-toggler d-none d-xl-block active" data-action="sidenav-unpin" data-target="#sidenav-main">
                        <div class="sidenav-toggler-inner">
                            <i class="sidenav-toggler-line"></i>
                            <i class="sidenav-toggler-line"></i>
                            <i class="sidenav-toggler-line"></i>
                        </div>
                    </div>
                </div>
            </div>
            <div class="navbar-inner">
                <!-- Collapse -->
                <div class="collapse navbar-collapse" id="sidenav-collapse-main">
                    <!-- Nav items -->
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link" href="dashboard.php">
                                <i class="fas fa-home text-red"></i>
                                <span class="nav-link-text">Inicio del Sitio</span>
                            </a>
                        </li>
                    </ul>
                    <!-- Divider -->
                    <hr class="my-3">
                    <!-- Heading -->
                    <h6 class="navbar-heading p-0 text-muted">Mis Cursos</h6>
                    <!-- Nav items (Docente) -->
                    <ul class="navbar-nav mb-md-3">
                        <!-- Añadir li de acuerdo a la cantidad de Docente -->                            
                        <?php
                        foreach ($datos as $valor) { ?>
                            <li class="nav-item">
                                <a class="nav-link" href="#navbar-<?php echo $valor[1]; ?>" data-toggle="collapse" role="button" aria-expanded="false" aria-controls="navbar-cursos">
                                    <i class="ni ni-books text-default"></i>
                                    <span class="nav-link-text"><?php echo $valor[0]; ?></span>
                                </a>
                                <div class="collapse" id="navbar-<?php echo $valor[1]; ?>">
                                    <ul class="nav nav-sm flex-column">
                                        <li class="nav-item">
                                            <a href="notas.php?codcurso=<?php echo $valor[1]; ?>" class="nav-link">
                                                Notas 
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                        <?php } ?>
                        <!--Fin Docente-->
                    </ul>
                </div>
            </div>
        </div>
        <div class="scroll-element scroll-x"><div class="scroll-element_outer"><div class="scroll-element_size"></div><div class="scroll-element_track"></div><div class="scroll-bar" style="width: 0px; left: 0px;"></div></div></div><div class="scroll-element scroll-y"><div class="scroll-element_outer"><div class="scroll-element_size"></div><div class="scroll-element_track"></div><div class="scroll-bar" style="height: 0px;"></div></div></div></div>
    </nav>
    <!-- Main content -->
    <div class="main-content" id="panel">
        <!-- Topnav -->
    <nav class="navbar navbar-top navbar-expand navbar-dark bg-gradient-default border-bottom">
        <div class="container-fluid">
          <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <!-- Navbar links -->
            <ul class="navbar-nav align-items-center ml-auto">
                <li class="nav-item dropdown">
                    <a class="nav-link pr-0" href="#" role="button" data-toggle="dropdown" aria-haspopup="true"
                        aria-expanded="false">
                        <div class="media align-items-center">
                                <span class="avatar avatar-sm rounded-circle">
                                    <img alt="Image placeholder" src="./assets/img/theme/default.png">
                                </span>
                            <div class="media-body ml-2 d-none d-lg-block">
                                <span class="mb-0 text-sm  font-weight-bold"><?php echo $nombre; ?></span>
                            </div>
                        </div>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right">
                        <div class="dropdown-header noti-title">
                            <h6 class="text-overflow m-0">Bienvenido!</h6>
                        </div>
                        <div class="dropdown-divider"></div>
                        <a href="#" class="dropdown-item"
                            onclick="event.preventDefault();
                                        document.getElementById('logout-form').submit();">
                            <i class="ni ni-user-run"></i>
                            <span>Logout</span>
                        </a>
                        <form id="logout-form" action="logout.php" method="POST" class="d-none">    
                        </form>
                    </div>
                </li>
            </ul>
          </div>
        </div>
      </nav>
        <!-- Header -->
        <div class="header bg-gradient-default pb-6">
            <div class="container-fluid">
                <div class="header-body">
                    <div class="row align-items-center py-4">
                        <div class="col-lg-6 col-7">
                            <h6 class="h2 text-white d-inline-block mb-0"><?php echo $nombre; ?></h6>
                            <nav aria-label="breadcrumb" class="d-none d-md-inline-block ml-md-4">
                                <ol class="breadcrumb breadcrumb-links breadcrumb-dark">
                                    <li class="breadcrumb-item"><a href="dashboard.php"><i
                                                class="fas fa-home"></i></a></li>
                                    <li class="breadcrumb-item active" aria-current="page"><a
                                            href="#">Notas</a></li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Page content -->
        <div class="container-fluid mt--6">
        <!-- DUTIC homepage -->
            <div class="row card-wrapper">
                <div class="col-lg-4 col-md-6">
                    <!-- Basic with card header -->
                    <div class="card">
                        <!-- Card header -->
                        <div class="card-header">
                            <!-- Title -->
                            <h5 class="h3 mb-0 text-center">Ayuda Estudiante</h5>
                        </div>
                        <!-- Card image -->
                        <object class="card-img-top" data="./assets/img/theme/ayuda-estudiante.svg"></object>
                        <!-- List group -->
                        <!-- Card body -->
                        <div class="card-footer">
                            <a type="button" target="_blank" href="https://dutic.unsa.edu.pe/#/videoandresources/students" class="btn btn-outline-default btn-lg btn-block">Acceder</a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <!-- Basic with card header -->
                    <div class="card">
                        <!-- Card header -->
                        <div class="card-header">
                            <!-- Title -->
                            <h5 class="h3 mb-0 text-center">App DUTIC</h5>
                        </div>
                        <!-- Card image -->
                        <object class="card-img-top" data="./assets/img/theme/app-dutic.svg"></object>
                        <!-- List group -->
                        <!-- Card body -->
                        <div class="card-footer">
                            <a type="button" target="_blank" href="https://play.google.com/store/apps/details?id=com.moodle.moodlemobile" class="btn btn-outline-default btn-lg btn-block">Acceder</a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="card bg-gradient-teal border-0">
                        <!-- Card body -->
                        <div class="card-body">
                            <div class="row">
                                <div class="col">
                                    <h4 class="card-title widget-calendar-year text-muted mb-0 text-white">2022</h4>
                                    <span class="h1 display-1 font-weight-bold widget-calendar-day mb-0 text-white">23 de diciembre, 10:44 pm</span>
                                </div>
                                <div class="col-auto">
                                    <div class="icon icon-shape bg-gradient-white text-teal rounded-circle shadow">
                                        <i class="ni ni-calendar-grid-58"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row card-wrapper justify-content-center">
                <div class="col-lg-4 col-md-6">
                    <!-- Basic with card header -->
                    <div class="card">
                        <!-- Card header -->
                        <div class="card-header">
                            <!-- Title -->
                            <h5 class="h3 mb-0 text-center">Ayuda Docente</h5>
                        </div>
                        <!-- Card image -->
                        <object class="card-img-top" data="./assets/img/theme/ayuda-Docente.svg"></object>
                        <!-- List group -->
                        <!-- Card body -->
                        <div class="card-footer">
                            <a type="button" target="_blank" href="https://dutic.unsa.edu.pe/#/videoandresources/teachers" class="btn btn-outline-default btn-lg btn-block">Acceder</a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <!-- Basic with card header -->
                    <div class="card">
                        <!-- Card header -->
                        <div class="card-header">
                            <!-- Title -->
                            <h5 class="h3 mb-0 text-center">Material Digital UNSA</h5>
                        </div>
                        <!-- Card image -->
                        <object class="card-img-top" data="./assets/img/theme/material-digital.svg"></object>
                        <!-- List group -->
                        <!-- Card body -->
                        <div class="card-footer">
                            <a type="button" target="_blank" href="https://dutic.unsa.edu.pe/#/virtualLearning" class="btn btn-outline-default btn-lg btn-block">Acceder</a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                <!-- Basic with card header -->
                <div class="card">
                    <!-- Card header -->
                    <div class="card-header">
                        <!-- Title -->
                        <h5 class="h3 mb-0 text-center">Boletín Informativo DUTIC</h5>
                    </div>
                    <!-- Card image -->
                    <object class="card-img-top" data="./assets/img/theme/boletin-informativo.svg"></object>
                    <!-- List group -->
                    <!-- Card body -->
                    <div class="card-footer">
                        <a type="button" target="_blank" href="https://dutic.unsa.edu.pe/#/news/newsletter" class="btn btn-outline-default btn-lg btn-block">Acceder</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Argon Scripts -->
<!-- Core -->
<script src="./assets/vendor/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
<script src="./assets/vendor/js-cookie/js.cookie.js"></script>
<script src="./assets/vendor/jquery.scrollbar/jquery.scrollbar.min.js"></script>
<script src="./assets/vendor/jquery-scroll-lock/dist/jquery-scrollLock.min.js"></script>
<script src="./assets/vendor/sweetalert2/dist/sweetalert2.all.min.js"></script>
<!-- Optional JS -->
        <!-- Optional JS -->
    <script src="./assets/vendor/moment/min/moment-with-locales.min.js"></script>
    <script src="./assets/js/vendor.js" ></script>
    <script title="Display Dinamic Current Date">
        moment.locale('es');
        var mYear = moment().format('YYYY');
        $('.widget-calendar-year').html(mYear);

        var datetime = null,
            date = null;
        var update = function () {
            date = moment(new Date())
            datetime.html(date.format('D [de] MMMM, h:mm a'));
        };

        $(document).ready(function(){
            datetime = $('.widget-calendar-day')
            update();
            setInterval(update, 1000);
        });
    </script>
<!-- Argon JS -->
<script src="./assets/js/argon.js?v=1.1.0"></script>
</body>
</html>
