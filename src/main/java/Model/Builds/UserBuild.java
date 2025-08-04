package Model.Builds;

import Model.Pezzi.Cooling.AirCooling;
import Model.Pezzi.Cooling.LiquidCooling;
import Model.Pezzi.Memory.Memory;
import Model.Pezzi.RAM.RAM;

import java.io.Serializable;
import java.util.List;

public class UserBuild extends Build implements Serializable {
    private int ID;
    private String nome;

    public UserBuild(int ID, String nome, Build build) {
        this.ID = ID;
        this.nome = nome;
        this.setCpu(build.getCpu());
        this.setGpu(build.getGpu());
        this.setPsu(build.getPsu());
        this.setMotherboard(build.getMotherboard());
        this.setCase2(build.getCase2());
        List<Memory> memories = build.getMemories();
        for (Memory memory : memories) {
            this.addMemory(memory);
        }
        List<AirCooling> airCoolings = build.getAirCoolings();
        for (AirCooling airCooling : airCoolings) {
            this.addAirCooling(airCooling);
        }
        List<LiquidCooling> liquidCoolings = build.getLiquidCoolings();
        for (LiquidCooling liquidCooling : liquidCoolings) {
            this.addLiquidCooling(liquidCooling);
        }
        List<RAM> rams = build.getRams();
        for (RAM ram : rams) {
            this.addRam(ram);
        }
    }

    public int getID() {
        return ID;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }
}
