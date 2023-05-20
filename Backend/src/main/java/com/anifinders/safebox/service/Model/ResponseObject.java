package com.anifinders.safebox.service.Model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@NoArgsConstructor
public class ResponseObject<T> {
    T dataObject;
    List<String> errors = new ArrayList<>();

    public T getDataObject() {
        return dataObject;
    }

    public void setDataObject(T dataObject) {
        this.dataObject = dataObject;
    }

    public List<String> getErrors() {
        return errors;
    }

    public void setErrors(List<String> errors) {
        this.errors = errors;
    }
}
