package Model.Pezzi.RAM;

import Model.Pezzi.Pezzo;
import java.io.Serializable;

public class RAM extends Pezzo implements Serializable {
    private int capacita;
    private String categoria;
    private int frequenza;
    private String tipologia;

    public RAM(int ID, String marca, String modello, double prezzo, int disponibilita, int sconto, int capacita, String categoria, int frequenza, String tipologia) {
        super(ID, marca, modello, prezzo, disponibilita, sconto);
        this.capacita = capacita;
        this.categoria = categoria;
        this.frequenza = frequenza;
        this.tipologia = tipologia;
    }

    public int getCapacita() {
        return capacita;
    }

    public void setCapacita(int capacita) {
        this.capacita = capacita;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public int getFrequenza() {
        return frequenza;
    }

    public void setFrequenza(int frequenza) {
        this.frequenza = frequenza;
    }

    public String getTipologia() {
        return tipologia;
    }

    public void setTipologia(String tipologia) {
        this.tipologia = tipologia;
    }
}
