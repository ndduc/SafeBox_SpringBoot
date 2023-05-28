package com.anifinders.safebox.repository;
import com.anifinders.safebox.repository.Interface.IGalleryS3Repository;
import com.anifinders.safebox.repository.Model.GalleryModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import software.amazon.awssdk.core.ResponseBytes;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.GetObjectRequest;
import software.amazon.awssdk.services.s3.model.GetObjectResponse;
import software.amazon.awssdk.services.s3.model.S3Object;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Base64;
import java.util.List;

@Repository
public class GalleryS3Repository implements IGalleryS3Repository {
    private final S3Client s3Client;

    @Autowired
    public GalleryS3Repository(S3Client s3Client) {
        this.s3Client = s3Client;
    }

    private List<String> testImageList = new ArrayList<>(Arrays.asList("madoka_land.jpg", "madoka_por_l.jpg", "madoka_por.jpg"));
    private final String imageBucket = "hpic-anime";

    public List<GalleryModel> getImages() {
        List<GalleryModel> galleryModelList = new ArrayList<>();
        for(var key : testImageList) {
            GetObjectRequest getObjectRequest = GetObjectRequest.builder()
                    .bucket(imageBucket)
                    .key(key)
                    .build();
            ResponseBytes<GetObjectResponse> getObjectResponse = s3Client.getObjectAsBytes(getObjectRequest);
            byte[] imageBytes = getObjectResponse.asByteArray();
            String base64Image = Base64.getEncoder().encodeToString(imageBytes);
            GalleryModel model = new GalleryModel();
            model.setImageSource(base64Image);
            model.setKey(key);
            galleryModelList.add(model);
        }

        return galleryModelList;
    }
    public String getImageByKey() {
        GetObjectRequest getObjectRequest = GetObjectRequest.builder()
                .bucket(imageBucket)
                .key("madoka_land.jpg")
                .build();

        ResponseBytes<GetObjectResponse> getObjectResponse = s3Client.getObjectAsBytes(getObjectRequest);
        byte[] imageBytes = getObjectResponse.asByteArray();
        String base64Image = Base64.getEncoder().encodeToString(imageBytes);
        return base64Image;
    }
}
