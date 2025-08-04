package Model.PreBuilts;

import java.io.Serializable;
import java.util.Objects;

public class PreBuilt implements Serializable {
    private int ID;
    private String marca;
    private String modello;
    private Double prezzo;
    private int disponibilita;
    private int sconto;
    private String descrizione;
    private String CPU;
    private String GPU;
    private int RAM;
    private int memory;
    private final String TYPE="Prebuilt";

    public PreBuilt(int ID, String marca, String modello, Double prezzo, int disponibilita, int sconto, String descrizione, String CPU, String GPU, int RAM, int memory) {
        this.ID = ID;
        this.marca = marca;
        this.modello = modello;
        this.prezzo = prezzo;
        this.disponibilita = disponibilita;
        this.sconto = sconto;
        this.descrizione = descrizione;
        this.CPU = CPU;
        this.GPU = GPU;
        this.RAM = RAM;
        this.memory = memory;
    }

    public String getTYPE() {
        return TYPE;
    }

    public int getID() {
        return ID;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    public String getMarca() {
        return marca;
    }

    public void setMarca(String marca) {
        this.marca = marca;
    }

    public String getModello() {
        return modello;
    }

    public void setModello(String modello) {
        this.modello = modello;
    }

    public Double getPrezzo() {
        return prezzo;
    }

    public void setPrezzo(Double prezzo) {
        this.prezzo = prezzo;
    }

    public Double getPrezzoScontato() {
        return prezzo-((prezzo*sconto)/100);
    }

    public int getDisponibilita() {
        return disponibilita;
    }

    public void setDisponibilita(int disponibilita) {
        this.disponibilita = disponibilita;
    }

    public int getSconto() {
        return sconto;
    }

    public void setSconto(int sconto) {
        this.sconto = sconto;
    }

    public String getDescrizione() {
        return descrizione;
    }

    public void setDescrizione(String descrizione) {
        this.descrizione = descrizione;
    }

    public String getCPU() {
        return CPU;
    }

    public void setCPU(String CPU) {
        this.CPU = CPU;
    }

    public String getGPU() {
        return GPU;
    }

    public void setGPU(String GPU) {
        this.GPU = GPU;
    }

    public int getRAM() {
        return RAM;
    }

    public void setRAM(int RAM) {
        this.RAM = RAM;
    }

    public int getMemory() {
        return memory;
    }

    public void setMemory(int memory) {
        this.memory = memory;
    }

    @Override
    public String toString() {
        return marca + " " + modello + ", " + prezzo + "€";
    }

    @Override
    public boolean equals(Object o) {
        if (o == null || getClass() != o.getClass()) return false;
        PreBuilt preBuilt = (PreBuilt) o;
        return ID == preBuilt.ID && disponibilita == preBuilt.disponibilita && sconto == preBuilt.sconto && RAM == preBuilt.RAM && memory == preBuilt.memory && Objects.equals(marca, preBuilt.marca) && Objects.equals(modello, preBuilt.modello) && Objects.equals(prezzo, preBuilt.prezzo) && Objects.equals(descrizione, preBuilt.descrizione) && Objects.equals(CPU, preBuilt.CPU) && Objects.equals(GPU, preBuilt.GPU) && Objects.equals(TYPE, preBuilt.TYPE);
    }
}