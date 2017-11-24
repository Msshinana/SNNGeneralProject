//
//  SNNHTTPRequest.h
//  SNNGeneralProject
//
//  Created by dzcx-shinana on 2017/11/22.
//  Copyright © 2017年 dzcx-shinana. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, HttpRequestMehod) {
    HttpRequestMehodGET = 1,
    HttpRequestMehodPOST,
};
@interface SNNHTTPRequest : NSObject
+(void)requestWithUrlString:(NSString *)urlString paramasDic:(NSDictionary *)params method:(HttpRequestMehod)requestMethod showMBProgressInView:(UIView *)view completion:(void (^)(NSDictionary *responseDic))complete fail:(void(^)(NSError *error))fail;
@end
