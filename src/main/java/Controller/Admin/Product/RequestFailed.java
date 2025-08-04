package Controller.Admin.Product;

public class RequestFailed extends Exception {
    public RequestFailed(String category) {
        super("RequestFailed: " + category);
    }
}
