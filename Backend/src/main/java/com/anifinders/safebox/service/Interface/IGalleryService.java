package com.anifinders.safebox.service.Interface;

import com.anifinders.safebox.service.Model.GalleryModelDAO;
import com.anifinders.safebox.service.Model.ResponseObject;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface IGalleryService {
    String getImageByKey();
    ResponseObject<List<GalleryModelDAO>> getImages();
}
