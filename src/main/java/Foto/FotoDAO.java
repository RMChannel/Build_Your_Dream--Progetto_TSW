package Foto;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

public class FotoDAO {
    public String getFoto(int ID, String category, String name, String realPath) { //ritorna la path della foto di un prodotto
        File cartella = new File(realPath+"/media/"+category+"/"+name);//recupera la cartella dove si dovrebbe trovare la foto
        if (!cartella.isDirectory()) { //Se non esiste o non è una cartella
            throw new FolderDoesntExist(cartella.getPath()); //Lancia l'eccezione poiché ciò non può accadere
        }
        String idStr = String.valueOf(ID); //Trasforma l'id da intero a stringa
        File[] files = cartella.listFiles(); //Si prende tutti i file all'interno della cartella trovata prima
        if(files!=null) {
            for (File file : files) { //Per ogni file
                String fileName = file.getName(); //Si prende il nome
                int punto = fileName.lastIndexOf('.'); //Si prende il punto preciso dove si trova il punto '.'
                String nomeSenzaEstensione = (punto != -1) ? fileName.substring(0, punto) : fileName; //Divide la parte senza estensione, questo perché tutte le foto sono salvate con ID+estensione
                if (nomeSenzaEstensione.equals(idStr)) { //Se le stringhe corrispondono vuol dire che la foto è stata trovata
                    String fullPath = file.getAbsolutePath(); //Si prende la path assoluta della foto
                    int mediaIndex = fullPath.indexOf("media"); //Si prende il punto preciso dove si trova "media"
                    if (mediaIndex != -1) { //Restituisce la stringa de media.. in poi, perché il server risponde alle richieste di get di ogni file/cartella a partire da webapp e media è una sottocartella di webapp
                        return fullPath.substring(mediaIndex).replace("\\", "/");
                    } else {
                        return file.getName(); //Altrimenti, caso impossibile ma da coprire nel caso in cui "media" non viene trovato allora viene restituito il nome del file per fare il debug
                    }
                }
            }
        }
        return "media/notFound.jpg"; //Nel caso in cui la foto non viene trovata viene restituito un file placeholder
    }

    public List<String> getFotoForPrebuilt(int ID, String realPath) { //Ritorna le path di tutte le foto corrispondenti ad un prebuilt
        List<String> list = new ArrayList<String>();
        File cartella = new File(realPath+"/media/PreBuilt/"+ID); //Recupera la cartella corrispondente al Prebuilt richiesto
        if (!cartella.isDirectory()) { //Controlla che esiste ed è una cartella
            list.add("media/notFound.jpg"); //Se non esiste o non è una cartella allora viene aggiunto solo file placeholder
        }
        else {
            File[] files = cartella.listFiles(); //Altrimenti si recuperano tutti i file dalla cartella
            if(files!=null) {
                for(File file : files) { //Per ogni file viene aggiunto alla lista da restituire la path relativa del file
                    list.add("media/PreBuilt/"+ID+"/"+file.getName());
                }
            }
            else { //Nel caso in cui la cartella esiste ma non ci sono foto, anche qui, viene restituito solo il placeholder
                list.add("media/notFound.jpg");
            }
        }
        return list;
    }

    public String getFirstFotoOfPrebuilt(int ID, String realPath) { //Ritorna la path della 1°foto di un prebuilt
        File cartella = new File(realPath+"/media/PreBuilt/"+ID); //Recupera la cartella corrispondente al Prebuilt richiesto
        if (!cartella.isDirectory()) { //Controlla che esiste ed è una cartella
            return "media/notFound.jpg"; //Se non esiste o non è una cartella allora viene aggiunto solo file placeholder
        }
        else {
            File[] files = cartella.listFiles(); //Altrimenti si recuperano tutti i file dalla cartella
            if(files!=null) {
                return "media/PreBuilt/"+ID+"/"+files[0].getName(); //Vien restituita la path relativa del file
            }
            else {
                return "media/notFound.jpg"; //Nel caso in cui la cartella esiste ma non ci sono foto, anche qui, viene restituito solo il placeholder
            }
        }
    }

    public void removeFoto(int ID, String category, String name, String realPath) { //Si occupa della rimozione della foto di un prodotto
        File cartella = new File(realPath+"/media/"+category+"/"+name); //recupera la cartella dove si dovrebbe trovare la foto
        if (!cartella.isDirectory()) { //Se non esiste o non è una cartella
            throw new FolderDoesntExist(cartella.getPath()); //Lancia l'eccezione poiché ciò non può accadere
        }
        String idStr = String.valueOf(ID); //Trasforma l'id da intero a stringa
        File[] files = cartella.listFiles(); //Si prende tutti i file all'interno della cartella trovata prima
        if(files!=null) {
            for (File file : files) { //Viene cercato il file corrispondente al prodotto ricercato
                String fileName = file.getName();
                int punto = fileName.lastIndexOf('.'); //Si prende il punto preciso dove si trova il punto '.'
                String nomeSenzaEstensione = (punto != -1) ? fileName.substring(0, punto) : fileName; //Divide la parte senza estensione, questo perché tutte le foto sono salvate con ID+estensione
                if (nomeSenzaEstensione.equals(idStr)) { //Se le stringhe corrispondono vuol dire che la foto è stata trovata
                    file.delete(); //La foto viene cancellata
                    return;
                }
            }
        }
    }

    public void removeFoto(String path) { //Si occupa della rimozione di una foto tramite path
        File file=new File(path);
        if(file.isDirectory() || !file.exists()) { //Controllo che il path sia corretto
            throw new RemoveSingleFotoError();
        }
        else {
            if(!file.delete()) throw new RemoveSingleFotoError(); //La foto viene rimossa
        }
    }

    public void removeAllFotos(int ID, String path) { //Si occupa della rimozione di tutte le foto di un prebuilt
        File cartella = new File(path+"/media/PreBuilt/"+ID); //Viene recuperata la cartella del prebuilt
        if(!cartella.isDirectory() || !cartella.exists()) { //Se la cartella non esiste o non è una cartella
            throw new FolderDoesntExist(cartella.getPath()); //Allora viene lanciata l'eccezione perché ciò non può accadere
        }
        else {
            File[] files=cartella.listFiles(); //Vengono recuperati tutti i file contenuti nella cartella
            if(files!=null) {
                for (File file : files) { //Ognuno di essi viene rimosso
                    if(!file.delete()) throw new DeleteFolderFailed(ID);
                }
            }
            if(!cartella.delete()) { //Dopo aver cancellato ogni elemento singolarmente, viene cancellata anche la cartella
                throw new DeleteFolderFailed(ID);
            }
        }

        /*
        * Si procede con la rimozione di ogni foto prima, poi della cartella perché la rimozione di una cartella non può
        * essere effettuata se contiene dei file poiché poi bisognerebbe fare una cancellazione ricorsiva di ogni file al suo interno.
        * Allora, conoscendo a priori la struttura della cartella, vengono cancellati tutti i file al suo interno, poi viene cancellata la cartella.
        * */
    }
}
