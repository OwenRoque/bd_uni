<?php
    session_start();
    require_once("usuarios.php");
    $p = new usuarios();
    $nombre = $_SESSION['nombre'];
    $datos = $p->obtenCursosUsuario($_SESSION['usuario']);
    var_dump($datos, $_SESSION['nombre']);
?>
<!DOCTYPE html>
 <html>

 <head>
   <meta charset="utf-8">
   <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
   <meta name="description" content="Start your development with a Dashboard for Bootstrap 4.">
   <meta name="author" content="Creative Tim">
   <title>Registro de notas</title>
   <!-- Favicon -->
   <link rel="icon" href="./assets/img/brand/favicon.png" type="image/png">
   <!-- Fonts -->
   <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700">
   <!-- Icons -->
   <link rel="stylesheet" href="./assets/vendor/nucleo/css/nucleo.css" type="text/css">
   <link rel="stylesheet" href="./assets/vendor/@fortawesome/fontawesome-free/css/all.min.css" type="text/css">
   <!-- Page plugins -->
   <!-- Argon CSS -->
   <link rel="stylesheet" href="./assets/css/argon.css?v=1.1.0" type="text/css">
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
                            <a class="nav-link" href="#">
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
                                            <a href="#" class="nav-link">
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
                                    <img alt="Image placeholder" src="http://sistemanotasasistencia.test/assets/img/theme/default.png">
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
                                    <li class="breadcrumb-item"><a href="#"><i
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
            <!-- Table -->
            <div class="row">
                <div class="col-12 d-sm-none d-md-block">
                    <div class="card">
                        <!-- Card header -->
                        <form>
                            <div class="card-header border-0">
                            <div class="row">
                                <div class="col-6">
                                <h3 class="mb-0">Notas Alumnos</h3>
                                </div>
                                <div class="col-6 text-right">
                                <a href="#" class="btn btn-sm btn-primary btn-round btn-icon" data-toggle="tooltip" data-original-title="Edit product">
                                    <span class="btn-inner--icon"><i class="fas fa-user-edit"></i></span>
                                    <span class="btn-inner--text">Guardar</span>
                                </a>
                                </div>
                            </div>
                            </div>
                            <!-- Light table -->
                            <div class="table-responsive">
                                <table class="table align-items-center table-flush table-striped">
                                    <thead class="thead-light">
                                        <tr>
                                            <th>CUI</th>
                                            <th>Alumno</th>
                                            <th>NP1</th>
                                            <th>NP2</th>
                                            <th>NP3</th>
                                            <th>NC1</th>
                                            <th>NC2</th>
                                            <th>NC3</th>
                                            <th>NFINAL</th>
                                            <th>GRUPO</th>
                                            <th>AUSENTE</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>20025156</td>
                                            <td>ALDO RAUL MARTINEZ</td>
                                            <td><input class="form-control" type="text" value="8" id="example-text-input"></td>
                                            <td><input class="form-control" type="text" value="8" id="example-text-input"></td>
                                            <td><input class="form-control" type="text" value="8" id="example-text-input"></td>
                                            <td><input class="form-control" type="text" value="12" id="example-text-input"></td>
                                            <td><input class="form-control" type="text" value="13" id="example-text-input"></td>
                                            <td><input class="form-control" type="text" value="20" id="example-text-input"></td>
                                            <td>14</td>
                                            <td><input class="form-control" type="text" value="A" id="example-text-input"></td>
                                            <td><input class="form-control" type="text" value="N" id="example-text-input"></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div> 
    </div>

    <!-- Argon Scripts -->
    <!-- Core -->
    <script src="./assets/vendor/jquery/dist/jquery.min.js"></script>
    <script src="./assets/vendor/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
    <script src="./assets/vendor/js-cookie/js.cookie.js"></script>
    <script src="./assets/vendor/jquery.scrollbar/jquery.scrollbar.min.js"></script>
    <script src="./assets/vendor/jquery-scroll-lock/dist/jquery-scrollLock.min.js"></script>
    <!-- Optional JS -->
    <script src="./assets/vendor/list.js/dist/list.min.js"></script>
    <!-- Argon JS -->
    <script src="./assets/js/argon.js?v=1.1.0"></script>
</body>
</html>