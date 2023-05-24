package com.anifinders.safebox.repository;

import com.amazonaws.services.dynamodbv2.AmazonDynamoDB;
import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBAttribute;
import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBMapper;
import com.amazonaws.services.dynamodbv2.model.*;
import com.anifinders.safebox.helper.dynamo.GsiMapper;
import com.anifinders.safebox.repository.Interface.IDynamoDbRepos;
import com.anifinders.safebox.repository.Model.SafeBoxModel;
import org.springframework.stereotype.Repository;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.anifinders.safebox.helper.dynamo.CompareOperator.operatorBegin;
import static com.anifinders.safebox.helper.dynamo.CompareOperator.operatorEqual;
import static com.anifinders.safebox.helper.dynamo.Gsi.safeBoxGSI;

@Repository
public class DynamoDbRepos implements IDynamoDbRepos {
    private AmazonDynamoDB amazonDynamoDB;

    private DynamoDBMapper dynamoDBMapper;

    private final String rangeKey = "RangeKey";
    private final String hashKey = "HashKey";

    public DynamoDbRepos(
            AmazonDynamoDB amazonDynamoDB
    )
    {
        this.amazonDynamoDB = amazonDynamoDB;
        dynamoDBMapper = new DynamoDBMapper(this.amazonDynamoDB);
    }

    private final String tableName = "SafeBox";



    public  List<SafeBoxModel> searchSafeBox(String searchText, String option) {

        String hk;
        GsiMapper gsiMapper;
        QueryResult result;
        if (option.equalsIgnoreCase("location")) {
            hk = "LOCATION";
            gsiMapper = safeBoxGSI.get("GSI1");
            result = queryBeginWith(hk, searchText, gsiMapper);
        } else if (option.equalsIgnoreCase("user")) {
            hk = "NAME";
            gsiMapper = safeBoxGSI.get("GSI2");
            result = queryBeginWith(hk, searchText, gsiMapper);
        } else {
            hk = "LOCATION";
            gsiMapper = safeBoxGSI.get("GSI1");
            result = queryWithHashKey(hk, gsiMapper);
        }
        List<SafeBoxModel> items = new ArrayList<>();
        for(Map<String, AttributeValue> item : result.getItems()) {
            SafeBoxModel safeBox = dynamoDBMapper.marshallIntoObject(SafeBoxModel.class, item);
            items.add(safeBox);
        }
        return items;
    }


    public void addUpdateSafeBox(SafeBoxModel model) {
        putItem(model);
    }

    public SafeBoxModel getSafeBox(String hashKey, String rangeKey) {
        var result = getItem(hashKey, rangeKey);
        var dataAfterMapper = dynamoDBMapper.marshallIntoObject(SafeBoxModel.class, result.getItem());
        return dataAfterMapper;
    }

    private GetItemResult getItem(String hashKey, String rangeKey) {
        Map<String, AttributeValue> key = new HashMap<>();
        key.put(this.hashKey, new AttributeValue().withS(hashKey));
        key.put(this.rangeKey, new AttributeValue().withS(rangeKey));

        GetItemRequest getItemRequest = new GetItemRequest()
                .withTableName(tableName)
                .withKey(key);

        return this.amazonDynamoDB.getItem(getItemRequest);

    }

    private <T> PutItemResult putItem(T model) {
        PutItemRequest request = new PutItemRequest()
                .withTableName(this.tableName)
                .withItem(convertToAttributeValueMap(model));
        var result = amazonDynamoDB.putItem(request);
        return result;
    }

    private <T> Map<String, AttributeValue> convertToAttributeValueMap(T model) {
        Map<String, AttributeValue> item = new HashMap<>();

        Field[] fields = model.getClass().getDeclaredFields();
        for (Field field : fields) {
            field.setAccessible(true);
            String fieldName = field.getName();
            String attributeName = getAttributeName(field);
            Object fieldValue;
            try {
                fieldValue = field.get(model);
            } catch (IllegalAccessException e) {
                throw new RuntimeException("Error accessing field value: " + fieldName, e);
            }
            AttributeValue attributeValue = new AttributeValue(fieldValue.toString());
            item.put(attributeName, attributeValue);
        }

        return item;
    }

    private String getAttributeName(Field field) {
        DynamoDBAttribute attribute = field.getAnnotation(DynamoDBAttribute.class);
        if (attribute != null && !attribute.attributeName().isEmpty()) {
            return attribute.attributeName();
        } else {
            return field.getName();
        }
    }

    private QueryResult queryBeginWith(String hashKey, String rangeKey, GsiMapper gsiMapper) {
        QueryRequest queryRequest = new QueryRequest().withTableName(this.tableName).withIndexName(gsiMapper.getIndex())
                .withKeyConditionExpression(operatorEqual(gsiMapper.getHk(), ":value1") + " and " + operatorBegin(gsiMapper.getRk(), ":value2"))
                .withExpressionAttributeValues(
                        Map.of(
                                ":value1", new AttributeValue().withS(hashKey),
                                ":value2", new AttributeValue().withS(rangeKey)
                        )
                );
        return amazonDynamoDB.query(queryRequest);
    }

    private QueryResult queryWithHashKey(String hashKey, GsiMapper gsiMapper) {
        QueryRequest queryRequest = new QueryRequest().withTableName(this.tableName).withIndexName(gsiMapper.getIndex())
                .withKeyConditionExpression(operatorEqual(gsiMapper.getHk(), ":value1"))
                .withExpressionAttributeValues(
                        Map.of(
                                ":value1", new AttributeValue().withS(hashKey)
                        )
                );
        return amazonDynamoDB.query(queryRequest);
    }
}
