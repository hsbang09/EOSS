/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package eoss.spacecraft;

/**
 *
 * @author nozomihitomi
 */
public interface BusComponent {

    /**
     * Gets the mass of the subsystem
     *
     * @return
     */
    public double getMass();

    /**
     * Gets the power [W] used or generated by the subsystem. Positive numbers
     * indicate power generated, negative numbers indicate power is consumed
     *
     * @return
     */
    public double getPower();

}
