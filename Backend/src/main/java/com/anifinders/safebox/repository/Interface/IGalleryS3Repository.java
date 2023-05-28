package com.anifinders.safebox.repository.Interface;

import com.anifinders.safebox.repository.Model.GalleryModel;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface IGalleryS3Repository {
    String getImageByKey();
    List<GalleryModel> getImages();
}
