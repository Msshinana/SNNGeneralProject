//
//  CommonMethod.m
//  SNNGeneralProject
//
//  Created by dzcx-shinana on 2017/11/22.
//  Copyright © 2017年 dzcx-shinana. All rights reserved.
//

#import "CommonMethod.h"

@implementation CommonMethod
//获取当前时间
+ (NSString *) getTime
{
    NSDateFormatter *formater = [[ NSDateFormatter alloc] init];
    NSDate *curDate = [NSDate date];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString * curTime = [formater stringFromDate:curDate];
    return curTime;
}
//获取图片名称
+ (NSString *) getImageName:(UIImage *)image{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *destDateString = [dateFormatter stringFromDate:[NSDate date]];
    
    NSString *contentType = nil;
    NSData *mData                     = [NSData data];
    NSString *imageType;
    if (contentType == nil)
    {
        mData = UIImageJPEGRepresentation(image, 0.5);
        if (mData == nil)
        {
            mData     = UIImagePNGRepresentation(image);
            imageType = @"image/png";
            destDateString=[destDateString stringByAppendingString:@".png"];
        }
        else
        {
            imageType = @"image/jpg";
            destDateString=[destDateString stringByAppendingString:@".jpg"];
        }
    }
    else
    {
        NSString *type = [[contentType componentsSeparatedByString:@"/"] lastObject];
        if ([type isEqualToString:@"png"])
        {
            mData = UIImagePNGRepresentation(image);
            destDateString=[destDateString stringByAppendingString:@".png"];
        }
        else if ([type isEqualToString:@"jpg"])
        {
            mData = UIImageJPEGRepresentation(image, 1.0);
            destDateString=[destDateString stringByAppendingString:@".jpg"];
        }
        imageType = contentType;
    }
    return destDateString;
}
//按指定宽度压缩图片
+ (UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth{
    
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    if(CGSizeEqualToSize(imageSize, size) == NO){
        
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        if(widthFactor > heightFactor){
            
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
            
        }else if(widthFactor < heightFactor){
            
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil){
        
        NSLog(@"scale image fail");
    }
    UIGraphicsEndImageContext();
    return newImage;
}
@end
