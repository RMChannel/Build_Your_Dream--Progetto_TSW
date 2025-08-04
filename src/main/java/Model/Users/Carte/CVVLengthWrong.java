package Model.Users.Carte;

public class CVVLengthWrong extends Exception {
    public CVVLengthWrong() {
        super("Il CVV non è di 3 cifre");
    }
}
