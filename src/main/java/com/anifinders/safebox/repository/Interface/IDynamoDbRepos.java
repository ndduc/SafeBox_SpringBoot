package com.anifinders.safebox.repository.Interface;

import com.anifinders.safebox.repository.Model.SafeBoxModel;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface IDynamoDbRepos {
    List<SafeBoxModel> searchSafeBox(String searchText, String option);
    void addUpdateSafeBox(SafeBoxModel model);

    SafeBoxModel getSafeBox(String hashKey, String rangeKey);
}
