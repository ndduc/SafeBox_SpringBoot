package com.anifinders.safebox.repository.Interface;

import com.anifinders.safebox.repository.Model.GalleryModel;

import java.util.List;

public interface IGalleryDynamoRepository {
    void putItemWithJsonModel(GalleryModel model);
    List<GalleryModel> getImagesByQuery();
}
