package Model.Users;

public class EmailAlreadyRegistred extends Exception {
    public EmailAlreadyRegistred() {
        super("Email già registrata");
    }
}
