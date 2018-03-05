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
//注册
- (NSString *) registerURL{
    return [NSString stringWithFormat:@"%@%@", MYDOMAINURL,REGISTER];
}
//登录
- (NSString *) loginURL{
    return [NSString stringWithFormat:@"%@%@",MYDOMAINURL,LOGIN];
}
@end
