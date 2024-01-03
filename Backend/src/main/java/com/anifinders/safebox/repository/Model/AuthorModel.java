package com.anifinders.safebox.repository.Model;

public class AuthorModel {
    /**
     * Persist this into another table or the same table with Gallery. Dont matter
     * key
     * Author Name
     * */

    private String key;
    private String authorName;
    private String timeStamp;

    public AuthorModel() {

    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public String getAuthorName() {
        return authorName;
    }

    public void setAuthorName(String authorName) {
        this.authorName = authorName;
    }

    public String getTimeStamp() {
        return timeStamp;
    }

    public void setTimeStamp(String timeStamp) {
        this.timeStamp = timeStamp;
    }
}
