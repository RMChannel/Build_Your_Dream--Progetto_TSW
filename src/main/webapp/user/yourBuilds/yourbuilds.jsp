<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.Builds.UserBuild" %>
<%
    List<UserBuild> UserBuilds = (List<UserBuild>) request.getAttribute("UserBuilds");
%>
<div class="your-builds-container">
    <h2 class="your-builds-title">Le tue build</h2>
    <div class="your-builds-list">
        <% if (UserBuilds != null && !UserBuilds.isEmpty()) { %>
            <% for (UserBuild build : UserBuilds) { %>
                <div class="build-item">
                    <span class="build-name"><%= build.getNome() %></span>
                    <form method="post" action="MoveToBuilder" class="inline-form">
                        <input type="hidden" name="buildId" value="<%= build.getID() %>" />
                        <button type="submit" class="btn builder-btn">Sposta sul builder</button>
                    </form>
                    <form method="post" action="cancellaBuild" class="inline-form">
                        <input type="hidden" name="buildId" value="<%= build.getID() %>" />
                        <button type="submit" class="btn delete-btn">Cancella</button>
                    </form>
                </div>
            <% } %>
        <% } else { %>
            <div class="no-builds">
                <p>Non hai ancora salvato nessuna build</p>
                <form method="get" action="builder">
                    <button type="submit" class="btn go-builder-btn">Vai al builder</button>
                </form>
            </div>
        <% } %>
    </div>
</div>
<link rel="stylesheet" href="<%=request.getContextPath()%>/user/yourBuilds/yourBuilds.css"/>
