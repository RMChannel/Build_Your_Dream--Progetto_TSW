package Model.Users;

public class UsernameAlreadyRegistred extends Exception {
    public UsernameAlreadyRegistred() {
        super("Utente con stesso username già registrato");
    }
}
