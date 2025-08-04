package Model.Pezzi.Motherboard;

import Model.Pezzi.Pezzo;
import java.io.Serializable;

public class Motherboard extends Pezzo implements Serializable {
    private String socket;
    private String categoria;
    private String tipo_ram;
    private int nSlot;
    private int capacitaRAM;
    private int nSata;
    private int nM2;
    private boolean wifi;
    private String pcie;
    private int nPcie;

    public Motherboard(int ID, String marca, String modello, double prezzo, int disponibilita, int sconto, String socket, String categoria, String tipo_ram, int nSlot, int capacitaRAM, int nSata, int nM2, boolean wifi, String pcie, int nPcie) {
        super(ID, marca, modello, prezzo, disponibilita, sconto);
        this.socket = socket;
        this.categoria = categoria;
        this.tipo_ram = tipo_ram;
        this.nSlot = nSlot;
        this.capacitaRAM = capacitaRAM;
        this.nSata = nSata;
        this.nM2 = nM2;
        this.wifi = wifi;
        this.pcie = pcie;
        this.nPcie = nPcie;
    }

    public String getSocket() {
        return socket;
    }

    public void setSocket(String socket) {
        this.socket = socket;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public String getTipo_ram() {
        return tipo_ram;
    }

    public void setTipo_ram(String tipo_ram) {
        this.tipo_ram = tipo_ram;
    }

    public int getnSlot() {
        return nSlot;
    }

    public void setnSlot(int nSlot) {
        this.nSlot = nSlot;
    }

    public int getCapacitaRAM() {
        return capacitaRAM;
    }

    public void setCapacitaRAM(int capacitaRAM) {
        this.capacitaRAM = capacitaRAM;
    }

    public int getnSata() {
        return nSata;
    }

    public void setnSata(int nSata) {
        this.nSata = nSata;
    }

    public int getnM2() {
        return nM2;
    }

    public void setnM2(int nM2) {
        this.nM2 = nM2;
    }

    public boolean isWifi() {
        return wifi;
    }

    public void setWifi(boolean wifi) {
        this.wifi = wifi;
    }

    public String getPcie() {
        return pcie;
    }

    public void setPcie(String pcie) {
        this.pcie = pcie;
    }

    public int getnPcie() {
        return nPcie;
    }

    public void setnPcie(int nPcie) {
        this.nPcie = nPcie;
    }
}
