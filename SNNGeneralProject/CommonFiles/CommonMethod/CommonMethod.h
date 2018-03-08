//
//  CommonMethod.h
//  SNNGeneralProject
//
//  Created by dzcx-shinana on 2017/11/22.
//  Copyright © 2017年 dzcx-shinana. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CommonMethod : NSObject
+ (NSString *) getTime;
+ (NSString *) getImageName:(UIImage *)image;
+ (UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;
+ (UIImage *)getImageFromUrlString:(NSString *)urlString;
@end
