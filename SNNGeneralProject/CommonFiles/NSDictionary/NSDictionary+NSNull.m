//
//  NSDictionary+NSNull.m
//  DaZhongChuXing
//
//  Created by dzcx-shinana on 17/6/2.
//  Copyright © 2017年 tony. All rights reserved.
//

#import "NSDictionary+NSNull.h"

@implementation NSDictionary (NSNull)
- (id)objectForKeyCheck:(id)key
{
    id obj = self[key];
    if ([obj isKindOfClass:[NSNull class]] || !obj)
    {
        return @"";
    }
    return obj;
}


@end
