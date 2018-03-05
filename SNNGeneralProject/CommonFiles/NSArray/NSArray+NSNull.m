//
//  NSArray+NSNull.m
//  DaZhongChuXing
//
//  Created by dzcx-shinana on 17/6/2.
//  Copyright © 2017年 tony. All rights reserved.
//

#import "NSArray+NSNull.h"

@implementation NSArray (NSNull)
- (id)objectAtIndexCheck:(NSUInteger)index
{
   if (index >= [self count]) {
      return nil;
   }
   
   id value = [self objectAtIndex:index];
   if (value == [NSNull null]) {
      return nil;
   }
   return value;
}

@end
