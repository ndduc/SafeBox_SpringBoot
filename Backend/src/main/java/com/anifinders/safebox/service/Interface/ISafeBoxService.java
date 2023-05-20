package com.anifinders.safebox.service.Interface;

import com.anifinders.safebox.repository.Model.SafeBoxModel;
import com.anifinders.safebox.service.Model.ResponseObject;
import com.anifinders.safebox.service.Model.SafeBoxModelDAO;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface ISafeBoxService {
    ResponseObject searchSafeBox(String searchText, String option);
    void addUpdateSafeBox(SafeBoxModelDAO dao);
    ResponseObject getSafeBox(String rangeKey);
}
