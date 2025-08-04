package Model.Users.Carte;

public class CardAlreadySaved extends Exception {
    public CardAlreadySaved() {
        super("Questa carta è stata già salvata da questo utente");
    }
}
