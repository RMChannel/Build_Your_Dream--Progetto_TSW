<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
  <%User userForUserPage= (User) request.getSession().getAttribute("user");%>
  <title>Build Your Dream - Utente <%=userForUserPage.getUsername()%></title>
  <link rel="icon" type="image/ico" href="<%=request.getContextPath()%>/media/favicon.png">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/user/user.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
  <body>
  <%@ include file="/components/header.jsp" %>
  <div class="parent">
    <div class="div1">
      <div class="user-menu">
        <div class="user-profile">
          <div class="avatar">
            <i class="fa-solid fa-user-circle"></i>
          </div>
          <h3 class="username"><%=userForUserPage.getUsername()%></h3>
        </div>

        <nav class="user-navigation">
          <ul>
            <li>
              <div class="menu-item" id="yourdata" role="button" tabindex="0" onclick="changePage('yourdata')" onkeydown="if(event.key === 'Enter' || event.key === ' ') changePage('yourdata')">
                <i class="fa-solid fa-id-card"></i>
                <span>I tuoi dati</span>
              </div>
            </li>
            <li>
              <div class="menu-item" id="yourbuilds" role="button" tabindex="0" onclick="changePage('yourbuilds')" onkeydown="if(event.key === 'Enter' || event.key === ' ') changePage('yourbuilds')">
                <i class="fa-solid fa-laptop-code"></i>
                <span>Le tue build</span>
              </div>
            </li>
            <li>
              <div class="menu-item" id="yourorders" role="button" tabindex="0" onclick="changePage('yourorders')" onkeydown="if(event.key === 'Enter' || event.key === ' ') changePage('yourorders')">
                <i class="fa-solid fa-shopping-cart"></i>
                <span>I tuoi ordini</span>
              </div>
            </li>
            <li>
              <div class="menu-item" id="changepassword" role="button" tabindex="0" onclick="changePage('changepassword')" onkeydown="if(event.key === 'Enter' || event.key === ' ') changePage('changepassword')">
                <i class="fa-solid fa-key"></i>
                <span>Cambia password</span>
              </div>
            </li>
            <li>
              <div class="menu-item" id="yourcards" role="button" tabindex="0" onclick="changePage('yourcards')" onkeydown="if(event.key === 'Enter' || event.key === ' ') changePage('yourcards')">
                <i class="fa-solid fa-credit-card"></i>
                <span>Le tue carte</span>
              </div>
            </li>
            <li>
              <div class="menu-item logout" role="button" tabindex="0" onclick="logout()" onkeydown="if(event.key === 'Enter' || event.key === ' ') logout()">
                <i class="fa-solid fa-sign-out-alt"></i>
                <span>Logout</span>
              </div>
            </li>
          </ul>
        </nav>
      </div>
    </div>
    <div class="div2">
      <%
      String option=(String) request.getAttribute("option");
      switch (option) {
        case "yourdata":
          %><%@ include file="yourData/yourdata.jsp"%><%
          break;
        case "yourbuilds":
          %><%@ include file="yourBuilds/yourbuilds.jsp"%><%
          break;
        case "yourorders":
          %><%@ include file="yourOrders/yourorders.jsp"%><%
          break;
        case "changepassword":
          %><%@ include file="changePassword/changePassword.jsp"%><%
          break;
        case "yourcards":
          %><%@ include file="yourCards/yourcards.jsp"%><%
          break;
        case "addcard":
          option="yourcards";
          %><%@ include file="addCard/addcard.jsp"%><%
          break;
      }
      %>
    </div>
  </div>
  <%@ include file="/components/footer.jsp" %>
  </body>
<script>
  function changePage(option) {
    const form = document.createElement('form');
    form.method = 'POST';
    form.action = "<%=request.getContextPath()%>/userPage";
    form.target='_self';
    const input1 = document.createElement('input');
    input1.type = 'hidden';
    input1.name = 'option';
    input1.value = option;
    form.appendChild(input1);
    document.body.appendChild(form);
    form.submit();
  }

  function logout() {
    const form = document.createElement('form');
    form.method = 'POST';
    form.action = "logout";
    form.target='_self';
    document.body.appendChild(form);
    form.submit();
  }

  document.addEventListener('DOMContentLoaded', function() {
    let option="<%=option%>";
    if (option && document.getElementById(option)) {
      document.getElementById(option).classList.add('active');
    }
  });
  </script>
</html>
