//
//  ApiTool.m
//  SNNGeneralProject
//
//  Created by nana on 2018/3/5.
//  Copyright © 2018年 dzcx-shinana. All rights reserved.
//

#import "ApiTool.h"

@implementation ApiTool
static ApiTool * serverURL;

+ (id) sharedInit{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        serverURL = [[ApiTool alloc] init];
    });
    return serverURL;
}
- (NSString *) userInfoURL{
    return [NSString stringWithFormat:@"%@%@", MYDOMAINURL,USERINFO];
}//获取用户信息
- (NSString *) statusesTimelineURL{
    return [NSString stringWithFormat:@"%@%@", MYDOMAINURL,STATUSES_TIMELINE];
}//获取用户所发布的微博

@end
