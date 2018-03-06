//
//  UserInfoModel.m
//  SNNGeneralProject
//
//  Created by nana on 2018/3/6.
//  Copyright © 2018年 dzcx-shinana. All rights reserved.
//

#import "UserInfoModel.h"

@implementation UserInfoModel

- (id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.name = [dic objectForKeyCheck:@"name"];
        self.profile_image_url = [dic objectForKeyCheck:@"profile_image_url"];
        self.userDescription = [dic objectForKeyCheck:@"description"];
        self.statuses_count = [[dic objectForKeyCheck:@"statuses_count"] integerValue];
        self.followers_count = [[dic objectForKeyCheck:@"followers_count"] integerValue];
        self.friends_count = [[dic objectForKeyCheck:@"friends_count"] integerValue];
    }
    return self;
}

@end
