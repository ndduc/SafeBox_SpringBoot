package com.anifinders.safebox.service.Model;

import com.anifinders.safebox.repository.Model.GalleryModel;

public class GalleryModelDAO {
    private String key;
    private String fileName;
    private String contentType;
    private String extension;
    // This for base64 image
    private String imageSource = "";

    private String timeStamp;

    public GalleryModelDAO() {

    }

    public GalleryModelDAO(GalleryModel model) {
        this.key = model.getKey();
        this.fileName = model.getFileName();
        this.contentType = model.getContentType();
        this.extension = model.getExtension();
        this.imageSource = model.getImageSource();
        this.timeStamp = model.getTimeStamp();
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
