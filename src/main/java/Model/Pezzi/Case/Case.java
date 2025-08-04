package Model.Pezzi.Case;

import Model.Pezzi.Pezzo;

import java.io.Serializable;

public class Case extends Pezzo implements Serializable {
    private String categoria;
    private double altezza;
    private double larghezza;
    private double profondita;
    private double peso;
    private String dotazione;

    public Case(int ID, String marca, String modello, double prezzo, int disponibilita, int sconto, String categoria, double altezza, double larghezza, double profondita, double peso, String dotazione) {
        super(ID, marca, modello, prezzo, disponibilita, sconto);
        this.categoria = categoria;
        this.altezza = altezza;
        this.larghezza = larghezza;
        this.profondita = profondita;
        this.peso = peso;
        this.dotazione = dotazione;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public double getAltezza() {
        return altezza;
    }

    public void setAltezza(double altezza) {
        this.altezza = altezza;
    }

    public double getLarghezza() {
        return larghezza;
    }

    public void setLarghezza(double larghezza) {
        this.larghezza = larghezza;
    }

    public double getProfondita() {
        return profondita;
    }

    public void setProfondita(double profondita) {
        this.profondita = profondita;
    }

    public double getPeso() {
        return peso;
    }

    public void setPeso(double peso) {
        this.peso = peso;
    }

    public String getDotazione() {
        return dotazione;
    }

    public void setDotazione(String dotazione) {
        this.dotazione = dotazione;
    }
}
