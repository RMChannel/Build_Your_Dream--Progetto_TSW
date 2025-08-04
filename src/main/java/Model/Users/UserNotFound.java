package Model.Users;

public class UserNotFound extends Exception {
    public UserNotFound() {
        super("Username non trovato");
    }
}
