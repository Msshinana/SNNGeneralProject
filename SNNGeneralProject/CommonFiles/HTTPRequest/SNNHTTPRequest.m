//
//  SNNHTTPRequest.m
//  SNNGeneralProject
//
//  Created by dzcx-shinana on 2017/11/22.
//  Copyright © 2017年 dzcx-shinana. All rights reserved.
//

#import "SNNHTTPRequest.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"

@implementation SNNHTTPRequest
+(void)requestWithUrlString:(NSString *)urlString
                 paramasDic:(NSDictionary *)params
                     method:(HttpRequestMehod)requestMethod
       showMBProgressInView:(UIView *)view
                 completion:(void (^)(NSDictionary *responseDic))complete
                       fail:(void(^)(NSError *error))fail{
    
}
@end

