package Model.Users.Carte;

import java.sql.Date;

public class Carta {
    private String numeroCarta;
    private Date dataDiScadenza;
    private String cvv;
    private String nome;
    private String cognome;

    public Carta(String numeroCarta, Date dataDiScadenza, String cvv, String nome, String cognome) {
        this.numeroCarta = numeroCarta;
        this.dataDiScadenza = dataDiScadenza;
        this.cvv = cvv;
        this.nome = nome;
        this.cognome = cognome;
    }

    public String getNumeroCarta() {
        return numeroCarta;
    }

    public void setNumeroCarta(String numeroCarta) {
        this.numeroCarta = numeroCarta;
    }

    public Date getDataDiScadenza() {
        return dataDiScadenza;
    }

    public void setDataDiScadenza(Date dataDiScadenza) {
        this.dataDiScadenza = dataDiScadenza;
    }

    public String getCVV() {
        return cvv;
    }

    public void setCVV(String cvv) {
        this.cvv = cvv;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getCognome() {
        return cognome;
    }

    public void setCognome(String cognome) {
        this.cognome = cognome;
    }
}
