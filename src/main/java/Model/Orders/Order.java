package Model.Orders;

import Model.Carrello.Carrello;
import java.sql.Date;

public class Order {
    private int codice;
    private int status;
    private Date data;
    private String id_user;
    private String nTel;
    private int civico;
    private String cap;
    private String via;
    private String citta;
    private String nCarta;
    private Carrello carrello;

    public Order(int codice, int status, Date data, String id_user, String nTel, int civico, String cap, String via, String citta, String nCarta, Carrello carrello) {
        this.codice = codice;
        this.status = status;
        this.data = data;
        this.id_user = id_user;
        this.nTel = nTel;
        this.civico = civico;
        this.cap = cap;
        this.via = via;
        this.citta = citta;
        this.nCarta = nCarta;
        this.carrello = carrello;
    }

    public int getCodice() {
        return codice;
    }

    public void setCodice(int codice) {
        this.codice = codice;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public Date getData() {
        return data;
    }

    public void setData(Date data) {
        this.data = data;
    }

    public String getId_user() {
        return id_user;
    }

    public void setId_user(String id_user) {
        this.id_user = id_user;
    }

    public String getnTel() {
        return nTel;
    }

    public void setnTel(String nTel) {
        this.nTel = nTel;
    }

    public int getCivico() {
        return civico;
    }

    public void setCivico(int civico) {
        this.civico = civico;
    }

    public String getCap() {
        return cap;
    }

    public void setCap(String cap) {
        this.cap = cap;
    }

    public String getVia() {
        return via;
    }

    public void setVia(String via) {
        this.via = via;
    }

    public String getCitta() {
        return citta;
    }

    public void setCitta(String citta) {
        this.citta = citta;
    }

    public String getnCarta() {
        return nCarta;
    }

    public void setnCarta(String nCarta) {
        this.nCarta = nCarta;
    }

    public Carrello getCarrello() {
        return carrello;
    }

    public void setCarrello(Carrello carrello) {
        this.carrello = carrello;
    }

    public double getTotale() {
        return carrello.getTotale();
    }
}
