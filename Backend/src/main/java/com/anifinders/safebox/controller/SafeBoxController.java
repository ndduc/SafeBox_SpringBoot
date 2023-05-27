package com.anifinders.safebox.controller;

import com.anifinders.safebox.service.Interface.ISafeBoxService;
import com.anifinders.safebox.service.Model.SafeBoxModelDAO;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/safebox")
@Slf4j
public class SafeBoxController {

    @Value("${safebox.api.key}")
    private String APIKEY;
    @Autowired
    ISafeBoxService safeBoxService;
    Gson gson = new Gson();

    @GetMapping(path = "/search-location")
    public ResponseEntity<String> searchByLocation(@RequestHeader("spring-api-key") String apiKey, @RequestParam("l") String searchText,
                                                   @RequestParam("m") String option, @RequestParam("s") String sort) {
        if (apiKey.equals(APIKEY)) {
            var result = safeBoxService.searchSafeBox(searchText, option);
            return ResponseEntity.ok(gson.toJson(result));
        } else {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid Api Key");
        }

    }

    @GetMapping(path = "/get-safebox")
    public ResponseEntity<String> getSafeBox(@RequestHeader("spring-api-key") String apiKey, @RequestParam("rk") String rangeKey) {
        if (apiKey.equals(APIKEY)) {
            var result = safeBoxService.getSafeBox(rangeKey);
            return ResponseEntity.ok(gson.toJson(result));
        } else {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid Api Key");
        }

    }

    @PostMapping("/add-update-safebox")
    public ResponseEntity<String> addUpdateSafeBox(@RequestHeader("spring-api-key") String apiKey, @RequestBody SafeBoxModelDAO model) {
        if (apiKey.equals(APIKEY)) {
            safeBoxService.addUpdateSafeBox(model);
            return ResponseEntity.ok("OK");
        } else {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid Api Key");
        }
    }

    @PostMapping("/delete-safebox")
    public ResponseEntity<String> deleteUpdateSafeBox(@RequestHeader("spring-api-key") String apiKey, @RequestBody SafeBoxModelDAO model) {
        if (apiKey.equals(APIKEY)) {
            safeBoxService.deleteSafeBox(model);
            return ResponseEntity.ok("OK");
        } else {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid Api Key");
        }
    }

}
