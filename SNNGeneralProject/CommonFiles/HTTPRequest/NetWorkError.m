//
//  NetWorkError.m
//  SNNGeneralProject
//
//  Created by dzcx-shinana on 2017/11/23.
//  Copyright © 2017年 dzcx-shinana. All rights reserved.
//

#import "NetWorkError.h"

static NSString *const NetworkErrorDomain = @"com.visionet.superfitnesscenter.errordomain";

@implementation NetWorkError

+ (NetWorkError *)errorWithType:(NetworkErrorType)type andUerInfo:(NSDictionary *)userInfo
{
    return [NetWorkError errorWithDomain:NetworkErrorDomain code:type userInfo:userInfo];
}

@end
