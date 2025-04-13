<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Exemplo de Alerta Personalizado</title>

    <!-- <script src="/tcc/include/jquery/jquery.js"></script>
    <script src="/tcc/include/jquery/jquery-confirm.min.css"></script>
    <script src="/tcc/include/jquery/jquery-confirm.min.js"></script> -->

    <?php include('include/includeBase.php'); ?> 

<script>

        function alert(mensagem, titulo, width, funcao) {
            if (typeof (titulo) == "function") {
                funcao = titulo;
                titulo = 'ALERTA';
            }

            if (typeof (titulo) != 'string') {
                titulo = 'ALERTA';
            }

            if (typeof (width) == "undefined") {
                width = "60%";
            }

            // Ajuste para dispositivos móveis
            if (/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)) {
                width = 'auto';
            }

            mensagem = String(mensagem).replace("\n", "<br>");

            return $.confirm({
                title: `<div style="display: flex; justify-content: space-between; align-items: center;">
                            <h2><b>${titulo}</b></h2>
                        </div>`,
                content: `<div>${mensagem}</div>`,
                type: 'green',
                typeAnimated: false,
                useBootstrap: false,
                boxWidth: width,
                columnClass: 'medium',
                backgroundDismiss: false,
                closeIcon: false,
                onOpenBefore: function () {
                    // Guarda a função em variável global temporária para uso no botão "X"
                    window.__alertCallback = funcao;
                },
                buttons: {
                    "btFechar": {
                        text: "Fechar",
                        btnClass: "btn-green",
                        action: function () {
                            if (typeof funcao === "function") {
                                setTimeout(funcao, 0);
                            }
                            window.__alertCallback = null;
                        }
                    }
                }
            });
        }
    </script>
</head>
<body>
    <button onclick="alert('Mensagem de exemplo\nCom quebra de linha', 'Aviso', '40%', function(){ console.log('Fechou o alerta'); })">
        Abrir Alerta
    </button>
</body>
</html>
