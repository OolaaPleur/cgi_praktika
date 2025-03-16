package com.example.flightbooking.service;

import org.springframework.stereotype.Service;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.core.io.ClassPathResource;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.io.File;
import java.io.IOException;

@Service
public class ImageService {
    
    private final String imageCacheDir = "cache/images";
    
    public Resource getImage(String photoId) {
        try {
            // Check if image exists in cache
            Path imagePath = Paths.get(imageCacheDir, photoId + ".jpg");
            File imageFile = imagePath.toFile();
            
            if (imageFile.exists()) {
                Resource resource = new UrlResource(imagePath.toUri());
                if (resource.isReadable()) {
                    return resource;
                }
            }
            
            // Try to load default image from classpath
            Resource defaultResource = new ClassPathResource("static/images/default_city.jpg");
            if (defaultResource.exists()) {
                return defaultResource;
            }
            
            throw new IOException("Image not found: " + photoId);
        } catch (IOException e) {
            throw new RuntimeException("Error retrieving image for photoId: " + photoId, e);
        }
    }
}
