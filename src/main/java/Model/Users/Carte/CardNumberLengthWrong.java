package Model.Users.Carte;

public class CardNumberLengthWrong extends Exception {
    public CardNumberLengthWrong() {
        super("Il numero di carta è di lunghezza diversa da 16 cifre");
    }
}
