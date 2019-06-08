package com.bw.entity;

import java.io.Serializable;

public class Ri implements Serializable {
    int rid;
    String rname;
    String rdate;

    public Ri(String rname, String rdate) {
        this.rname = rname;
        this.rdate = rdate;
    }

    public int getRid() {
        return rid;
    }

    public void setRid(int rid) {
        this.rid = rid;
    }

    public String getRname() {
        return rname;
    }

    public void setRname(String rname) {
        this.rname = rname;
    }

    public String getRdate() {
        return rdate;
    }

    public void setRdate(String rdate) {
        this.rdate = rdate;
    }
}
