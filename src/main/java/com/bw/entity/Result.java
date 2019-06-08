package com.bw.entity;

import java.io.Serializable;

public class Result implements Serializable {
    int dat;
    String flag;
    String message;

    @Override
    public String toString() {
        return "Result{" +
                "dat=" + dat +
                ", flag='" + flag + '\'' +
                ", message='" + message + '\'' +
                '}';
    }

    public String getFlag() {
        return flag;
    }

    public void setFlag(String flag) {
        this.flag = flag;
    }

    public int getDat() {
        return dat;
    }

    public void setDat(int dat) {
        this.dat = dat;
    }



    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
