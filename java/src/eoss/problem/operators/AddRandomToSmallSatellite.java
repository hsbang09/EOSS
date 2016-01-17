/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package eoss.problem.operators;

import eoss.problem.EOSSArchitecture;
import eoss.problem.EOSSDatabase;
import java.util.ArrayList;
import java.util.Collections;

/**
 * This domain specific heuristic adds a random instrument to a small satellite
 * under the assumption that only having one instrument aboard a spacecraft is
 * not an efficient use of the bus.
 *
 * @author nozomihitomi
 */
public class AddRandomToSmallSatellite extends AbstractEOSSOperator {

    /**
     * the largest number of instruments that defines a small
     */
    private final int maxSize;

    /**
     *
     * @param maxSize the largest number of instruments that defines a small
     * satellite
     */
    public AddRandomToSmallSatellite(int maxSize) {
        this.maxSize = maxSize;
    }

    @Override
    public int getArity() {
        return 1;
    }

    @Override
    protected EOSSArchitecture evolve(EOSSArchitecture child) {
        //Find random orbit with at most maxSize instruments
        int randOrbIndex = getRandomOrbitWithAtMostNInstruments(child, maxSize);
        if(randOrbIndex == -1)
            return child;
        
        //Find a random instrument that has not yet been assigned to the random orbit found above 
        ArrayList<Integer> instIndex = new ArrayList<>(EOSSDatabase.getInstruments().size());
        for (int i = 0; i < EOSSDatabase.getInstruments().size(); i++) {
            instIndex.add(i);
        }
        Collections.shuffle(instIndex);//this sorts orbits in random order
        for (Integer ind : instIndex) {
            if (child.addInstrumentToOrbit(ind, randOrbIndex)) {
                //checks to see if the added instrument changes the architecture. if yes, then break
                break;
            }
        }
        return child;
    }

}
