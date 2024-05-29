<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="css/estilo2.css">
    <title>Acessar</title>

    <script>
        function validarCadastro() {
            var nome_cadastro = frmCadastrarLogin.nome_cad.value;
            var email_cadastro = frmCadastrarLogin.email_cad.value;
            var senha_cadastro = frmCadastrarLogin.senha_cad.value;
            var senha_cadastro_c = frmCadastrarLogin.senha_cad2.value;

            if (nome_cadastro == "") {
                alert('Preencha o campo com seu nome!');
                frmCadastrarLogin.nome_cad.focus();
                return false;
            } else if (email_cadastro == "") {
                alert('Preencha o campo com seu e-mail!');
                frmCadastrarLogin.email_cad.focus();
                return false;
            } else if (senha_cadastro == "" || senha_cadastro.length < 6) {
                alert('Preencha o campo com sua senha! (mínimo de 6 e máximo de 8 caracteres)');
                frmCadastrarLogin.senha_cad.focus();
                return false;
            } else if (senha_cadastro !=  senha_cadastro_c) {
                alert('As senhas não batem! Confirme sua senha');
                frmCadastrarLogin.senha_cad2.focus();
                return false;
            } else {
                alert('Usuário cadastrado com sucesso! \n O e-mail do cadastro ' +
                    email_cadastro + ' terá que ser validado! \n Favor confirmar o cadastro no seu e-mail!');
            }
        }

        function validarLogin() {
            var email_login = formLogin.email_login.value;
            var senha_login = formLogin.senha_login.value;

            if (email_login == "") {
                alert('Preencha o campo com seu e-mail!');
                formLogin.email_login.focus();
                return false;
            } else if (senha_login == "" || senha.login.length < 6) {
                alert('Preencha o campo com sua senha! (mínimo de 6 e máximo de 8 caracteres)');
                formLogin.senha_login.focus();
                return false;
            } else {
                alert('Bem vindo ao Sistema ' + email_login)
            }
        }
        
        if (window.location.hash.substring(1) == ""){
            location.href = 'index.jsp#paralogin';
        }
    </script>
    <script src=""></script>
</head>

<body>
    <div class="sidebar">
        <img src="img/sap-logo.png" alt=""/>
    </div>
    <div class="container">
        <a class="links" id="paracadastro"></a>
        <a class="links" id="paralogin"></a>

        <div class="content">
            
            <!-- FORMULARIO DE LOGIN -->
            <div id="login">
                <h1>Login</h1>
                <form name="formLogin" action="Login_SAP" method="post">
                    
                    <p>
                        <label for="email_login">Seu e-mail</label>
                        <input type="text" name="email_login" id="email_login" 
                               required autocomplete="off"
                               placeholder="ex: contato@sapmail.com">
                    </p>
                    <p>
                        <label for="senha_login">Sua senha</label>
                        <input type="password" name="senha_login" id="senha_login" 
                               required autocomplete="off"
                               placeholder="ex. 123456" maxlength="8">
                    </p>

                    <p>
                        <input type="checkbox" name="manterlogado" id="manterlogado" value="">
                        <label for="manterlogado">Manter-me logado</label>
                    </p>

                    <p>
                        <input type="submit" value="Logar" onclick="return validarLogin()">
                    </p>
                    <p class="link">                        
                        <a href="#paracadastro">Ainda não tem conta? Cadastre-se >>></a>
                    </p>
                </form>
            </div>

            <!-- FORMULARIO DE CADASTRO -->
            <div id="cadastro">
                <h1>Cadastro</h1>
                <form name="frmCadastrarLogin" action="CadastroLogin" method="post">
                    

                    <p>
                        <label for="nome_cad">Nome</label>
                        <input type="text" id="nome_cad" name="nome_cad" 
                               autocomplete="off" required 
                               placeholder="Digite seu nome" />
                    </p>

                    <p>
                        <label for="email_cad">E-mail</label>
                        <input type="email" name="email_cad" id="email_cad" 
                               required autocomplete="off"
                               placeholder="ex: contato@sapmail.com">
                    </p>

                    <p>
                        <label for="senha_cad">Senha</label>
                        <input type="password" name="senha_cad" id="senha_cad" 
                               required autocomplete="off"
                               placeholder="ex: 123456" maxlength="8">
                    </p>
                    
                    <p>
                        <label for="senha_cad2">Confirme sua senha</label>
                        <input type="password" name="senha_cad2" id="senha_cad2" 
                               required autocomplete="off"
                               placeholder="ex: 123456" maxlength="8">
                    </p>
                    <input type="hidden" name="location" value="cadastrado">
                    <p>
                        <input type="submit" value="Cadastrar" onclick="return validarCadastro()">
                    </p>
                    <p class="link">
                        <a href="#paralogin">Já tem cadastro? Faça Login >>></a>
                    </p>
                </form>
            </div>

        </div>
    </div>
</body>
</html>
