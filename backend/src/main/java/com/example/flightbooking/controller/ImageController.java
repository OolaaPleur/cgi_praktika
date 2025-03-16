package com.example.flightbooking.controller;

import com.example.flightbooking.service.ImageService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;

@RestController
@RequestMapping("/api/images")
@Tag(name = "Image", description = "Image management APIs")
public class ImageController {
    
    private final ImageService imageService;

    public ImageController(ImageService imageService) {
        this.imageService = imageService;
    }

    @Operation(summary = "Get image by ID", description = "Retrieves an image from the system.")
    @ApiResponses({
        @ApiResponse(responseCode = "200", description = "Image retrieved successfully"),
        @ApiResponse(responseCode = "404", description = "Image not found")
    })
    @GetMapping("/{photoId}")
    public ResponseEntity<Resource> getImage(
        @Parameter(description = "ID of the image") @PathVariable String photoId
    ) {
        Resource resource = imageService.getImage(photoId);
        return ResponseEntity.ok()
                .contentType(MediaType.IMAGE_JPEG)
                .header(HttpHeaders.CACHE_CONTROL, "max-age=3600, must-revalidate")
                .body(resource);
    }

    @Operation(summary = "Get resized image", description = "Retrieves a resized version (600px width) of an image.")
    @ApiResponses({
        @ApiResponse(responseCode = "200", description = "Resized image retrieved successfully"),
        @ApiResponse(responseCode = "404", description = "Image not found"),
        @ApiResponse(responseCode = "500", description = "Image processing error")
    })
    @GetMapping("/medium/{photoId}")
    public ResponseEntity<ByteArrayResource> getResizedImage(
        @Parameter(description = "ID of the image") @PathVariable String photoId
    ) throws IOException {
        Resource originalResource = imageService.getImage(photoId);
        if (originalResource == null) {
            throw new IllegalArgumentException("Image not found for ID: " + photoId);
        }

        try (InputStream inputStream = originalResource.getInputStream();
             ByteArrayOutputStream outputStream = new ByteArrayOutputStream()) {

            BufferedImage originalImage = ImageIO.read(inputStream);
            int targetWidth = 600;
            int targetHeight = (int) ((double) originalImage.getHeight() / originalImage.getWidth() * targetWidth);

            BufferedImage resizedImage = new BufferedImage(targetWidth, targetHeight, BufferedImage.TYPE_INT_RGB);
            Graphics2D g2d = resizedImage.createGraphics();
            g2d.drawImage(originalImage, 0, 0, targetWidth, targetHeight, null);
            g2d.dispose();

            ImageIO.write(resizedImage, "jpg", outputStream);
            ByteArrayResource resource = new ByteArrayResource(outputStream.toByteArray());

            return ResponseEntity.ok()
                    .header(HttpHeaders.CONTENT_TYPE, "image/jpeg")
                    .header(HttpHeaders.CACHE_CONTROL, "max-age=3600, must-revalidate")
                    .body(resource);
        }
    }
}
