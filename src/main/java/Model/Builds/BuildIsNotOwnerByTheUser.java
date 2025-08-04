package Model.Builds;

public class BuildIsNotOwnerByTheUser extends RuntimeException {
    public BuildIsNotOwnerByTheUser() {
        super("La build che stai cercando di cancellare non appartiene all'utente che sta tentando di cancellarla");
    }
}
