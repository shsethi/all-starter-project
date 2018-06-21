package com.github.shsethi.kafka.streams;

/**
 * Created by shsethi on 6/21/18.
 */

/**
 * The type Dummy class.
 */
public class DummyClass {

    /**
     * The Input.
     */
    int input;
    /**
     * The State.
     */
    int state;


    /**
     * Gets input.
     *
     * @return the input
     */
    public int getInput() {
        return input;
    }

    /**
     * Sets input.
     *
     * @param input the input
     */
    public void setInput(int input) {
        this.input = input;
    }

    /**
     * Gets state.
     *
     * @return the state
     */
    public int getState() {
        return state;
    }

    /**
     * Sets state.
     *
     * @param state the state
     */
    public void setState(int state) {
        this.state = state;
    }

    /**
     * Instantiates a new Dummy class.
     *
     * @param input the input
     * @param state the state
     */
    public DummyClass(int input, int state) {
        this.input = input;
        this.state = state;
    }
}
