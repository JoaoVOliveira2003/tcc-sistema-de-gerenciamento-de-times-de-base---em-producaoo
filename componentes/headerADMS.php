<?php
require('../include/conecta.php');
$bd = conecta();
$retorno = '';

$cod_tipo_role = 3;

$query = "SELECT 
  im.cod_item_menu,                  -- Código do menu principal
  im.role_html AS menu_principal,   -- Nome do menu principal
  sim.cod_subitem_menu,             -- Código do submenu
  sim.label AS submenu_label,       -- Nome do submenu
  sim.href AS submenu_href,         -- Link do submenu
  tr.cod_tipo_role,                 -- Código do tipo de usuário
  tr.desc_tipo_role                 -- Nome do tipo de usuário
FROM item_menu im
INNER JOIN itemMenu_subitemMenu imsm 
  ON im.cod_item_menu = imsm.cod_item_menu
INNER JOIN subitem_menu sim 
  ON sim.cod_subitem_menu = imsm.cod_subitem_menu
INNER JOIN tipo_role tr 
  ON tr.cod_tipo_role = imsm.cod_tipo_role
WHERE tr.cod_tipo_role = $codTipoUsuario  
ORDER BY im.cod_item_menu, sim.cod_subitem_menu;
";

echo "<!-- Query: $query -->";

?>
<!-- 
<div class="container">
  <header class="d-flex flex-wrap justify-content-between align-items-center py-3 mb-4 border-bottom">
    <a href="/tcc/telas/login/telaPosLogin.php" class="d-flex align-items-center mb-3 mb-md-0 text-dark text-decoration-none">
      <span class="fs-4">Sistema Gerenciador de Bases</span>
    </a>

    <ul class="nav nav-pills">
      <li class="nav-item"><a href="/tcc/telas/login/telaPosLogin.php" class="nav-link active" aria-current="page">Home</a></li>
      
    </ul>
  </header>
</div>
 -->
