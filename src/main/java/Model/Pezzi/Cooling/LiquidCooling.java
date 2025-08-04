package Model.Pezzi.Cooling;

import Model.Pezzi.Pezzo;
import java.io.Serializable;

public class LiquidCooling extends Pezzo implements Serializable {
    private String socket;
    private double altezza;
    private double lunghezza;
    private double larghezza;
    private double dimRadiatore;
    private int nVentole;
    private int maxRPM;
    private boolean rgb;
    private int tdp;
    private String colore;
    private boolean display;

    public LiquidCooling(int ID, String marca, String modello, double prezzo, int disponibilita, int sconto, String socket, double altezza, double lunghezza, double larghezza, double dimRadiatore, int nVentole, int maxRPM, boolean rgb, int tdp, String colore, boolean display) {
        super(ID, marca, modello, prezzo, disponibilita, sconto);
        this.socket = socket;
        this.altezza = altezza;
        this.lunghezza = lunghezza;
        this.larghezza = larghezza;
        this.dimRadiatore = dimRadiatore;
        this.nVentole = nVentole;
        this.maxRPM = maxRPM;
        this.rgb = rgb;
        this.tdp = tdp;
        this.colore = colore;
        this.display = display;
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

    public double getDimRadiatore() {
        return dimRadiatore;
    }

    public void setDimRadiatore(double dimRadiatore) {
        this.dimRadiatore = dimRadiatore;
    }

    public int getnVentole() {
        return nVentole;
    }

    public void setnVentole(int nVentole) {
        this.nVentole = nVentole;
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

    public int getTdp() {
        return tdp;
    }

    public void setTdp(int tdp) {
        this.tdp = tdp;
    }

    public String getColore() {
        return colore;
    }

    public void setColore(String colore) {
        this.colore = colore;
    }

    public boolean isDisplay() {
        return display;
    }

    public void setDisplay(boolean display) {
        this.display = display;
    }
}
