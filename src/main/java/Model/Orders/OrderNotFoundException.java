package Model.Orders;

public class OrderNotFoundException extends RuntimeException {
    public OrderNotFoundException() {
        super("L'ordine non è stato trovato");
    }
}
