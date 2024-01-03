package com.anifinders.safebox.console.Model;

public class ImageFromFileModel {
    private String key;
    private String fileName;
    private byte[] imageBytes;

    private String contentType;
    private String extension;

    private String author;
    private String type;

    public ImageFromFileModel(String key, String fileName, byte[] imageBytes,
                              String contentType, String extension,
                              String author, String type) {
        this.key = key;
        this.fileName = fileName;
        this.imageBytes = imageBytes;
        this.contentType = contentType;
        this.extension = extension;
        this.author = author;
        this.type = type;
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

    public byte[] getImageBytes() {
        return imageBytes;
    }

    public void setImageBytes(byte[] imageBytes) {
        this.imageBytes = imageBytes;
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

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
}
