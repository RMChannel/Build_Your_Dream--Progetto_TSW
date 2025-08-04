package Model.Accessori.Headset;

import Model.Accessori.Accessorio;
import java.io.Serializable;

public class HeadSet extends Accessorio implements Serializable {
    private String categoria;
    private boolean microfono;
    private String connectionType;
    private boolean led;

    public HeadSet(int ID, String marca, String modello, double prezzo, int disponibilita, int sconto, String categoria, boolean microfono, String connectionType, boolean led) {
        super(ID, marca, modello, prezzo, disponibilita, sconto);
        this.categoria = categoria;
        this.microfono = microfono;
        this.connectionType = connectionType;
        this.led = led;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public boolean isMicrofono() {
        return microfono;
    }

    public void setMicrofono(boolean microfono) {
        this.microfono = microfono;
    }

    public String getConnectionType() {
        return connectionType;
    }

    public void setConnectionType(String connectionType) {
        this.connectionType = connectionType;
    }

    public boolean isLed() {
        return led;
    }

    public void setLed(boolean led) {
        this.led = led;
    }
}
