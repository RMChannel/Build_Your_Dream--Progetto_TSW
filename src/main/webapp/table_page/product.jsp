<%@ page import="Foto.FotoDAO" %>
<%@ page import="Model.Pezzi.Cooling.LiquidCooling" %>
<%@ page import="Model.Pezzi.Cooling.AirCooling" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <title>Build Your Dream - <%=request.getAttribute("marca")+" "+request.getAttribute("modello")%></title>
    <link rel="icon" type="image/ico" href="<%=request.getContextPath()%>/media/favicon.png">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/table_page/product.css">
</head>
    <body>
    <%@ include file="/components/header.jsp"%>
    <%
        Object obj = request.getAttribute("pezzo");
        String tipo = (String) request.getAttribute("type");
        String marca = (String) request.getAttribute("marca");
        String modello = (String) request.getAttribute("modello");
        String coolingType = "";
        if(obj instanceof LiquidCooling) {
            coolingType="LiquidCooling";
        }
        else if(obj instanceof AirCooling) {
            coolingType="AirCooling";
        }
        int id = -1;
        double prezzo = 0;
        double prezzoScontato = 0;
        int disponibilita = 0;
        int sconto = 0;
        String descrizione = "";
        boolean disponibile = false;
        if(obj != null) {
            try {
                if("pezzo".equals(tipo) || "accessorio".equals(tipo)) {
                    id = (Integer) obj.getClass().getMethod("getID").invoke(obj);
                    prezzo = (Double) obj.getClass().getMethod("getPrezzo").invoke(obj);
                    sconto = (Integer) obj.getClass().getMethod("getSconto").invoke(obj);
                    prezzoScontato = (Double) obj.getClass().getMethod("getPrezzoScontato").invoke(obj);
                    disponibile = (Boolean) obj.getClass().getMethod("isDisponibile").invoke(obj);
                    java.lang.reflect.Method[] methods = obj.getClass().getMethods();
                    StringBuilder sb = new StringBuilder();
                    for(java.lang.reflect.Method m : methods) {
                        String name = m.getName();
                        if(name.startsWith("get") && !name.equals("getID") && !name.equals("getPrezzo") && !name.equals("getPrezzoScontato") && !name.equals("getMarca") && !name.equals("getModello") && !name.equals("getSconto") && !name.equals("getDisponibilita") && !name.equals("getClass") && !name.equals("getTYPE")) {
                            try {
                                Object value = m.invoke(obj);
                                if(value != null) {
                                    String label = name.substring(3); // Rimuove "get"
                                    // Format camel case in modo leggibile
                                    label = label.replaceAll("([A-Z])", " $1").trim();
                                    if(name.startsWith("getPeso")) sb.append(label).append(": ").append(value.toString()+"g").append("<br/>");
                                    else if(name.startsWith("getLunghezza") || name.startsWith("getLarghezza") || name.startsWith("getAltezza") || name.startsWith("getProfondita")) sb.append(label).append(": ").append(value.toString()+"mm").append("<br/>");
                                    else if(name.startsWith("getDimensione")) sb.append(label).append(": ").append(value.toString()+"\"").append("<br/>"); // pollici
                                    else if(name.startsWith("getCapacita")) sb.append(label).append(": ").append(value.toString()+"GB").append("<br/>");
                                    else if(name.startsWith("getMemoria")) sb.append(label).append(": ").append(value.toString()+"GB").append("<br/>");
                                    else if(name.startsWith("getReadSpeed") || name.startsWith("getWriteSpeed")) sb.append(label).append(": ").append(value.toString()+"MB/s").append("<br/>");
                                    else if(name.startsWith("getFrequenza") || name.startsWith("getFrequenzaRAM") || name.startsWith("getFrequenzaBase") || name.startsWith("getFrequenzaBoost")) sb.append(label).append(": ").append(value.toString()+"MHz").append("<br/>");
                                    else if(name.startsWith("getBaseFrequence") || name.startsWith("getTurboFrequence")) sb.append(label).append(": ").append(value.toString()+"GHz").append("<br/>");
                                    else if(name.startsWith("getTDP") || name.startsWith("getPotenza")) sb.append(label).append(": ").append(value.toString()+"W").append("<br/>");
                                    else if(name.startsWith("getMaxRPM")) sb.append(label).append(": ").append(value.toString()+"RPM").append("<br/>");
                                    else if(name.startsWith("getDPI")) sb.append(label).append(": ").append(value.toString()+" DPI").append("<br/>");
                                    else if(name.startsWith("getResponseTime")) sb.append(label).append(": ").append(value.toString()+"ms").append("<br/>");
                                    else sb.append(label).append(": ").append(value.toString()).append("<br/>");
                                }
                            } catch(Exception ex) {}
                        }
                        if(name.startsWith("is") && !name.equals("isDisponibile")) {
                            try {
                                Object value = m.invoke(obj);
                                if(value != null) {
                                    String label = name.substring(2); // Rimuove "is"
                                    label = label.replaceAll("([A-Z])", " $1").trim();
                                    sb.append(label).append(": ").append(value.toString()).append("<br/>");
                                }
                            } catch(Exception ex) {}
                        }
                    }
                    descrizione = sb.length() > 0 ? sb.toString() : obj.toString();
                    descrizione = descrizione.replaceAll("true","Si");
                    descrizione = descrizione.replaceAll("false","No");
                }
            } catch(Exception e) {
                descrizione = "Errore lettura dati prodotto";
            }
        }
    %>
    <div id="product-container">
        <div>
            <%
                FotoDAO fotoDAO=new FotoDAO();
                String path="";
                String type=request.getParameter("type");
                if(type.equals("Tappetino")) type="Tappetini";
                else if(type.equals("Tastiera")) type="Tastiere";
                if(tipo.equals("accessorio")) {
                    path=fotoDAO.getFoto(id,"fotoAccessori",type, (String) request.getAttribute("realPath"));
                }
                else {
                    path=fotoDAO.getFoto(id,"fotoPezzi",type, (String) request.getAttribute("realPath"));
                }
            %>
            <img id="product-img" src="<%=path%>" alt="Foto prodotto">
        </div>
        <div class="product-details">
            <h2><%=marca%> <%=modello%></h2>
            <div class="descrizione">
                <%=descrizione != null && !descrizione.isEmpty() ? descrizione : "Prodotto non trovato" %>
            </div>
            <ul>
                <li><b>ID:</b> <%=id != -1 ? id : "-" %></li>
                <li><b>Marca:</b> <%=marca != null ? marca : "-" %></li>
                <li><b>Modello:</b> <%=modello != null ? modello : "-" %></li>
                <li><b>Prezzo:</b>
                    <% if (sconto > 0 && prezzo > 0 && prezzoScontato > 0) { %>
                        <span class="prezzo-barrato"> <%=prezzo + "€"%> </span><br/>
                        <span class="prezzo-scontato"> <%= String.format("%.2f", prezzoScontato) + "€" %> </span>
                        <span class="sconto"> (-<%=sconto%>%)</span>
                    <% } else { %>
                        <span class="prezzo-normale"> <%=prezzo > 0 ? prezzo + "€" : "-" %> </span>
                    <% } %>
                </li>
            </ul>
            <button class="acquista" onclick="acquista('<%=id%>')" <%=disponibile ? "" : "disabled"%>><%= disponibile ? "Aggiungi al carrello" : "Non disponibile" %></button>
            <% if (tipo.equals("pezzo")) {
                %><div> <button name="aggiungiBuilder" class="acquista" type="button" onclick="addToBuilder('<%=request.getAttribute("piece")%>', '<%=id%>')">Aggiungi al builder</button></div><%
            }
            %>

        </div>
    </div>
    <script>
    function acquista(id) {
        const data = new URLSearchParams();
        data.append('id', id);
        data.append('type', '<%= tipo %>');
        data.append('table', '<%= type %>');
        data.append('coolingType','<%=coolingType%>');
        console.log('<%=tipo%> <%=type%> <%=coolingType%>');
        fetch('<%= request.getContextPath() %>/addToCarrello', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: data
        })
            .then(response => {
                if (!response.ok) throw new Error("Errore nella richiesta");
                return response.text(); // o .json() se il server restituisce JSON
            })
            .then(result => {
                window.location.href = '<%=request.getContextPath()%>/carrello';
            })
            .catch(error => {
                console.error("Errore:", error);
            });
    }
    function addToBuilder(type, id) {
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = "<%=request.getContextPath()%>/addToBuilder";
        form.target='_self';
        const input1 = document.createElement('input');
        input1.type = 'hidden';
        input1.name = 'type';
        input1.value = type;
        const input2 = document.createElement('input');
        input2.type = 'hidden';
        input2.name = 'ID';
        input2.value = id;
        console.log(type, id);
        form.appendChild(input1);
        form.appendChild(input2);
        document.body.appendChild(form);
        form.submit();
    }
    </script>
    <%@ include file="/components/footer.jsp"%>
    </body>
</html>
