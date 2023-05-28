package com.anifinders.safebox.service;

import com.anifinders.safebox.repository.GalleryS3Repository;
import com.anifinders.safebox.repository.Interface.IGalleryS3Repository;
import com.anifinders.safebox.service.Interface.IGalleryService;
import com.anifinders.safebox.service.Model.GalleryModelDAO;
import com.anifinders.safebox.service.Model.ResponseObject;
import org.springframework.stereotype.Service;
import software.amazon.awssdk.services.s3.S3Client;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Service
public class GalleryService implements IGalleryService {
    private IGalleryS3Repository galleryS3Repository;

    public GalleryService(S3Client s3Client) {
        this.galleryS3Repository = new GalleryS3Repository(s3Client);
    }

    public String getImageByKey() {
       return galleryS3Repository.getImageByKey();
    }

    public ResponseObject<List<GalleryModelDAO>> getImages() {
        ResponseObject<List<GalleryModelDAO>> responseObject = new ResponseObject<>();
        List<GalleryModelDAO> daoList = new ArrayList<>();
        try {
            var images = galleryS3Repository.getImages();
            if (!images.isEmpty()) {
                for(int i = 0; i < images.size(); i++) {
                    GalleryModelDAO dao = new GalleryModelDAO(images.get(i));
                    daoList.add(dao);
                }
            }
        } catch (Exception e) {
            responseObject.setErrors(new ArrayList<>(Arrays.asList(e.getMessage())));
        }
        responseObject.setDataObject(daoList);
        return responseObject;
    }

}
