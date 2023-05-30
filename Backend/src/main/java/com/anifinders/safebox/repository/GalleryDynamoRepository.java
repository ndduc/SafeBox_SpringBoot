package com.anifinders.safebox.repository;

import com.amazonaws.services.dynamodbv2.AmazonDynamoDB;
import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBMapper;
import com.amazonaws.services.dynamodbv2.model.*;
import com.anifinders.safebox.helper.dynamo.GsiMapper;
import com.anifinders.safebox.repository.Interface.IGalleryDynamoRepository;
import com.anifinders.safebox.repository.Model.GalleryModel;
import com.google.gson.Gson;

import java.lang.reflect.Field;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.anifinders.safebox.helper.dynamo.CompareOperator.operatorEqual;

public class GalleryDynamoRepository implements IGalleryDynamoRepository {
    private AmazonDynamoDB amazonDynamoDB;

    private DynamoDBMapper dynamoDBMapper;

    private final String rangeKey = "RangeKey";
    private final String hashKey = "HashKey";
    private final String dataObject = "DataObject";
    private final String hkKeyValue = "Gallery_Anime";
    private final String timeStamp = "TimeStamp";

    public GalleryDynamoRepository(
            AmazonDynamoDB amazonDynamoDB
    )
    {
        this.amazonDynamoDB = amazonDynamoDB;
        dynamoDBMapper = new DynamoDBMapper(this.amazonDynamoDB);
    }

    private final String tableName = "Gallery";

    public void putItemWithJsonModel(GalleryModel model) {
        LocalDateTime currentDateTime = LocalDateTime.now();
        model.setTimeStamp(currentDateTime.toString());
        Gson gson = new Gson();
        var objectString = gson.toJson(model);
        Map<String, AttributeValue> item = new HashMap<>();
        item.put(hashKey, new AttributeValue(hkKeyValue));
        item.put(rangeKey, new AttributeValue(model.getKey()));
        item.put(dataObject, new AttributeValue(objectString));
        item.put(timeStamp, new AttributeValue(model.getTimeStamp()));
        PutItemRequest putRequest = new PutItemRequest()
                .withTableName(tableName)
                .withItem(item);

        amazonDynamoDB.putItem(putRequest);
    }

    public List<GalleryModel> getImagesByQuery() {
        List<GalleryModel> galList = new ArrayList<>();
        Gson gson = new Gson();
        var result = queryWithHashKey(hkKeyValue);
        if (!result.getItems().isEmpty()) {
            for (int i = 0; i < result.getCount(); i++) {
                var item = result.getItems().get(i);
                GalleryModel galModel = gson.fromJson(item.get(dataObject).getS(), GalleryModel.class);
                galList.add(galModel);
            }
        }
        return galList;
    }

    private QueryResult queryWithHashKey(String hashKey) {
        QueryRequest queryRequest = new QueryRequest().withTableName(this.tableName)
                .withKeyConditionExpression(operatorEqual(this.hashKey, ":value1"))
                .withExpressionAttributeValues(
                        Map.of(
                                ":value1", new AttributeValue().withS(hashKey)
                        )
                );
        return amazonDynamoDB.query(queryRequest);
    }

}
