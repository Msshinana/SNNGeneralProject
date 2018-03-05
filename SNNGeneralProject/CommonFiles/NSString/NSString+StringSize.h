//
//  NSString+StringSize.h
//  SNNGeneralProject
//
//  Created by dzcx-shinana on 2017/11/22.
//  Copyright © 2017年 dzcx-shinana. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (StringSize)
- (CGSize)limitSize:(CGSize)size font:(UIFont *)font;
- (CGSize)limitSize:(CGSize)size attributes:(NSDictionary *)attributes;
@end
