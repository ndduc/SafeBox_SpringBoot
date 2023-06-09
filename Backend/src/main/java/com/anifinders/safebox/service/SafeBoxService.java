package com.anifinders.safebox.service;

import com.amazonaws.services.dynamodbv2.AmazonDynamoDB;
import com.anifinders.safebox.repository.DynamoDbRepos;
import com.anifinders.safebox.repository.Interface.IDynamoDbRepos;
import com.anifinders.safebox.repository.Model.SafeBoxModel;
import com.anifinders.safebox.service.Interface.ISafeBoxService;
import com.anifinders.safebox.service.Model.ResponseObject;
import com.anifinders.safebox.service.Model.SafeBoxModelDAO;
import org.springframework.stereotype.Service;
import java.time.LocalDateTime;

import java.util.*;

@Service
public class SafeBoxService implements ISafeBoxService {
    private IDynamoDbRepos dynamoDbRepos;
    private final String hashKey = "SAFEBOX-ENTITY";

    public SafeBoxService(AmazonDynamoDB amazonDynamoDB) {
        this.dynamoDbRepos = new DynamoDbRepos(amazonDynamoDB);
    }

    public ResponseObject searchSafeBox(String searchText, String option) {
        ResponseObject <List<SafeBoxModelDAO>> resObject = new ResponseObject<>();

        try {
            var dataList = this.dynamoDbRepos.searchSafeBox(searchText, option);
            List<SafeBoxModelDAO> models = new ArrayList<>();
            for(var model : dataList) {
                SafeBoxModelDAO dao = new SafeBoxModelDAO(model);
                models.add(dao);
            }
            // SORT DESC
            Collections.sort(models, Comparator.comparing(SafeBoxModelDAO::getModifiedDatetime).reversed());
            resObject.setDataObject(models);
        } catch (Exception e) {
            var errors = resObject.getErrors();
            errors.add(e.getMessage());
        }
        return resObject;
    }

    public void deleteSafeBox(SafeBoxModelDAO dao) {
        SafeBoxModel data = dao.convertToDataModel(dao);
        this.dynamoDbRepos.deleteSafeBox(data);
    }

    public void addUpdateSafeBox(SafeBoxModelDAO dao) {
        LocalDateTime currentDateTime = LocalDateTime.now();
        if (dao.getCreatedDatetime().isEmpty()) {
            dao.setCreatedDatetime(currentDateTime.toString());
            dao.setModifiedDatetime(currentDateTime.toString());
        } else {
            dao.setModifiedDatetime(currentDateTime.toString());
        }


        SafeBoxModel data = dao.convertToDataModel(dao);
        this.dynamoDbRepos.addUpdateSafeBox(data);
    }

    public ResponseObject getSafeBox(String rangeKey) {
        ResponseObject<SafeBoxModelDAO> responseObject = new ResponseObject();
        try {
            var result = this.dynamoDbRepos.getSafeBox(hashKey, rangeKey);
            SafeBoxModelDAO dao = new SafeBoxModelDAO(result);
            responseObject.setDataObject(dao);
        } catch (Exception e) {
            var errors = responseObject.getErrors();
            errors.add(e.getMessage());
            responseObject.setErrors(errors);
        }

        return responseObject;
    }
}
