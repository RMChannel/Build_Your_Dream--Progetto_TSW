package Model.Orders;

public class MaxNotFoundException extends RuntimeException {
    public MaxNotFoundException() {
        super("Errore nella ricerca dell'ID per gli ordini");
    }
}
