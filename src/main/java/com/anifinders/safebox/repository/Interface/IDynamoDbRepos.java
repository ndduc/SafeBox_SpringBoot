package com.anifinders.safebox.repository.Interface;

import com.anifinders.safebox.repository.Model.SafeBoxModel;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface IDynamoDbRepos {
    List<SafeBoxModel> searchSafeBoxByLocation(String location);
    void addUpdateSafeBox(SafeBoxModel model);

    SafeBoxModel getSafeBox(String hashKey, String rangeKey);
}
