package com.anifinders.safebox.helper.dynamo;

public class GsiMapper {
    String hk;
    String rk;
    String index;

    public GsiMapper(String hk, String rk, String index) {
        this.hk = hk;
        this.rk = rk;
        this.index = index;
    }

    public String getHk() {
        return hk;
    }

    public void setHk(String hk) {
        this.hk = hk;
    }

    public String getRk() {
        return rk;
    }

    public void setRk(String rk) {
        this.rk = rk;
    }

    public String getIndex() {
        return index;
    }

    public void setIndex(String index) {
        this.index = index;
    }
}