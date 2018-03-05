//
//  NSString+StringSize.m
//  SNNGeneralProject
//
//  Created by dzcx-shinana on 2017/11/22.
//  Copyright © 2017年 dzcx-shinana. All rights reserved.
//

#import "NSString+StringSize.h"

@implementation NSString (StringSize)
- (CGSize)limitSize:(CGSize)size font:(UIFont *)font
{
    NSDictionary *attributesDic = @{
                                    NSFontAttributeName : font
                                    };
    return [self boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributesDic context:nil].size;
}

- (CGSize)limitSize:(CGSize)size attributes:(NSDictionary *)attributes
{
    return [self boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
}

@end
