package Model.Accessori;

import java.io.Serializable;
import java.util.Objects;

public class Accessorio implements Serializable {
    private int ID;
    private String marca;
    private String modello;
    private double prezzo;
    private int disponibilita;
    private int sconto;
    private final String TYPE = "Accessorio";

    public Accessorio(int ID, String marca, String modello, double prezzo, int disponibilita, int sconto) {
        this.ID = ID;
        this.marca = marca;
        this.modello = modello;
        this.prezzo = prezzo;
        this.disponibilita = disponibilita;
        this.sconto = sconto;
    }
    public String getTYPE() {
        return TYPE;
    }

    public int getID() {
        return ID;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    public double getPrezzo() {
        return prezzo;
    }

    public double getPrezzoScontato() {
        return prezzo-((prezzo*sconto)/100);
    }

    public void setPrezzo(double prezzo) {
        this.prezzo = prezzo;
    }

    public int getDisponibilita() {
        return disponibilita;
    }

    public void setDisponibilita(int disponibilita) {
        this.disponibilita = disponibilita;
    }

    public boolean isDisponibile() {
        return disponibilita > 0;
    }

    public int getSconto() {
        return sconto;
    }

    public void setSconto(int sconto) {
        this.sconto = sconto;
    }

    public String getMarca() {
        return marca;
    }

    public void setMarca(String marca) {
        this.marca = marca;
    }

    public String getModello() {
        return modello;
    }

    public void setModello(String modello) {
        this.modello = modello;
    }

    @Override
    public String toString() {
        return marca + " " + modello + ", " + prezzo + "€";
    }

    @Override
    public boolean equals(Object o) {
        if (o == null || getClass() != o.getClass()) return false;
        Accessorio that = (Accessorio) o;
        return ID == that.ID && Double.compare(prezzo, that.prezzo) == 0 && disponibilita == that.disponibilita && sconto == that.sconto && Objects.equals(marca, that.marca) && Objects.equals(modello, that.modello) && Objects.equals(TYPE, that.TYPE);
    }
}
