package Model.Accessori.StreamDeck;

import Model.Accessori.Accessorio;

import java.io.Serializable;
import java.util.List;

public class StreamDeck extends Accessorio implements Serializable {
    private int nTasti;
    private List<String> tipoTasti;
    private String connectionType;
    private double lunghezza;
    private double larghezza;

    public StreamDeck(int ID, String marca, String modello, double prezzo, int disponibilita, int sconto, int nTasti, List<String> tipoTasti, String connectionType, double lunghezza, double larghezza) {
        super(ID, marca, modello, prezzo, disponibilita, sconto);
        this.nTasti = nTasti;
        this.tipoTasti = tipoTasti;
        this.connectionType = connectionType;
        this.lunghezza = lunghezza;
        this.larghezza = larghezza;
    }

    public int getnTasti() {
        return nTasti;
    }

    public void setnTasti(int nTasti) {
        this.nTasti = nTasti;
    }

    public List<String> getTipoTasti() {
        return tipoTasti;
    }

    public void setTipoTasti(List<String> tipoTasti) {
        this.tipoTasti = tipoTasti;
    }

    public String getConnectionType() {
        return connectionType;
    }

    public void setConnectionType(String connectionType) {
        this.connectionType = connectionType;
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
