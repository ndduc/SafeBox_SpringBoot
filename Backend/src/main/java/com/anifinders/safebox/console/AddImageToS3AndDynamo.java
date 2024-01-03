package com.anifinders.safebox.console;

import com.anifinders.safebox.console.Model.ImageFromFileModel;
import com.anifinders.safebox.console.interfaces.IAddImageToS3AndDynamo;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class AddImageToS3AndDynamo implements IAddImageToS3AndDynamo {
    private final String emptyString = "";
    public List<ImageFromFileModel> readImagesFromFile(String directoryPath, boolean isSubDirAvail) {
        String author = "DKSHA19";
        String pattern = "^(.+)\\.\\w+$";
        File directory = new File(directoryPath);
        List<ImageFromFileModel> imageList = new ArrayList<>();
        if (directory.exists() && directory.isDirectory()) {
            File[] files = directory.listFiles();
            for(File file : files) {
                if (!isSubDirAvail) {
                    if (file.isFile() && isPhotoFile(file)) {
                        try {
                            imageList.add(fileHelper(file, author, pattern, emptyString));
                        } catch (Exception e) {
                            // Error
                        }
                    }
                }
                else {
                    File subDirectory = new File(directoryPath + "/" + file.getName());
                    if (subDirectory.exists() && subDirectory.isDirectory()) {
                        File[] subFiles = subDirectory.listFiles();
                        for(File subFile: subFiles) {
                            if (subFile.isFile() && isPhotoFile(subFile)) {
                                try {
                                    imageList.add(fileHelper(subFile, author, pattern, file.getName()));
                                } catch (Exception e) {
                                    // Error
                                }
                            }
                        }
                    }
                }

            }
        }
        return imageList;
    }

    private ImageFromFileModel fileHelper(File file, String author ,String pattern, String subDirName) throws Exception {
            try {
                UUID uniqueId = UUID.randomUUID();
                Pattern regexPattern = Pattern.compile(pattern);
                Matcher matcher = regexPattern.matcher(file.getName());

                String fileName = file.getName();
                if (matcher.matches()) {
                    fileName = matcher.group(1);
                }


                byte[] fileBytes = Files.readAllBytes(file.toPath());
                ByteArrayInputStream inputStream = new ByteArrayInputStream(fileBytes);
                BufferedImage image = ImageIO.read(inputStream);
                ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
                ImageIO.write(image, "png", outputStream);
                byte[] pngBytes = outputStream.toByteArray();
                ImageFromFileModel imageModel = new ImageFromFileModel(
                        uniqueId.toString(), "original",
                        pngBytes, "image/png", ".png",
                        author, subDirName);
                return imageModel;
            } catch (Exception e) {
                // error
                throw new Exception(e.getMessage());
            }
    }

    // Helper method to check if a file has a photo file extension
    private static boolean isPhotoFile(File file) {
        String fileName = file.getName().toLowerCase();
        return fileName.endsWith(".jpg") || fileName.endsWith(".jpeg") ||
                fileName.endsWith(".png");
        // Add more photo file extensions as needed
    }
}
