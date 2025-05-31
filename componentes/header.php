<?php
require('../../include/conecta.php');
$bd = conecta();
$retorno = '';

/*
mostra tudo - 0
TI - 1
ADMI - 2
ADMS - 3
ADMS|STAFF - 4
STAFF - 5
jogadores - 6
*/

$cod_tipo_role = 1;

if ($cod_tipo_role == 0) {
  $query = "SELECT 
  sim.cod_subitem_menu,
  MAX(sim.label) AS submenu_label,
  MAX(sim.href) AS submenu_href,
  MAX(im.cod_item_menu) AS cod_item_menu,
  MAX(im.role_html) AS menu_principal,
  MAX(tr.cod_tipo_role) AS cod_tipo_role,
  MAX(tr.desc_tipo_role) AS desc_tipo_role
FROM item_menu im
INNER JOIN itemMenu_subitemMenu imsm 
  ON im.cod_item_menu = imsm.cod_item_menu
INNER JOIN subitem_menu sim 
  ON sim.cod_subitem_menu = imsm.cod_subitem_menu
INNER JOIN tipo_role tr 
  ON tr.cod_tipo_role = imsm.cod_tipo_role
GROUP BY sim.cod_subitem_menu;
";
} else {
  $query = "SELECT 
  im.cod_item_menu,             
  im.role_html AS menu_principal,
  sim.cod_subitem_menu,         
  sim.label AS submenu_label,      
  sim.href AS submenu_href,        
  tr.cod_tipo_role,              
  tr.desc_tipo_role                 
FROM item_menu im
INNER JOIN itemMenu_subitemMenu imsm 
  ON im.cod_item_menu = imsm.cod_item_menu
INNER JOIN subitem_menu sim 
  ON sim.cod_subitem_menu = imsm.cod_subitem_menu
INNER JOIN tipo_role tr 
  ON tr.cod_tipo_role = imsm.cod_tipo_role
 WHERE tr.cod_tipo_role = $cod_tipo_role  
ORDER BY im.cod_item_menu, sim.cod_subitem_menu
";

}
$executou = $bd->SqlExecuteQuery($query);

// Início do container e header com estilo Bootstrap
$retorno .= '<div class="container">';
$retorno .= '<header class="d-flex flex-wrap justify-content-between align-items-center py-3 mb-4 border-bottom">';
$retorno .= '<a href="/tcc/telas/login/telaPosLogin.php" class="d-flex align-items-center mb-3 mb-md-0 text-dark text-decoration-none">';
$retorno .= '<span class="fs-4">Sistema Gerenciador de Bases</span>';
$retorno .= '</a>';
$retorno .= '<ul class="nav nav-pills">';
$retorno .= '<li class="nav-item"><a href="/tcc/telas/login/telaPosLogin.php" class="nav-link active" aria-current="page">Home</a></li>';

if ($executou && $bd->SqlNumRows() > 0) {
  $ultimoMenu = null;

  do {
    $menu_principal = $bd->SqlQueryShow('menu_principal');
    $submenu_label = $bd->SqlQueryShow('submenu_label');
    $submenu_href = $bd->SqlQueryShow('submenu_href');

    if ($menu_principal != $ultimoMenu) {
      if ($ultimoMenu !== null) {
        $retorno .= '</ul></li>';
      }

      $retorno .= '<li class="nav-item dropdown">';
      $retorno .= '<a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown">' . $menu_principal . '</a>';
      $retorno .= '<ul class="dropdown-menu">';

      $ultimoMenu = $menu_principal;
    }

    $retorno .= '<li><a class="dropdown-item" href="' . $submenu_href . '">' . $submenu_label . '</a></li>';

  } while ($bd->SqlFetchNext());

  $retorno .= '</ul></li>';
}
$retorno .= '</ul>';
$retorno .= '</header>';
$retorno .= '</div>';

$bd->SqlDisconnect();
echo $retorno;
?>