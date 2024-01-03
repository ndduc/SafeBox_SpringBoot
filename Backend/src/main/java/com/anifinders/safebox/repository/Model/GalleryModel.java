package com.anifinders.safebox.repository.Model;

import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBTable;
import com.anifinders.safebox.console.Model.ImageFromFileModel;

public class GalleryModel {
    /**
     * Note:
     *  add author, let go with author's key. GSI_1 HK
     *  add series, let go with series's key. GSI_2 HK
     *  add character, just do name as string, normalize it to uppercase and space as "_" . GSI_3 HK
     *  add search text (anything, could be character name, series, category). ATTRIBUTE for query
     *
     * */
    private String key;
    private String author = "";
    private String series = "";
    private String character = "";
    private String searchText = "";
    private String fileName;
    private String contentType;
    private String extension;
    // This for base64 image
    private String imageSource = "";

    private String subDirectoryName = "";

    private String timeStamp;

    public GalleryModel() {

    }

    public GalleryModel(ImageFromFileModel fileModel, String series, String character, String searchText) {
        this.key = fileModel.getKey();
        this.fileName = fileModel.getFileName();
        this.contentType = fileModel.getContentType();
        this.extension = fileModel.getExtension();
        this.author = fileModel.getAuthor();
        this.series = series;
        this.character = character;
        this.searchText = searchText;
        this.subDirectoryName = fileModel.getType();
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getContentType() {
        return contentType;
    }

    public void setContentType(String contentType) {
        this.contentType = contentType;
    }

    public String getExtension() {
        return extension;
    }

    public void setExtension(String extension) {
        this.extension = extension;
    }

    public String getImageSource() {
        return imageSource;
    }

    public void setImageSource(String imageSource) {
        this.imageSource = imageSource;
    }

    public String getTimeStamp() {
        return timeStamp;
    }

    public void setTimeStamp(String timeStamp) {
        this.timeStamp = timeStamp;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getSeries() {
        return series;
    }

    public void setSeries(String series) {
        this.series = series;
    }

    public String getCharacter() {
        return character;
    }

    public void setCharacter(String character) {
        this.character = character;
    }

    public String getSearchText() {
        return searchText;
    }

    public void setSearchText(String searchText) {
        this.searchText = searchText;
    }

    public String getSubDirectoryName() {
        return subDirectoryName;
    }

    public void setSubDirectoryName(String subDirectoryName) {
        this.subDirectoryName = subDirectoryName;
    }
}
