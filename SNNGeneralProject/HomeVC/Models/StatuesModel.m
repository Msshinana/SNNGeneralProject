//
//  StatuesModel.m
//  SNNGeneralProject
//
//  Created by nana on 2018/3/7.
//  Copyright © 2018年 dzcx-shinana. All rights reserved.
//

#import "StatuesModel.h"

@implementation StatuesModel
- (id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.text = [dic objectForKeyCheck:@"text"];
        
        NSArray *picArray = [dic objectForKeyCheck:@"pic_urls"];
        self.thumbnail_picArray = [NSMutableArray array];
        for (int i=0; i<picArray.count; i++) {
            NSDictionary *picDic = [picArray objectAtIndexCheck:i];
            [self.thumbnail_picArray addObject:[picDic objectForKeyCheck:@"thumbnail_pic"]];
        }

    }
    return self;
}

@end
