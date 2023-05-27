package com.anifinders.safebox.service.Model;

import com.anifinders.safebox.repository.Model.SafeBoxModel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.UUID;

public class SafeBoxModelDAO {
    private String hashKey;
    private String rangeKey;
    private String createdDatetime;

    @Deprecated
    private String id;
    private String location;
    private String modifiedDatetime;
    private String name;
    private String password;
    private String userName;
    private String website;

    public String getHashKey() {
        return hashKey;
    }

    public void setHashKey(String hashKey) {
        this.hashKey = hashKey;
    }

    public String getRangeKey() {
        return rangeKey;
    }

    public void setRangeKey(String rangeKey) {
        this.rangeKey = rangeKey;
    }

    public String getCreatedDatetime() {
        return createdDatetime;
    }

    public void setCreatedDatetime(String createdDatetime) {
        this.createdDatetime = createdDatetime;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getModifiedDatetime() {
        return modifiedDatetime;
    }

    public void setModifiedDatetime(String modifiedDatetime) {
        this.modifiedDatetime = modifiedDatetime;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getWebsite() {
        return website;
    }

    public void setWebsite(String website) {
        this.website = website;
    }

    public SafeBoxModelDAO() {

    }

    public SafeBoxModelDAO(SafeBoxModel data) {
        this.hashKey = data.getHashKey();
        this.rangeKey = data.getRangeKey();
        this.createdDatetime = data.getCreatedDatetime();
        this.id = data.getId();
        this.location = data.getLocation();
        this.modifiedDatetime = data.getModifiedDatetime();
        this.name = data.getName();
        this.password = data.getPassword();
        this.userName = data.getUserName();
        this.website = data.getWebsite();
    }

    public SafeBoxModel convertToDataModel(SafeBoxModelDAO dao) {
        SafeBoxModel data = new SafeBoxModel();
        data.setHashKey("SAFEBOX-ENTITY");

        if(!dao.getRangeKey().isEmpty()) {
            data.setRangeKey(dao.getRangeKey());
        }
        else {
            data.setRangeKey(UUID.randomUUID().toString());
        }
        data.setCreatedDatetime(dao.getCreatedDatetime());
        data.setGsi_HK_1("LOCATION");
        data.setGsi_RK_1(dao.getLocation());
        data.setGsi_HK_2("NAME");
        data.setGsi_RK_2(dao.getName());

        if(!dao.getId().isEmpty()) {
            data.setId(dao.getId());
        } else {
            data.setId("Deprecated");
        }
        data.setLocation(dao.getLocation());
        data.setModifiedDatetime(dao.getModifiedDatetime());
        data.setName(dao.getName());
        data.setPassword(dao.getPassword());
        data.setUserName(dao.getUserName());
        data.setWebsite(dao.getWebsite());

        return data;
    }

}
