package com.anifinders.safebox.console.Model;

public class ImageFromFileModel {
    private String key;
    private String fileName;
    private byte[] imageBytes;

    private String contentType;
    private String extension;

    public ImageFromFileModel(String key, String fileName, byte[] imageBytes, String contentType, String extension) {
        this.key = key;
        this.fileName = fileName;
        this.imageBytes = imageBytes;
        this.contentType = contentType;
        this.extension = extension;
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
}
