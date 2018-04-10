//
//  CCPrintBitmapTask.m
//  CMM
//
//  Created by qianye on 2018/2/1.
//  Copyright © 2018年 chemanman. All rights reserved.
//

#import "CCPrintBitmapTask.h"

#define kScaleRate     [[UIScreen mainScreen] scale]

@implementation CCPrintBitmapTask

+ (uint8_t *)printBitmapTaskOfText:(NSString *)text width:(uint32_t)width height:(uint32_t)height font:(NSInteger)font
{
    NSDictionary *textArrtibutes = @{ NSFontAttributeName : [UIFont systemFontOfSize:font] };
    CGRect drawRect = CGRectMake(0, 0, width, height);
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, height), NO, [[UIScreen mainScreen] scale]);
    [[UIColor whiteColor] set];
    UIRectFill(drawRect);
    [text drawInRect:drawRect withAttributes:textArrtibutes];
    
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [self getBitmapDataForImage:resultImage];
}

+ (uint8_t *)printBitmapTaskOfLine:(uint32_t)width height:(uint32_t)height
{
    UIGraphicsBeginImageContext(CGSizeMake(width * kScaleRate, height * kScaleRate));
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, height * kScaleRate);
    [[UIColor blackColor] set];
    
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, width * kScaleRate, 0);
    CGContextDrawPath(context, kCGPathStroke);
    
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [self getBitmapDataForImage:resultImage];
}

+ (uint8_t *)printBitmapTaskOfBarCode:(uint32_t)width height:(uint32_t)height
{
    return nil;
}

+ (uint8_t *)printBitmapTaskOfQrCode:(uint32_t)width height:(uint32_t)height
{
    return nil;
}

+ (uint8_t *)getBitmapDataForImage:(UIImage*)image
{
    CGImageRef imageRef = image.CGImage;
    CGContextRef context = [self newBitmapRGBA8ContextFromImage:imageRef];
    if (!context) {
        return NULL;
    }
    size_t width = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);
    CGRect rect = CGRectMake(0, 0, width, height);
    CGContextDrawImage(context, rect, imageRef);
    uint32_t *bitmapData = (uint32_t *)CGBitmapContextGetData(context);
    
    uint8_t *_bitmap = (uint8_t *)malloc(width * height);
    if (bitmapData) {
        memset(_bitmap, 0, width * height);
        // 二值化
        int k = 0;
        
        for (int i = 0; i < height; i++) {
            for (int j = 0; j < width; j++) {
                uint8_t *rgbaPixel = (uint8_t *) &bitmapData[i * width + j];
                uint32_t gray = 0.3 * rgbaPixel[3] + 0.59 * rgbaPixel[2] + 0.11 * rgbaPixel[1];
                
                if (gray > 127) {
                    _bitmap[k] = 0x00;  // black
                } else {
                    _bitmap[k] = 0x01;
                }
                k++;
            }
        }
    }
    free(bitmapData);
    CGContextRelease(context);
    return _bitmap;
}

+ (CGContextRef)newBitmapRGBA8ContextFromImage:(CGImageRef)image {
    CGContextRef    context = NULL;
    CGColorSpaceRef colorSpace;
    void *          bitmapData;
    size_t             bitmapByteCount;
    size_t             bitmapBytesPerRow;
    
    // Get image width, height. We'll use the entire image.
    size_t pixelsWide = CGImageGetWidth(image);
    size_t pixelsHigh = CGImageGetHeight(image);
    
    // Declare the number of bytes per row. Each pixel in the bitmap in this
    // example is represented by 4 bytes; 8 bits each of red, green, blue, and
    // alpha.
    bitmapBytesPerRow   = (pixelsWide * 4);
    bitmapByteCount     = (bitmapBytesPerRow * pixelsHigh);
    
    // Use the generic RGB color space.
    colorSpace = CGColorSpaceCreateDeviceRGB();
    if (colorSpace == NULL)
    {
        return NULL;
    }
    
    // Allocate memory for image data. This is the destination in memory
    // where any drawing to the bitmap context will be rendered.
    bitmapData = malloc( bitmapByteCount );
    if (bitmapData == NULL)
    {
        CGColorSpaceRelease( colorSpace );
        return NULL;
    }
    
    // Create the bitmap context. We want pre-multiplied ARGB, 8-bits
    // per component. Regardless of what the source image format is
    // (CMYK, Grayscale, and so on) it will be converted over to the format
    // specified here by CGBitmapContextCreate.
    context = CGBitmapContextCreate (bitmapData,
                                     pixelsWide,
                                     pixelsHigh,
                                     8,      // bits per component
                                     bitmapBytesPerRow,
                                     colorSpace,
                                     kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedLast);
    if (context == NULL)
    {
        free (bitmapData);
    }
    
    // Make sure and release colorspace before returning
    CGColorSpaceRelease( colorSpace );
    
    return context;
}

@end
