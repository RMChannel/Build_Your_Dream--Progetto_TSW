package Model.Carrello;

import java.io.Serializable;

public class Item implements Serializable {
    private Object object;
    private int quantity;

    public Item(Object object, int quantity) {
        this.object = object;
        this.quantity = quantity;
    }

    public Object getObject() {
        return object;
    }

    public void setObject(Object object) {
        this.object = object;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    @Override
    public String toString() {
        return "Item{" +
                "object=" + object +
                ", quantity=" + quantity +
                '}';
    }
}
