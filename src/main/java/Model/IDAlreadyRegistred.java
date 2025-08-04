package Model;

public class IDAlreadyRegistred extends Exception {
    public IDAlreadyRegistred() {
        super("l'ID che hai provato a registrare già esiste nel Database");
    }
}
