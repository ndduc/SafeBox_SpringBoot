package com.anifinders.safebox.repository;

import com.amazonaws.services.dynamodbv2.AmazonDynamoDB;
import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBMapper;
import com.amazonaws.services.dynamodbv2.model.AttributeValue;
import com.amazonaws.services.dynamodbv2.model.PutItemRequest;
import com.amazonaws.services.dynamodbv2.model.PutItemResult;
import com.anifinders.safebox.repository.Interface.IGalleryDynamoRepository;
import com.anifinders.safebox.repository.Model.GalleryModel;
import com.google.gson.Gson;

import java.lang.reflect.Field;
import java.util.HashMap;
import java.util.Map;

public class GalleryDynamoRepository implements IGalleryDynamoRepository {
    private AmazonDynamoDB amazonDynamoDB;

    private DynamoDBMapper dynamoDBMapper;

    private final String rangeKey = "RangeKey";
    private final String hashKey = "HashKey";
    private final String dataObject = "DataObject";
    private final String hkKeyValue = "Gallery_Anime";

    public GalleryDynamoRepository(
            AmazonDynamoDB amazonDynamoDB
    )
    {
        this.amazonDynamoDB = amazonDynamoDB;
        dynamoDBMapper = new DynamoDBMapper(this.amazonDynamoDB);
    }

    private final String tableName = "Gallery";

    public void putItemWithJsonModel(GalleryModel model) {
        Gson gson = new Gson();
        var objectString = gson.toJson(model);
        Map<String, AttributeValue> item = new HashMap<>();
        item.put(hashKey, new AttributeValue(hkKeyValue));
        item.put(rangeKey, new AttributeValue(model.getKey()));
        item.put(dataObject, new AttributeValue(objectString));

        PutItemRequest putRequest = new PutItemRequest()
                .withTableName(tableName)
                .withItem(item);

        amazonDynamoDB.putItem(putRequest);
    }

}
