package Model.Accessori.Tastiera;

import Model.Accessori.Accessorio;
import java.io.Serializable;

public class Tastiera extends Accessorio implements Serializable {
    private String categoria;
    private String layout;
    private boolean compatta;
    private boolean led;
    private String connettivita;
    private double larghezza;
    private double lunghezza;
    private double peso;

    public Tastiera(int ID, String marca, String modello, double prezzo, int disponibilita, int sconto, String categoria, String layout, boolean compatta, boolean led, String connettivita, double larghezza, double lunghezza, double peso) {
        super(ID, marca, modello, prezzo, disponibilita, sconto);
        this.categoria = categoria;
        this.layout = layout;
        this.compatta = compatta;
        this.led = led;
        this.connettivita = connettivita;
        this.larghezza = larghezza;
        this.lunghezza = lunghezza;
        this.peso = peso;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public String getLayout() {
        return layout;
    }

    public void setLayout(String layout) {
        this.layout = layout;
    }

    public boolean isCompatta() {
        return compatta;
    }

    public void setCompatta(boolean compatta) {
        this.compatta = compatta;
    }

    public boolean isLed() {
        return led;
    }

    public void setLed(boolean led) {
        this.led = led;
    }

    public String getConnettivita() {
        return connettivita;
    }

    public void setConnettivita(String connettivita) {
        this.connettivita = connettivita;
    }

    public double getLarghezza() {
        return larghezza;
    }

    public void setLarghezza(double larghezza) {
        this.larghezza = larghezza;
    }

    public double getLunghezza() {
        return lunghezza;
    }

    public void setLunghezza(double lunghezza) {
        this.lunghezza = lunghezza;
    }

    public double getPeso() {
        return peso;
    }

    public void setPeso(double peso) {
        this.peso = peso;
    }
}
