//
//  NetWorkError.h
//  SNNGeneralProject
//
//  Created by dzcx-shinana on 2017/11/23.
//  Copyright © 2017年 dzcx-shinana. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, NetworkErrorType) {
    NetworkErrorTypeTimeOut         = -1000,
    NetworkErrorTypeErrorMsg        = - 800,
    NetworkErrorTypeNoNetConnecting = - 900
};

@class NetWorkError;

@interface NetWorkError : NSError

+ (NetWorkError *)errorWithType:(NetworkErrorType)type andUerInfo:(NSDictionary *)userInfo;

@end
