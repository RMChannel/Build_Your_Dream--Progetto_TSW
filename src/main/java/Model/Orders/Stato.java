package Model.Orders;

public class Stato {
    public static String getStato(int stato) {
        return switch (stato) {
            case -2 -> "Annullato";
            case -1 -> "Rimborsato";
            case 0 -> "In preparazione";
            case 1 -> "Spedito";
            case 2 -> "Consegnato";
            default -> "Stato non valido";
        };
    }
}
