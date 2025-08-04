package Model.Pezzi.Cooling;

import Model.Pezzi.Pezzo;
import java.io.Serializable;

public class AirCooling extends Pezzo implements Serializable {
    private String socket;
    private double altezza;
    private double lunghezza;
    private double larghezza;
    private int nVentole;
    private int dimVentola;
    private int maxRPM;
    private boolean rgb;
    private int TDP;
    private String colore;

    public AirCooling(int ID, String marca, String modello, double prezzo, int disponibilita, int sconto, String socket, double altezza, double lunghezza, double larghezza, int nVentole, int dimVentola, int maxRPM, boolean rgb, int TDP, String colore) {
        super(ID, marca, modello, prezzo, disponibilita, sconto);
        this.socket = socket;
        this.altezza = altezza;
        this.lunghezza = lunghezza;
        this.larghezza = larghezza;
        this.nVentole = nVentole;
        this.dimVentola = dimVentola;
        this.maxRPM = maxRPM;
        this.rgb = rgb;
        this.TDP = TDP;
        this.colore = colore;
    }

    public String getSocket() {
        return socket;
    }

    public void setSocket(String socket) {
        this.socket = socket;
    }

    public double getAltezza() {
        return altezza;
    }

    public void setAltezza(double altezza) {
        this.altezza = altezza;
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

    public int getnVentole() {
        return nVentole;
    }

    public void setnVentole(int nVentole) {
        this.nVentole = nVentole;
    }

    public int getDimVentola() {
        return dimVentola;
    }

    public void setDimVentola(int dimVentola) {
        this.dimVentola = dimVentola;
    }

    public int getMaxRPM() {
        return maxRPM;
    }

    public void setMaxRPM(int maxRPM) {
        this.maxRPM = maxRPM;
    }

    public boolean isRgb() {
        return rgb;
    }

    public void setRgb(boolean rgb) {
        this.rgb = rgb;
    }

    public int getTDP() {
        return TDP;
    }

    public void setTDP(int TDP) {
        this.TDP = TDP;
    }

    public String getColore() {
        return colore;
    }

    public void setColore(String colore) {
        this.colore = colore;
    }
}
