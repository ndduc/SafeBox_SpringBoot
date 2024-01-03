package com.anifinders.safebox.service;

import com.amazonaws.services.dynamodbv2.AmazonDynamoDB;
import com.anifinders.safebox.console.AddImageToS3AndDynamo;
import com.anifinders.safebox.console.interfaces.IAddImageToS3AndDynamo;
import com.anifinders.safebox.repository.GalleryDynamoRepository;
import com.anifinders.safebox.repository.GalleryS3Repository;
import com.anifinders.safebox.repository.Interface.IGalleryDynamoRepository;
import com.anifinders.safebox.repository.Interface.IGalleryS3Repository;
import com.anifinders.safebox.repository.Model.GalleryModel;
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
    private IAddImageToS3AndDynamo addImageToS3AndDynamo;
    private IGalleryDynamoRepository galleryDynamoRepository;
    private final String emptyString = "";

    public GalleryService(AmazonDynamoDB amazonDynamoDB, S3Client s3Client) {

        this.galleryS3Repository = new GalleryS3Repository(s3Client);
        this.addImageToS3AndDynamo = new AddImageToS3AndDynamo();
        this.galleryDynamoRepository = new GalleryDynamoRepository(amazonDynamoDB);
    }

    public String getImageByKey() {
       return galleryS3Repository.getImageByKey("test");
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

    public  ResponseObject<List<GalleryModelDAO>> getImagesQuery() {
        ResponseObject<List<GalleryModelDAO>> responseObject = new ResponseObject<>();
        List<GalleryModelDAO> daoList = new ArrayList<>();
        try {
            var results = this.galleryDynamoRepository.getImagesByQuery();
            for(int i = 0; i < results.size(); i++) {
                String key = "";
                if (results.get(i).getAuthor().isEmpty()) {
                    key = results.get(i).getKey() + "/" + results.get(i).getFileName() + results.get(i).getExtension();
                } else {
                    key = results.get(i).getAuthor() + "/"
                            + results.get(i).getSubDirectoryName() + "/"
                            + results.get(i).getKey() + "/"
                            + results.get(i).getFileName()
                            + results.get(i).getExtension();
                }
                var itemBased64 = galleryS3Repository.getImageByKey(key);
                results.get(i).setImageSource(itemBased64);
                GalleryModelDAO dao = new GalleryModelDAO(results.get(i));
                daoList.add(dao);
            }
            responseObject.setDataObject(daoList);
        } catch (Exception e) {
            responseObject.setErrors(new ArrayList<>(Arrays.asList(e.getMessage())));
        }

        return responseObject;
    }

    public void UploadImageFromDirectory() {
        boolean isSubDir = true;
        var images = this.addImageToS3AndDynamo.readImagesFromFile("I:\\Storage\\Image\\dksha19\\dumb", isSubDir);
        for(int i = 0; i < images.size(); i++) {
            try {
                this.galleryS3Repository.updateImages(images.get(i), isSubDir);
                var model = new GalleryModel(images.get(i), emptyString, emptyString, images.get(i).getType());
                this.galleryDynamoRepository.putItemWithJsonModel(model);
            } catch (Exception e) {
                e.printStackTrace();
            }

        }
    }
}
