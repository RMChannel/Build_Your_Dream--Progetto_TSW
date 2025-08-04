package Model.Pezzi.GPU;

import Model.Pezzi.Pezzo;
import java.io.Serializable;

public class GPU extends Pezzo implements Serializable {
    private String produttore;
    private int VRAM;
    private String VRAMtype;
    private String pcie;
    private boolean overclock;
    private int watt;
    private double peso;
    private String memFrequence;

    public GPU(int ID, String marca, String modello, double prezzo, int disponibilita, int sconto, String produttore, int VRAM, String VRAMtype, String pcie, boolean overclock, int watt, double peso, String memFrequence) {
        super(ID, marca, modello, prezzo, disponibilita, sconto);
        this.produttore = produttore;
        this.VRAM = VRAM;
        this.VRAMtype = VRAMtype;
        this.pcie = pcie;
        this.overclock = overclock;
        this.watt = watt;
        this.peso = peso;
        this.memFrequence = memFrequence;
    }

    public int getVRAM() {
        return VRAM;
    }

    public void setVRAM(int VRAM) {
        this.VRAM = VRAM;
    }

    public String getProduttore() {
        return produttore;
    }

    public void setProduttore(String produttore) {
        this.produttore = produttore;
    }

    public String getVRAMtype() {
        return VRAMtype;
    }

    public void setVRAMtype(String VRAMtype) {
        this.VRAMtype = VRAMtype;
    }

    public String getPcie() {
        return pcie;
    }

    public void setPcie(String pcie) {
        this.pcie = pcie;
    }

    public boolean isOverclock() {
        return overclock;
    }

    public void setOverclock(boolean overclock) {
        this.overclock = overclock;
    }

    public int getWatt() {
        return watt;
    }

    public void setWatt(int watt) {
        this.watt = watt;
    }

    public double getPeso() {
        return peso;
    }

    public void setPeso(double peso) {
        this.peso = peso;
    }

    public String getMemFrequence() {
        return memFrequence;
    }

    public void setMemFrequence(String memFrequence) {
        this.memFrequence = memFrequence;
    }
}
