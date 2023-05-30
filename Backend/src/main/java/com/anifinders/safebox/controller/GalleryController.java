package com.anifinders.safebox.controller;

import com.anifinders.safebox.service.Interface.IGalleryService;
import com.anifinders.safebox.service.Interface.ISafeBoxService;
import com.anifinders.safebox.service.Model.GalleryModelDAO;
import com.anifinders.safebox.service.Model.ResponseObject;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.nio.charset.StandardCharsets;
import java.util.Arrays;
import java.util.List;

@RestController
@RequestMapping("/api/gallery")
@Slf4j
public class GalleryController {
    @Value("${safebox.api.key}")
    private String APIKEY;

    @Autowired
    IGalleryService galleryService;

    @GetMapping(path = "/get-image")
    public ResponseEntity<String> getImage(@RequestHeader("spring-api-key") String apiKey) {
        if (apiKey.equals(APIKEY)) {
            String imageBytes = galleryService.getImageByKey();
            return ResponseEntity.ok(imageBytes);
        } else {
            String errorMessage = "Unauthorized access: Invalid API key.";
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body(errorMessage);
        }

    }

    @GetMapping(path = "/get-image-list")
    public ResponseEntity<ResponseObject<List<GalleryModelDAO>>> getImageList(@RequestHeader("spring-api-key") String apiKey) {
        ResponseObject<List<GalleryModelDAO>> response = new ResponseObject<>();
        if (apiKey.equals(APIKEY)) {
            response = galleryService.getImagesQuery();
            return ResponseEntity.ok(response);
        } else {
            String errorMessage = "Unauthorized access: Invalid API key.";
            response.setErrors(Arrays.asList(errorMessage));
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body(response);
        }

    }

    @GetMapping(path = "/upload-image-console")
    public ResponseEntity<String> UploadImageFromDirectory(@RequestHeader("spring-api-key") String apiKey) {
        if (apiKey.equals(APIKEY)) {
            galleryService.UploadImageFromDirectory();
            return ResponseEntity.ok("OK");
        } else {
            String errorMessage = "Unauthorized access: Invalid API key.";
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body(errorMessage);
        }

    }

}
