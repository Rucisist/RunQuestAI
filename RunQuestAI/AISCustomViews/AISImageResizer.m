//
//  AISImageResizer.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 07.02.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import "AISImageResizer.h"

@implementation AISImageResizer

- (UIImage *)scaleImage:(UIImage *)originalImage toSize:(CGSize)size
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context = CGBitmapContextCreate(NULL, size.width, size.height, 8, 0, colorSpace, kCGImageAlphaPremultipliedLast);
    
    CGContextClearRect(context, CGRectMake(0, 0, size.width, size.height));
    
    if (originalImage.imageOrientation == UIImageOrientationRight) {
        CGContextRotateCTM(context, -M_PI_2);
        CGContextTranslateCTM(context, -size.height, 0.0f);
        CGContextDrawImage(context, CGRectMake(0, 0, size.height, size.width), originalImage.CGImage);
    }
    else
    {
        CGContextDrawImage(context, CGRectMake(0, 0, size.width, size.height), originalImage.CGImage);
    }
    
    CGImageRef scaledImage = CGBitmapContextCreateImage(context);
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    
    UIImage *image = [UIImage imageWithCGImage:scaledImage];
    CGImageRelease(scaledImage);
    
    return image;
}

- (CGSize)estimateNewSize:(CGSize)newSize forImage:(UIImage *)image
{
    if (image.size.width >= image.size.height)
    {
        newSize = CGSizeMake((image.size.width/image.size.height) * newSize.height, newSize.height);
    }
    else
    {
        newSize = CGSizeMake(newSize.width, (image.size.height/image.size.width) * newSize.width);
    }
    
    return newSize;
}

- (UIImage *)scaleImage:(UIImage *)image proportionallyToSize:(CGSize)newSize
{
    return [self scaleImage:image toSize: newSize];
}

@end
