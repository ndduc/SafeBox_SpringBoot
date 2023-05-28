package com.anifinders.safebox.service.Model;

import com.anifinders.safebox.repository.Model.GalleryModel;

public class GalleryModelDAO {
    private String key;
    private String imageSource;

    public GalleryModelDAO() {

    }

    public GalleryModelDAO(GalleryModel model) {
        this.key = model.getKey();
        this.imageSource = model.getImageSource();
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public String getImageSource() {
        return imageSource;
    }

    public void setImageSource(String imageSource) {
        this.imageSource = imageSource;
    }
}
