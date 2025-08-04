package Controller.User.Carte;

public class CartaNotFound extends RuntimeException {
    public CartaNotFound() {
        super("La carta richiesta non è stata trovata nel database");
    }
}
