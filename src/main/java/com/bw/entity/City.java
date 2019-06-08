package com.bw.entity;

import java.io.Serializable;
import java.util.List;

public class City implements Serializable {
    int id;
    String text;
    int pid;
    List<City> children;

    @Override
    public String toString() {
        return "City{" +
                "id=" + id +
                ", text='" + text + '\'' +
                ", pid=" + pid +
                ", children=" + children +
                '}';
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public int getPid() {
        return pid;
    }

    public void setPid(int pid) {
        this.pid = pid;
    }

    public List<City> getChildren() {
        return children;
    }

    public void setChildren(List<City> children) {
        this.children = children;
    }
}
