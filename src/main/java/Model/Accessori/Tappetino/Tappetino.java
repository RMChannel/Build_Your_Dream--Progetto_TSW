package Model.Accessori.Tappetino;

import Model.Accessori.Accessorio;
import java.io.Serializable;

public class Tappetino extends Accessorio implements Serializable {
    private boolean led;
    private double lunghezza;
    private double larghezza;

    public Tappetino(int ID, String marca, String modello, double prezzo, int disponibilita, int sconto, boolean led, double lunghezza, double larghezza) {
        super(ID, marca, modello, prezzo, disponibilita, sconto);
        this.led = led;
        this.lunghezza = lunghezza;
        this.larghezza = larghezza;
    }

    public boolean isLed() {
        return led;
    }

    public void setLed(boolean led) {
        this.led = led;
    }

    public double getLunghezza() {
        return lunghezza;
    }

    public void setLunghezza(double lunghezza) {
        this.lunghezza = lunghezza;
    }

    public double getLarghezza() {
        return larghezza;
    }

    public void setLarghezza(double larghezza) {
        this.larghezza = larghezza;
    }
}
