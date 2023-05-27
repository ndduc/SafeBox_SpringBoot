package com.anifinders.safebox.repository.Model;


import com.amazonaws.services.dynamodbv2.datamodeling.*;

import lombok.*;

public class SafeBoxModelPost {

    private String HashKey;
    private String RangeKey;
    private String CreatedDatetime;
    private String GSI_HK_1;
    private String GSI_HK_2;
    private String GSI_RK_1;
    private String GSI_RK_2;

    @Deprecated
    private String Id;
    private String Location;
    private String ModifiedDatetime;
    private String Name;
    private String Password;
    private String UserName;
    private String Website;

    public SafeBoxModelPost(SafeBoxModel model) {
        this.HashKey = model.getHashKey();
        this.RangeKey = model.getRangeKey();
        this.CreatedDatetime = model.getCreatedDatetime();
        this.GSI_HK_1 = model.getGsi_HK_1();
        this.GSI_HK_2 = model.getGsi_HK_2();
        this.GSI_RK_1 = model.getGsi_RK_1();
        this.GSI_RK_2 = model.getGsi_RK_2();
        this.Id = model.getId();
        this.Location = model.getLocation();
        this.ModifiedDatetime = model.getModifiedDatetime();
        this.Name = model.getName();
        this.Password = model.getPassword();
        this.UserName = model.getUserName();
        this.Website = model.getWebsite();
    }

    public String getHashKey() {
        return HashKey;
    }

    public void setHashKey(String hashKey) {
        HashKey = hashKey;
    }

    public String getRangeKey() {
        return RangeKey;
    }

    public void setRangeKey(String rangeKey) {
        RangeKey = rangeKey;
    }

    public String getCreatedDatetime() {
        return CreatedDatetime;
    }

    public void setCreatedDatetime(String createdDatetime) {
        CreatedDatetime = createdDatetime;
    }

    public String getGSI_HK_1() {
        return GSI_HK_1;
    }

    public void setGSI_HK_1(String GSI_HK_1) {
        this.GSI_HK_1 = GSI_HK_1;
    }

    public String getGSI_HK_2() {
        return GSI_HK_2;
    }

    public void setGSI_HK_2(String GSI_HK_2) {
        this.GSI_HK_2 = GSI_HK_2;
    }

    public String getGSI_RK_1() {
        return GSI_RK_1;
    }

    public void setGSI_RK_1(String GSI_RK_1) {
        this.GSI_RK_1 = GSI_RK_1;
    }

    public String getGSI_RK_2() {
        return GSI_RK_2;
    }

    public void setGSI_RK_2(String GSI_RK_2) {
        this.GSI_RK_2 = GSI_RK_2;
    }

    public String getId() {
        return Id;
    }

    public void setId(String id) {
        Id = id;
    }

    public String getLocation() {
        return Location;
    }

    public void setLocation(String location) {
        Location = location;
    }

    public String getModifiedDatetime() {
        return ModifiedDatetime;
    }

    public void setModifiedDatetime(String modifiedDatetime) {
        ModifiedDatetime = modifiedDatetime;
    }

    public String getName() {
        return Name;
    }

    public void setName(String name) {
        Name = name;
    }

    public String getPassword() {
        return Password;
    }

    public void setPassword(String password) {
        Password = password;
    }

    public String getUserName() {
        return UserName;
    }

    public void setUserName(String userName) {
        UserName = userName;
    }

    public String getWebsite() {
        return Website;
    }

    public void setWebsite(String website) {
        Website = website;
    }
}
