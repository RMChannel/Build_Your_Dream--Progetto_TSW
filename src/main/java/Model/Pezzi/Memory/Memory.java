package Model.Pezzi.Memory;

import Model.Pezzi.Pezzo;
import java.io.Serializable;

public class Memory extends Pezzo implements Serializable {
    private String categoria;
    private String tipologia;
    private String interfaccia;
    private int capacita;
    private int readSpeed;
    private int writeSpeed;

    public Memory(int ID, String marca, String modello, double prezzo, int disponibilita, int sconto, String categoria, String tipologia, String interfaccia, int capacita, int readSpeed, int writeSpeed) {
        super(ID, marca, modello, prezzo, disponibilita, sconto);
        this.categoria = categoria;
        this.tipologia = tipologia;
        this.interfaccia = interfaccia;
        this.capacita = capacita;
        this.readSpeed = readSpeed;
        this.writeSpeed = writeSpeed;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public String getTipologia() {
        return tipologia;
    }

    public void setTipologia(String tipologia) {
        this.tipologia = tipologia;
    }

    public String getInterfaccia() {
        return interfaccia;
    }

    public void setInterfaccia(String interfaccia) {
        this.interfaccia = interfaccia;
    }

    public int getReadSpeed() {
        return readSpeed;
    }

    public void setReadSpeed(int readSpeed) {
        this.readSpeed = readSpeed;
    }

    public int getWriteSpeed() {
        return writeSpeed;
    }

    public void setWriteSpeed(int writeSpeed) {
        this.writeSpeed = writeSpeed;
    }

    public int getCapacita() {
        return capacita;
    }

    public void setCapacita(int capacita) {
        this.capacita = capacita;
    }
}
