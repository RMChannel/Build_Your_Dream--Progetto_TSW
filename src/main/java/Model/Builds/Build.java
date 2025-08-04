package Model.Builds;

import Model.Pezzi.CPU.CPU;
import Model.Pezzi.Case.Case;
import Model.Pezzi.Cooling.AirCooling;
import Model.Pezzi.Cooling.LiquidCooling;
import Model.Pezzi.GPU.GPU;
import Model.Pezzi.Memory.Memory;
import Model.Pezzi.Motherboard.Motherboard;
import Model.Pezzi.PSU.PSU;
import Model.Pezzi.RAM.RAM;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class Build implements Serializable {
    private CPU cpu;
    private ArrayList<RAM> rams;
    private Motherboard motherboard;
    private GPU gpu;
    private PSU psu;
    private Case case2;
    private ArrayList<Memory> memories;
    private ArrayList<LiquidCooling> liquidCoolings;
    private ArrayList<AirCooling> airCoolings;

    public Build() {
        cpu=null;
        gpu=null;
        rams=new ArrayList<>();
        motherboard=null;
        psu=null;
        case2=null;
        memories=new ArrayList<>();
        liquidCoolings=new ArrayList<>();
        airCoolings=new ArrayList<>();
    }

    public CPU getCpu() {
        return cpu;
    }

    public void setCpu(CPU cpu) {
        this.cpu = cpu;
    }

    public ArrayList<RAM> getRams() {
        return rams;
    }

    public void addRam(RAM ram) {
        rams.add(ram);
    }

    public void removeRam(int id) {
        for(RAM ram : rams) {
            if(ram.getID()==id) {
                rams.remove(ram);
            }
        }
    }

    public Motherboard getMotherboard() {
        return motherboard;
    }

    public void setMotherboard(Motherboard motherboard) {
        this.motherboard = motherboard;
    }

    public GPU getGpu() {
        return gpu;
    }

    public void setGpu(GPU gpu) {
        this.gpu = gpu;
    }

    public PSU getPsu() {
        return psu;
    }

    public void setPsu(PSU psu) {
        this.psu = psu;
    }

    public Case getCase2() {
        return case2;
    }

    public void setCase2(Case case2) {
        this.case2 = case2;
    }

    public ArrayList<Memory> getMemories() {
        return memories;
    }

    public void addMemory(Memory memory) {
        memories.add(memory);
    }

    public void removeMemory(int id) {
        for(Memory m : memories) {
            if(m.getID()==id) {
                memories.remove(m);
                break;
            }
        }
    }

    public ArrayList<LiquidCooling> getLiquidCoolings() {
        return liquidCoolings;
    }

    public void addLiquidCooling(LiquidCooling liquidCooling) {
        liquidCoolings.add(liquidCooling);
    }

    public void removeLiquidCooling(int id) {
        for(LiquidCooling l : liquidCoolings) {
            if(l.getID()==id) {
                liquidCoolings.remove(l);
                break;
            }
        }
    }

    public ArrayList<AirCooling> getAirCoolings() {
        return airCoolings;
    }

    public void addAirCooling(AirCooling airCooling) {
        airCoolings.add(airCooling);
    }

    public void removeAirCooling(int id) {
        for(AirCooling a : airCoolings) {
            if(a.getID()==id) {
                airCoolings.remove(a);
            }
        }
    }

    public double getTotale() {
        double price=0;
        if(cpu!=null) price+=cpu.getPrezzo();
        if(rams!=null) for(RAM ram : rams) price+=ram.getPrezzo();
        if(motherboard!=null) price+=motherboard.getPrezzo();
        if(gpu!=null) price+=gpu.getPrezzo();
        if(psu!=null) price+=psu.getPrezzo();
        if(case2!=null) price+=case2.getPrezzo();
        if(memories!=null) for(Memory memory : memories) price+=memory.getPrezzo();
        if(liquidCoolings!=null) for(LiquidCooling liquidCooling : liquidCoolings) price+=liquidCooling.getPrezzo();
        return price;
    }

    public double getTotaleScontato() {
        double price=0;
        if(cpu!=null) price+=cpu.getPrezzoScontato();
        if(rams!=null) for(RAM ram : rams) price+=ram.getPrezzoScontato();
        if(motherboard!=null) price+=motherboard.getPrezzoScontato();
        if(gpu!=null) price+=gpu.getPrezzoScontato();
        if(psu!=null) price+=psu.getPrezzoScontato();
        if(case2!=null) price+=case2.getPrezzoScontato();
        if(memories!=null) for(Memory memory : memories) price+=memory.getPrezzoScontato();
        if(liquidCoolings!=null) for(LiquidCooling liquidCooling : liquidCoolings) price+=liquidCooling.getPrezzoScontato();
        return price;
    }

    public List<String> isCompatibile() {
        List<String> compatible = new ArrayList<>();
        int TDPCount=0;
        if(cpu!=null) TDPCount+=cpu.getTDP();
        if(gpu!=null) TDPCount+=gpu.getWatt();
        if(motherboard!=null) TDPCount+=40;
        if(!rams.isEmpty()) {
            for(RAM ram : rams) {
                if(ram.getCategoria().contains("DDR4")) TDPCount+=4;
                else TDPCount+=6;
            }
        }
        if(psu!=null) if(TDPCount>psu.getPotenza()) compatible.add("Il PSU selezionato non è abbastanza potente per la tua build"); //Controllo PSU con TDP
        if(cpu!=null && motherboard!=null) {
            if(!cpu.getSocket().equals(motherboard.getSocket())) compatible.add("Il socket della CPU e della motherboard non sono compatibili"); //Controllo Socket CPU e Motherboard
            if(!cpu.getMemSup().contains(motherboard.getTipo_ram())) compatible.add("Il tipo di RAM supportata dalla Motherboard non è supportata dalla CPU"); //Controllo CPU e Motherboard su tipo RAM
        }
        if(cpu!=null && rams!=null) {
            for(RAM ram : rams) {
                if(!cpu.getMemSup().contains(ram.getCategoria())) {
                    compatible.add("Uno dei banchetti RAM non è compatibile con la CPU"); //Controllo tipo RAM con CPU
                    break;
                }
                if(!cpu.getMemFrequence().contains(String.valueOf(ram.getFrequenza()))) {
                    compatible.add("Uno dei banchetti RAM ha una frequenza non supportata dall CPU"); //Controllo frequenze RAM con CPU
                    break;
                }
            }
        }
        if(rams!=null && motherboard!=null) {
            for(RAM ram : rams) {
                if(!motherboard.getTipo_ram().contains(ram.getCategoria())) {
                    compatible.add("Uno dei banchetti RAM non è compatibile con la motherboard"); //Controllo tipo RAM con Motherboard
                    break;
                }
            }
        }
        if(gpu!=null && motherboard!=null) {
            if(!gpu.getPcie().equals(motherboard.getPcie())) compatible.add("Potresti avere cali di perfomance della GPU a causa di versione di PCIe minore dalla GPU o dalla Motherboard"); //Controllo PCIe Motherboard e GPU
        }
        if(!liquidCoolings.isEmpty() && cpu!=null) {
            for(LiquidCooling liquidCooling : liquidCoolings) {
                if(!liquidCooling.getSocket().equals("-") && !liquidCooling.getSocket().contains(cpu.getSocket())) {
                    compatible.add("Uno dei dissipatori a liquido no supporta la tua CPU"); //Controllo Socket CPU e LiquidCooling
                }
            }
        }
        if(!airCoolings.isEmpty() && cpu!=null) {
            for(AirCooling airCooling : airCoolings) {
                if(!airCooling.getSocket().equals("-") && !airCooling.getSocket().contains(cpu.getSocket())) {
                    compatible.add("Uno dei dissipatori ad aria no supporta la tua CPU"); //Controllo Socket CPU e AirCooling
                }
            }
        }
        return compatible;
    }

    @Override
    public String toString() {
        return "Build{" +
                "cpu=" + cpu +
                ", rams=" + rams +
                ", motherboard=" + motherboard +
                ", gpu=" + gpu +
                ", psu=" + psu +
                ", case2=" + case2 +
                ", memories=" + memories +
                ", liquidCoolings=" + liquidCoolings +
                ", airCoolings=" + airCoolings +
                '}';
    }

    public boolean isEmpty() {
        return cpu == null && gpu == null && psu == null && case2 == null && motherboard == null && rams.isEmpty() && memories.isEmpty() && airCoolings.isEmpty() && liquidCoolings.isEmpty();
    }
}
