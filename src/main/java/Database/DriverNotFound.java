package Database;

public class DriverNotFound extends RuntimeException {
    public DriverNotFound() {
        super("Il driver non è stato trovato, importalo");
    }
}
