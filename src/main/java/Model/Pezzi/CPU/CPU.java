package Model.Pezzi.CPU;

import Model.Pezzi.Pezzo;
import java.io.Serializable;

public class CPU extends Pezzo implements Serializable {
    private String famiglia;
    private String generazione;
    private int nCore;
    private int nThreads;
    private float baseFrequence;
    private float turboFrequence;
    private int TDP;
    private String litografia;
    private String socket;
    private String memSup;
    private String memFrequence;
    private String PCIE;

    public CPU(int ID, String marca, String modello, double prezzo, int disponibilita, int sconto, String famiglia, String generazione, int nCore, int nThreads, float baseFrequence, float turboFrequence, int TDP, String litografia, String socket, String memSup, String memFrequence, String PCIE) {
        super(ID, marca, modello, prezzo, disponibilita, sconto);
        this.famiglia = famiglia;
        this.generazione = generazione;
        this.nCore = nCore;
        this.nThreads = nThreads;
        this.baseFrequence = baseFrequence;
        this.turboFrequence = turboFrequence;
        this.TDP = TDP;
        this.litografia = litografia;
        this.socket = socket;
        this.memSup = memSup;
        this.memFrequence = memFrequence;
        this.PCIE = PCIE;
    }

    public String getFamiglia() {
        return famiglia;
    }

    public void setFamiglia(String famiglia) {
        this.famiglia = famiglia;
    }

    public String getGenerazione() {
        return generazione;
    }

    public void setGenerazione(String generazione) {
        this.generazione = generazione;
    }

    public int getnCore() {
        return nCore;
    }

    public void setnCore(int nCore) {
        this.nCore = nCore;
    }

    public int getnThreads() {
        return nThreads;
    }

    public void setnThreads(int nThreads) {
        this.nThreads = nThreads;
    }

    public float getBaseFrequence() {
        return baseFrequence;
    }

    public void setBaseFrequence(float baseFrequence) {
        this.baseFrequence = baseFrequence;
    }

    public float getTurboFrequence() {
        return turboFrequence;
    }

    public void setTurboFrequence(float turboFrequence) {
        this.turboFrequence = turboFrequence;
    }

    public int getTDP() {
        return TDP;
    }

    public void setTDP(int TDP) {
        this.TDP = TDP;
    }

    public String getLitografia() {
        return litografia;
    }

    public void setLitografia(String litografia) {
        this.litografia = litografia;
    }

    public String getSocket() {
        return socket;
    }

    public void setSocket(String socket) {
        this.socket = socket;
    }

    public String getMemSup() {
        return memSup;
    }

    public void setMemSup(String memSup) {
        this.memSup = memSup;
    }

    public String getMemFrequence() {
        return memFrequence;
    }

    public void setMemFrequence(String memFrequence) {
        this.memFrequence = memFrequence;
    }

    public String getPCIE() {
        return PCIE;
    }

    public void setPCIE(String PCIE) {
        this.PCIE = PCIE;
    }
}
