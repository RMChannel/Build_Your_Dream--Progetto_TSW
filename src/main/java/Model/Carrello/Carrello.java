package Model.Carrello;

import Model.Accessori.Accessorio;
import Model.Pezzi.Pezzo;
import Model.PreBuilts.PreBuilt;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;

public class Carrello implements Serializable {
    private ArrayList<Item> objects;
    public Carrello() {
        objects = new ArrayList<>();
    }

    public void addToChart(Object object)  {
        if(object instanceof Accessorio || object instanceof Pezzo || object instanceof PreBuilt) {
            if(object instanceof Accessorio) {
                Accessorio accessorio = (Accessorio) object;
                for(Item item : objects) {
                    if(item.getObject() instanceof Accessorio) {
                        Accessorio temp= (Accessorio) item.getObject();
                        if(temp.equals(accessorio)) {
                            item.setQuantity(item.getQuantity()+1);
                            return;
                        }
                    }
                }
            }
            else if(object instanceof Pezzo) {
                Pezzo pezzo = (Pezzo) object;
                for (Item item : objects) {
                    if(item.getObject() instanceof Pezzo) {
                        Pezzo temp= (Pezzo) item.getObject();
                        if(temp.equals(pezzo)) {
                            item.setQuantity(item.getQuantity()+1);
                            return;
                        }
                    }
                }
            }
            else {
                PreBuilt preBuilt = (PreBuilt) object;
                for (Item item : objects) {
                    if(item.getObject() instanceof PreBuilt) {
                        PreBuilt temp= (PreBuilt) item.getObject();
                        if(temp.equals(preBuilt)) {
                            item.setQuantity(item.getQuantity()+1);
                            return;
                        }
                    }
                }
            }
            objects.add(new Item(object,1));
        }
        else {
            throw new ObjectIsNotAPiece();
        }
    }

    public void removeFromChart(int ID, String type) {
        if(type.equals("Accessorio")) {
            for(Item item : objects) {
                if(item.getObject() instanceof Accessorio accessorio) {
                    if(accessorio.getID()==ID) {
                        if(item.getQuantity()==1) {
                            objects.remove(item);
                        }
                        else {
                            item.setQuantity(item.getQuantity()-1);
                        }
                        break;
                    }
                }
            }
        }
        else if(type.equals("Pezzo")) {
            for (Item item:objects) {
                if(item.getObject() instanceof Pezzo pezzo) {
                    if(pezzo.getID()==ID) {
                        if(item.getQuantity()==1) {
                            objects.remove(item);
                        }
                        else {
                            item.setQuantity(item.getQuantity()-1);
                        }
                        break;
                    }
                }
            }
        }
        else {
            for(Item item:objects) {
                if(item.getObject() instanceof PreBuilt preBuilt) {
                    if(preBuilt.getID()==ID) {
                        if(item.getQuantity()==1) {
                            objects.remove(item);
                        }
                        else {
                            item.setQuantity(item.getQuantity()-1);
                        }
                        break;
                    }
                }
            }
        }
    }

    public ArrayList<Item> getObjects() {
        return objects;
    }

    public double getTotale() {
        double total = 0;
        for(Item item : objects) {
            Object object = item.getObject();
            if (object instanceof Accessorio) {
                Accessorio accessorio = (Accessorio) object;
                total+=accessorio.getPrezzoScontato()*item.getQuantity();
            }
            else if (object instanceof Pezzo) {
                Pezzo pezzo = (Pezzo) object;
                total+=pezzo.getPrezzoScontato()*item.getQuantity();
            }
            else if (object instanceof PreBuilt) {
                PreBuilt preBuilt = (PreBuilt) object;
                total+=preBuilt.getPrezzoScontato()*item.getQuantity();
            }
            else {
                throw new ObjectIsNotAPiece();
            }
        }
        return total;
    }

    public boolean isEmpty() {
        return objects.isEmpty();
    }

    public String toString() { //serve per gestione ordini
        StringBuilder string = new StringBuilder();
        for(Item item : objects) {
            string.append(item.getObject().toString()).append(" x ").append(item.getQuantity()).append("\n");
        }
        return string.toString();
    }

    public int getCount() {
        int count=0;
        for(Item item : objects) {
            count+=item.getQuantity();
        }
        return count;
    }

    public HashMap<String,String> getClasses() {
        HashMap<String,String> classes=new HashMap<>();
        for(Item item : objects) {
            Object object = item.getObject();
            if (object instanceof Accessorio) {
                Accessorio accessorio = (Accessorio) object;
                classes.put(accessorio.getID()+accessorio.getTYPE(),accessorio.getClass().getSimpleName());
            }
            else if (object instanceof Pezzo) {
                Pezzo pezzo = (Pezzo) object;
                classes.put(pezzo.getID()+pezzo.getTYPE(),pezzo.getClass().getSimpleName());
            }
            else if (object instanceof PreBuilt) {
                PreBuilt preBuilt = (PreBuilt) object;
                classes.put(preBuilt.getID()+preBuilt.getTYPE(),preBuilt.getClass().getSimpleName());
            }
        }
        return classes;
    }

    public void addCountToItem(int ID, String type) { //serve per aggiungere un oggetto con gli stessi attributi al carrello aumentando il numero sotto "Quantità"
        if(type.equals("Accessorio")) {
            for(Item item : objects) {
                if(item.getObject() instanceof Accessorio accessorio) {
                    if(accessorio.getID()==ID) {
                        item.setQuantity(item.getQuantity()+1);
                        return;
                    }
                }
            }
        }
        else if(type.equals("Pezzo")) {
            for (Item item:objects) {
                if(item.getObject() instanceof Pezzo pezzo) {
                    if(pezzo.getID()==ID) {
                        item.setQuantity(item.getQuantity()+1);
                        return;
                    }
                }
            }
        }
        else {
            for(Item item:objects) {
                if(item.getObject() instanceof PreBuilt preBuilt) {
                    if(preBuilt.getID()==ID) {
                        item.setQuantity(item.getQuantity()+1);
                        return;
                    }
                }
            }
        }
    }

    public int getQuantity(int id, String type) {
        for(Item item : objects) {
            if(type.equals("Accessorio")) {
                if(item.getObject() instanceof Accessorio accessorio) {
                    if(accessorio.getID()==id) {
                        return item.getQuantity();
                    }
                }
            }
            else if(type.equals("Pezzo")) {
                if(item.getObject() instanceof Pezzo pezzo) {
                    if(pezzo.getID()==id) {
                        return item.getQuantity();
                    }
                }
            }
            else {
                if(item.getObject() instanceof PreBuilt preBuilt) {
                    if(preBuilt.getID()==id) {
                        return item.getQuantity();
                    }
                }
            }
        }
        return 0;
    }

    public int getDisponibilita(int id, String type) {
        for (Item item : objects) {
            if(type.equals("Accessorio")) {
                if(item.getObject() instanceof Accessorio accessorio) {
                    if(accessorio.getID()==id) {
                        return accessorio.getDisponibilita();
                    }
                }
            }
            else if(type.equals("Pezzo")) {
                if(item.getObject() instanceof Pezzo pezzo) {
                    if(pezzo.getID()==id) {
                        return pezzo.getDisponibilita();
                    }
                }
            }
            else {
                if(item.getObject() instanceof PreBuilt preBuilt) {
                    if(preBuilt.getID()==id) {
                        return preBuilt.getDisponibilita();
                    }
                }
            }
        }
        return 0;
    }
}
