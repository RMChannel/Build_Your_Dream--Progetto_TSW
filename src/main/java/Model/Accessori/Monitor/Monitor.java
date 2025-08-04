package Model.Accessori.Monitor;

import Model.Accessori.Accessorio;
import java.io.Serializable;

public class Monitor extends Accessorio implements Serializable {
    private int dimensione;
    private String risoluzione;
    private String aspectRatio;
    private String tipo;
    private double responseTime;
    private int frequenza;
    private boolean hdr;
    private boolean casse;

    public Monitor(int ID, String marca, String modello, double prezzo, int disponibilita, int sconto, int dimensione, String risoluzione, String aspectRatio, String tipo, double responseTime, int frequenza, boolean hdr, boolean casse) {
        super(ID, marca, modello, prezzo, disponibilita, sconto);
        this.dimensione = dimensione;
        this.risoluzione = risoluzione;
        this.aspectRatio = aspectRatio;
        this.tipo = tipo;
        this.responseTime = responseTime;
        this.frequenza = frequenza;
        this.hdr = hdr;
        this.casse = casse;
    }

    public int getDimensione() {
        return dimensione;
    }

    public void setDimensione(int dimensione) {
        this.dimensione = dimensione;
    }

    public String getRisoluzione() {
        return risoluzione;
    }

    public void setRisoluzione(String risoluzione) {
        this.risoluzione = risoluzione;
    }

    public String getAspectRatio() {
        return aspectRatio;
    }

    public void setAspectRatio(String aspectRatio) {
        this.aspectRatio = aspectRatio;
    }

    public double getResponseTime() {
        return responseTime;
    }

    public void setResponseTime(double responseTime) {
        this.responseTime = responseTime;
    }

    public int getFrequenza() {
        return frequenza;
    }

    public void setFrequenza(int frequenza) {
        this.frequenza = frequenza;
    }

    public boolean isHdr() {
        return hdr;
    }

    public void setHdr(boolean hdr) {
        this.hdr = hdr;
    }

    public boolean isCasse() {
        return casse;
    }

    public void setCasse(boolean casse) {
        this.casse = casse;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }
}
