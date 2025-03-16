package com.example.flightbooking.service;

import com.example.flightbooking.config.PexelsConfig;
import com.fasterxml.jackson.databind.JsonNode;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@Service
public class PexelsService {
    
    private static final Logger log = LoggerFactory.getLogger(PexelsService.class);
    
    private final RestTemplate restTemplate;
    private final PexelsConfig pexelsConfig;
    private final String imageCacheDir = "cache/images";
    
    public PexelsService(RestTemplate restTemplate, PexelsConfig pexelsConfig) {
        this.restTemplate = restTemplate;
        this.pexelsConfig = pexelsConfig;
        createCacheDirectory();
    }
    
    private void createCacheDirectory() {
        try {
            Path cachePath = Paths.get(imageCacheDir);
            if (!Files.exists(cachePath)) {
                Files.createDirectories(cachePath);
            }
        } catch (IOException e) {
            throw new RuntimeException("Failed to create image cache directory", e);
        }
    }
    

    public void cacheImage(String photoId) {
        if (Files.exists(Paths.get(imageCacheDir, photoId + ".jpg"))) {
            return;
        }
    
        String imageUrl = fetchImageUrlAndCache(photoId);
        if (imageUrl == null) {
            throw new IllegalArgumentException("Failed to fetch image URL for photoId: " + photoId);
        }
    }    
    
    private String fetchImageUrlAndCache(String photoId) {
        String url = String.format("https://api.pexels.com/v1/photos/%s", photoId);
        ResponseEntity<JsonNode> response = sendGetRequest(url, JsonNode.class);
    
        if (response.getBody() != null && response.getBody().has("src")) {
            String imageUrl = response.getBody().get("src").get("original").asText();
            downloadAndSaveImage(imageUrl, photoId);
            return imageUrl;
        }
        return null;
    }
    
    private void downloadAndSaveImage(String imageUrl, String photoId) {
        try {
            byte[] imageBytes = sendGetRequest(imageUrl, byte[].class).getBody();
            if (imageBytes != null) {
                Files.write(Paths.get(imageCacheDir, photoId + ".jpg"), imageBytes);
            }
        } catch (IOException e) {
            log.error("Failed to download image {}: {}", photoId, e.getMessage(), e);
            throw new RuntimeException("Error downloading image with ID: " + photoId, e);
        }
    }
    

    private <T> ResponseEntity<T> sendGetRequest(String url, Class<T> responseType) {
        HttpEntity<String> entity = new HttpEntity<>(createHeaders());
        return restTemplate.exchange(url, HttpMethod.GET, entity, responseType);
    }

    private HttpHeaders createHeaders() {
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", pexelsConfig.getApiKey());
        headers.set("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36");
        headers.set("Accept", "application/json");
        headers.set("Accept-Language", "en-US,en;q=0.9");
        return headers;
    }
} 