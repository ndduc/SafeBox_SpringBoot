package com.anifinders.safebox.console.interfaces;

import com.anifinders.safebox.console.Model.ImageFromFileModel;

import java.util.List;

public interface IAddImageToS3AndDynamo {
    List<ImageFromFileModel> readImagesFromFile(String directoryPath);
}
