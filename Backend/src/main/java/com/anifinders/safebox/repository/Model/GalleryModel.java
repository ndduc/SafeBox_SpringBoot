package com.anifinders.safebox.repository.Model;

import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBTable;
import com.anifinders.safebox.console.Model.ImageFromFileModel;

public class GalleryModel {
    private String key;
    private String fileName;
    private String contentType;
    private String extension;
    // This for base64 image
    private String imageSource = "";

    private String timeStamp;

    public GalleryModel() {

    }

    public GalleryModel(ImageFromFileModel fileModel) {
        this.key = fileModel.getKey();
        this.fileName = fileModel.getFileName();
        this.contentType = fileModel.getContentType();
        this.extension = fileModel.getExtension();
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
}
