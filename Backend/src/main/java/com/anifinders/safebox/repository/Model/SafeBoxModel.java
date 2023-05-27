package com.anifinders.safebox.repository.Model;

import com.amazonaws.services.dynamodbv2.datamodeling.*;

import lombok.*;

@DynamoDBTable(tableName = "${aws.dynamo.table.safe-box}")
public class SafeBoxModel {

    private String HashKey;
    private String RangeKey;
    private String createdDatetime;
    private String gsi_HK_1;
    private String gsi_HK_2;
    private String gsi_RK_1;
    private String gsi_RK_2;

    @Deprecated
    private String id;
    private String location;
    private String modifiedDatetime;
    private String name;
    private String password;
    private String userName;
    private String website;

    public SafeBoxModel() {

    }
    public SafeBoxModel(String hashKey, String rangeKey, String createdDatetime, String gsi_HK_1, String gsi_HK_2, String gsi_RK_1, String gsi_RK_2, String id, String location, String modifiedDatetime, String name, String password, String userName, String website) {
        HashKey = hashKey;
        RangeKey = rangeKey;
        this.createdDatetime = createdDatetime;
        this.gsi_HK_1 = gsi_HK_1;
        this.gsi_HK_2 = gsi_HK_2;
        this.gsi_RK_1 = gsi_RK_1;
        this.gsi_RK_2 = gsi_RK_2;
        this.id = id;
        this.location = location;
        this.modifiedDatetime = modifiedDatetime;
        this.name = name;
        this.password = password;
        this.userName = userName;
        this.website = website;
    }

    @DynamoDBHashKey(attributeName = "HashKey")
    public String getHashKey() {
        return HashKey;
    }

    public void setHashKey(String hashKey) {
        HashKey = hashKey;
    }

    @DynamoDBRangeKey(attributeName = "RangeKey")
    public String getRangeKey() {
        return RangeKey;
    }

    public void setRangeKey(String rangeKey) {
        RangeKey = rangeKey;
    }

    @DynamoDBAttribute(attributeName = "CreatedDatetime")
    public String getCreatedDatetime() {
        return createdDatetime;
    }

    public void setCreatedDatetime(String createdDatetime) {
        this.createdDatetime = createdDatetime;
    }
    @DynamoDBIndexHashKey(globalSecondaryIndexName = "GSI_HK_1-GSI_RK_1-index", attributeName ="GSI_HK_1")
    public String getGsi_HK_1() {
        return gsi_HK_1;
    }

    public void setGsi_HK_1(String gsi_HK_1) {
        this.gsi_HK_1 = gsi_HK_1;
    }
    @DynamoDBIndexHashKey(globalSecondaryIndexName = "GSI_HK_2-GSI_RK_2-index", attributeName ="GSI_HK_2")
    public String getGsi_HK_2() {
        return gsi_HK_2;
    }

    public void setGsi_HK_2(String gsi_HK_2) {
        this.gsi_HK_2 = gsi_HK_2;
    }
    @DynamoDBIndexRangeKey(globalSecondaryIndexName  = "GSI_HK_1-GSI_RK_1-index", attributeName ="GSI_RK_1")
    public String getGsi_RK_1() {
        return gsi_RK_1;
    }

    public void setGsi_RK_1(String gsi_RK_1) {
        this.gsi_RK_1 = gsi_RK_1;
    }
    @DynamoDBIndexRangeKey(globalSecondaryIndexName = "GSI_HK_2-GSI_RK_2-index", attributeName ="GSI_RK_2")
    public String getGsi_RK_2() {
        return gsi_RK_2;
    }

    public void setGsi_RK_2(String gsi_RK_2) {
        this.gsi_RK_2 = gsi_RK_2;
    }
    @DynamoDBAttribute(attributeName = "Id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
    @DynamoDBAttribute(attributeName = "Location")
    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }
    @DynamoDBAttribute(attributeName = "ModifiedDatetime")
    public String getModifiedDatetime() {
        return modifiedDatetime;
    }

    public void setModifiedDatetime(String modifiedDatetime) {
        this.modifiedDatetime = modifiedDatetime;
    }
    @DynamoDBAttribute(attributeName = "Name")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    @DynamoDBAttribute(attributeName = "Password")
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
    @DynamoDBAttribute(attributeName = "UserName")
    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }
    @DynamoDBAttribute(attributeName = "Website")
    public String getWebsite() {
        return website;
    }

    public void setWebsite(String website) {
        this.website = website;
    }
}
