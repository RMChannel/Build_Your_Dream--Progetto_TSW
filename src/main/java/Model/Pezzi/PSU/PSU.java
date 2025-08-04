package Model.Pezzi.PSU;

import Model.Pezzi.Pezzo;
import java.io.Serializable;

public class PSU extends Pezzo implements Serializable {
    private String categoria;
    private int potenza;
    private String certificazione;
    private boolean modularita;
    private double peso;

    public PSU(int ID, String marca, String modello, double prezzo, int disponibilita, int sconto, String categoria, int potenza, String certificazione, boolean modularita, double peso) {
        super(ID, marca, modello, prezzo, disponibilita, sconto);
        this.categoria = categoria;
        this.potenza = potenza;
        this.certificazione = certificazione;
        this.modularita = modularita;
        this.peso = peso;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public int getPotenza() {
        return potenza;
    }

    public void setPotenza(int potenza) {
        this.potenza = potenza;
    }

    public String getCertificazione() {
        return certificazione;
    }

    public void setCertificazione(String certificazione) {
        this.certificazione = certificazione;
    }

    public boolean isModularita() {
        return modularita;
    }

    public void setModularita(boolean modularita) {
        this.modularita = modularita;
    }

    public double getPeso() {
        return peso;
    }

    public void setPeso(double peso) {
        this.peso = peso;
    }
}
