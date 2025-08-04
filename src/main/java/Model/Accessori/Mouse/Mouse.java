package Model.Accessori.Mouse;

import Model.Accessori.Accessorio;
import java.io.Serializable;

public class Mouse extends Accessorio implements Serializable {
    private String categoria;
    private String connectionType;
    private String forma;
    private String sensore;
    private int DPI;
    private double peso;
    private boolean led;

    public Mouse(int ID, String marca, String modello, double prezzo, int disponibilita, int sconto, String categoria, String connectionType, String forma, String sensore, int DPI, double peso, boolean led) {
        super(ID, marca, modello, prezzo, disponibilita, sconto);
        this.categoria = categoria;
        this.connectionType = connectionType;
        this.forma = forma;
        this.sensore = sensore;
        this.DPI = DPI;
        this.peso = peso;
        this.led = led;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public String getConnectionType() {
        return connectionType;
    }

    public void setConnectionType(String connectionType) {
        this.connectionType = connectionType;
    }

    public String getForma() {
        return forma;
    }

    public void setForma(String forma) {
        this.forma = forma;
    }

    public String getSensore() {
        return sensore;
    }

    public void setSensore(String sensore) {
        this.sensore = sensore;
    }

    public int getDPI() {
        return DPI;
    }

    public void setDPI(int DPI) {
        this.DPI = DPI;
    }

    public double getPeso() {
        return peso;
    }

    public void setPeso(double peso) {
        this.peso = peso;
    }

    public boolean isLed() {
        return led;
    }

    public void setLed(boolean led) {
        this.led = led;
    }
}
