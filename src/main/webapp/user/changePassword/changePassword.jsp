<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/user/changePassword/changePassword.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<div class="password-change-container" id="password-change-container">
    <form id="form" action="" method="post" autocomplete="off">
        <div class="form-group">
            <input type="password" id="oldPassword" name="oldPassword" placeholder="Password vecchia" required minlength="8" pattern=".{8,}" title="La password deve essere lunga almeno 8 caratteri" onpaste="return false;" oncopy="return false;">
            <i class="fas fa-lock"></i>
        </div>
        <div class="form-group">
            <input type="password" id="newPassword" name="newPassword" placeholder="Password nuova" required minlength="8" pattern=".{8,}" title="La password deve essere lunga almeno 8 caratteri" onpaste="return false;" oncopy="return false;">
            <i class="fas fa-key"></i>
        </div>
        <div class="form-group">
            <input type="password" id="confirmNewPassword" name="confirmNewPassword" placeholder="Conferma password nuova" required minlength="8" pattern=".{8,}" title="La password deve essere lunga almeno 8 caratteri e corrispondere a quella nuova" onpaste="return false;" oncopy="return false;">
            <i class="fas fa-check-circle"></i>
        </div>
        <input type="submit" value="Cambia password"><br><br>
        <h4 id="errorPassword" class="errorPassword"></h4>
    </form>
</div>
<div id="confirmPasswordChange" class="confirmPasswordChange">
    <h2>La password è stata cambiata con successo</h2>
</div>
<script>
    function checkPassword() {
        event.preventDefault();
        const newPassword=document.getElementById("newPassword").value;
        const confirmNewPassword=document.getElementById("confirmNewPassword").value;
        const errorPassword=document.getElementById("errorPassword");
        if(newPassword!==confirmNewPassword) {
            errorPassword.innerHTML="Le password non corrispondono";
            return;
        }
        if(newPassword.length<8) {
            errorPassword.innerHTML="La password dev'essere lunga almeno 8 caratteri";
            return;
        }
        const formData=new FormData(this);
        fetch('<%=request.getContextPath()%>/userPage/changePassword',{
            method:'POST',
            body:formData,
        }).then(response=>response.json()).then(data=>{
            if(data.status==='success') {
                document.getElementById("password-change-container").style.display="none";
                document.getElementById("confirmPasswordChange").style.display="block";
            }
            else if(data.code===0) {
                errorPassword.innerHTML="Qualcosa è andato storto, riprova";
            }
            else if(data.code===1) {
                errorPassword.innerHTML="Le password non corrispondono";
            }
            else if(data.code===2) {
                errorPassword.innerHTML="La password dev'essere lunga almeno 8 caratteri";
            }
            else if(data.code===3) {
                errorPassword.innerHTML="User is null, check server side";
            }
            else if(data.code===4) {
                errorPassword.innerHTML="La password inserita non è corretta, controlla e riprova";
            }
        });
    }
    document.getElementById("form").addEventListener("submit", checkPassword);
</script>