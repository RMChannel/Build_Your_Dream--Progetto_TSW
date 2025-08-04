package Model;

public class QuantityNotSufficientException extends RuntimeException {
    public QuantityNotSufficientException() {
        super("La quantità del prodotto non è abbastanza per l'ordine");
    }
}
