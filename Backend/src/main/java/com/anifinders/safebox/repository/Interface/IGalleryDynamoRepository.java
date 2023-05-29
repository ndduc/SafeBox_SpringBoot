package com.anifinders.safebox.repository.Interface;

import com.anifinders.safebox.repository.Model.GalleryModel;

public interface IGalleryDynamoRepository {
    void putItemWithJsonModel(GalleryModel model);
}
