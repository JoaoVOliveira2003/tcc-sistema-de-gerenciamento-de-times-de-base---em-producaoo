<?php

require __DIR__ . '/../../include/PHPMailer/src/PHPMailer.php';
require __DIR__ . '/../../include/PHPMailer/src/SMTP.php';
require __DIR__ . '/../../include/PHPMailer/src/Exception.php';

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

function corpoEmail($gmailDestino,$nome,$tipoRole,$cod_pessoa) {
    $link='';

    if ($tipoRole == 1) {
        $tipoRole = 'Administrador de sistemas (TI)';
        $link = 'http://localhost/tcc/telas/TI/confirmarDadosTI.php?cod_pessoa=' . urlencode($cod_pessoa) . '&email=' . urlencode($gmailDestino);
    } else if ($tipoRole == 2) {
        $tipoRole = 'Administrador de Instituição (ADMI)';
        $link = 'http://localhost/tcc/telas/ADMI/confirmarDadosADMI.php?cod_pessoa=' . urlencode($cod_pessoa) . '&email=' . urlencode($gmailDestino);
    } else if ($tipoRole == 3) {
        $tipoRole = 'Administrador de Sub-Instituição (ADMS)';
        $link = 'http://localhost/tcc/telas/ADMS/confirmarDadosADMS.php?cod_pessoa=' . urlencode($cod_pessoa) . '&email=' . urlencode($gmailDestino);
    } else if ($tipoRole == 4) {
        $tipoRole = 'Administrador de Sub-Instituição e Staff (ADMS|STAFF)';
        $link = 'http://localhost/tcc/telas/STAFFADMS/confirmarDadosSTAFFADMS.php?cod_pessoa=' . urlencode($cod_pessoa) . '&email=' . urlencode($gmailDestino);
    } else if ($tipoRole == 5) {
        $tipoRole = 'STAFF';
        $link = 'http://localhost/tcc/telas/STAFF/confirmarDadosSTAFF.php?cod_pessoa=' . urlencode($cod_pessoa) . '&email=' . urlencode($gmailDestino);
    } else if ($tipoRole == 6) {
        $tipoRole = 'Jogador';
        $link = 'http://localhost/tcc/telas/JOGADOR/confirmarDadosJOGADOR.php?cod_pessoa=' . urlencode($cod_pessoa) . '&email=' . urlencode($gmailDestino);
    }

    $corpo = '
    <html lang="pt-br">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <style>
            body {
                background-color: #f4f4f4;
                font-family: Arial, sans-serif;
                padding: 20px;
            }
            .email-container {
                max-width: 600px;
                margin: auto;
                background-color: #ffffff;
                border-radius: 8px;
                padding: 30px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            h2 {
                font-weight: bold;
                color: #000000;
                margin-bottom: 20px;
            }
            p {
                font-size: 16px;
                color: #555555;
                line-height: 1.5;
            }
            .btn {
                display: inline-block;
                margin-top: 20px;
                padding: 12px 24px;
                font-size: 16px;
                color: #fff !important;
                background-color: #0d6efd;
                border: 1px solid #0d6efd;
                border-radius: 5px;
                text-decoration: none;
                font-weight: 500;
            }
            .btn:hover {
                background-color: #0b5ed7;
                border-color: #0a58ca;
            }
            .footer {
                margin-top: 30px;
                font-size: 12px;
                color: #999999;
                text-align: center;
            }
        </style>
    </head>
    <body>
        <div class="email-container">
            <h2>Olá <strong>' . htmlspecialchars($nome) . '</strong>,</h2>
            <p>Você foi cadastrado como <strong>' . htmlspecialchars($tipoRole) . '</strong> no <strong>Sistema Gerenciador de Bases</strong>.</p>
            <p>Para ativar sua conta, clique no botão abaixo:</p>
            <a class="btn" href="'.$link.'">Ativar Conta</a>
            <div class="footer">Se você não solicitou esse cadastro, ignore este e-mail.</div>
        </div>
    </body>
    </html>';

    return $corpo;
}

function enviarGmail($gmailDestino,$nome,$tipoRole,$cod_pessoa) {
    $mail = new PHPMailer(true);

    try {
        $mail->CharSet = 'UTF-8';
        $mail->Encoding = 'base64';

        $mail->isSMTP();
        $mail->Host       = 'smtp.gmail.com';
        $mail->SMTPAuth   = true;
        $mail->Username   = 'sistemagerenciadordebases@gmail.com';
        $mail->Password   = 'xjlk uvwm bagk giip';  
        $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS; 
        $mail->Port       = 587;
        
        $mail->setFrom('sistemaGerenciadorDeBases@gmail.com', 'Sistema Gerenciador de Bases');
        $mail->addAddress($gmailDestino, 'Joao');
        
        $textoEmail = corpoEmail($gmailDestino,$nome,$tipoRole,$cod_pessoa);

        $mail->isHTML(true);
        $mail->Subject = 'Email para ativação de conta no Sistema Gerenciador de Bases';
        $mail->Body    = $textoEmail;
        $mail->AltBody = 'Problema na criação do email.';
    
        $mail->send();
    } catch (Exception $e) {
    }
}

function enviarGmailEsqueciSenha($gmailDestino,$cod_pessoa) {
  
    $mail = new PHPMailer(true);

    try {
        $mail->CharSet = 'UTF-8';
        $mail->Encoding = 'base64';

        $mail->isSMTP();
        $mail->Host       = 'smtp.gmail.com';
        $mail->SMTPAuth   = true;
        $mail->Username   = 'sistemagerenciadordebases@gmail.com';
        $mail->Password   = 'xjlk uvwm bagk giip';  
        $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS; 
        $mail->Port       = 587;
        
        $mail->setFrom('sistemaGerenciadorDeBases@gmail.com', 'Sistema Gerenciador de Bases');
        $mail->addAddress($gmailDestino, 'Joao');
        
        $textoEmail = corpoEmailEsqueciSenha($gmailDestino,$cod_pessoa);

        $mail->isHTML(true);
        $mail->Subject = 'Atualização de senha no Sistema Gerenciador de Bases';
        $mail->Body    = $textoEmail;
        $mail->AltBody = 'Problema na criação do email.';
        
        if ($mail->send()){
            return true;
        } else {
            return false;
        }
    } catch (Exception $e) {
    }
}

function corpoEmailEsqueciSenha($gmailDestino, $cod_pessoa) {
    $link = 'http://localhost/tcc/telas/login/telaAtualizarSenha.php?cod_pessoa=' . urlencode($cod_pessoa) . '&email=' . urlencode($gmailDestino);

    $corpo = '
    <html lang="pt-br">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <style>
            body {
                background-color: #f4f4f4;
                font-family: Arial, sans-serif;
                padding: 20px;
            }
            .email-container {
                max-width: 600px;
                margin: auto;
                background-color: #ffffff;
                border-radius: 8px;
                padding: 30px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            h2 {
                font-weight: bold;
                color: #000000;
                margin-bottom: 20px;
            }
            p {
                font-size: 16px;
                color: #555555;
                line-height: 1.5;
            }
            .btn {
                display: inline-block;
                margin-top: 20px;
                padding: 12px 24px;
                font-size: 16px;
                color: #fff !important;
                background-color: #0d6efd;
                border: 1px solid #0d6efd;
                border-radius: 5px;
                text-decoration: none;
                font-weight: 500;
            }
            .btn:hover {
                background-color: #0b5ed7;
                border-color: #0a58ca;
            }
            .footer {
                margin-top: 30px;
                font-size: 12px;
                color: #999999;
                text-align: center;
            }
        </style>
    </head>
    <body>
        <div class="email-container">
            <h2>Redefinição de Senha</h2>
            <p>Olá</p>
            <p>Recebemos uma solicitação para redefinir a senha da sua conta no <strong>Sistema Gerenciador de Bases</strong> associada a este e-mail.</p>
            <p>Se você fez essa solicitação, clique no botão abaixo para criar uma nova senha:</p>
            <a class="btn" href="'.$link.'">Redefinir Senha</a>
            <p>Se você não solicitou a redefinição, nenhuma ação é necessária. Apenas ignore este e-mail.</p>
            <div class="footer">Este é um e-mail automático. Por favor, não responda.</div>
        </div>
    </body>
    </html>';

    return $corpo;
}


//  enviarGmailEsqueciSenha('ojoao953@gmail.com','2')
?>
