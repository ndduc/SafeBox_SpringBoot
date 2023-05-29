package com.anifinders.safebox.repository.Interface;

import com.anifinders.safebox.console.Model.ImageFromFileModel;
import com.anifinders.safebox.repository.Model.GalleryModel;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface IGalleryS3Repository {
    String getImageByKey();
    List<GalleryModel> getImages();
    void updateImages(ImageFromFileModel image);
}
