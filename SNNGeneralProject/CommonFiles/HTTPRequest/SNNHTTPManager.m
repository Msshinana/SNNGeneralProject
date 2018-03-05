//
//  SNNHTTPManager.m
//  SNNGeneralProject
//
//  Created by nana on 2018/3/5.
//  Copyright © 2018年 dzcx-shinana. All rights reserved.
//

#import "SNNHTTPManager.h"
#import "SNNHTTPRequest.h"
#import "NetWorkError.h"
#import "Reachability.h"

@interface SNNHTTPManager ()

@property (strong, nonatomic) NSMutableDictionary *requestDic;

@end

@implementation SNNHTTPManager

static SNNHTTPManager *manager = nil;

+(SNNHTTPManager *)shareManger
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SNNHTTPManager alloc] init];
        manager.requestDic = [NSMutableDictionary dictionary];
    });
    return manager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [super allocWithZone:zone];
    });
    return manager;
}

- (void)requestWithUrlString:(NSString *)urlString andParams:(NSDictionary *)params method:(HttpRequestMehod)mehod showIndicatorInView:(UIView *)view andCompletionHandler:(HttpManagerCompletionHandler)completion
{
    if (![self isNetworkSuccess])
    {
        NSDictionary *userInfo = nil;
        NetWorkError *error = nil;
        userInfo               = @{
                                   NSLocalizedDescriptionKey : @"网络走丢了~"
                                   };
        error                  = [NetWorkError errorWithType:NetworkErrorTypeNoNetConnecting andUerInfo:userInfo];
        completion(nil, error);
        return;
    }
    SNNHTTPRequest *tool = self.requestDic[urlString];
    if (tool)
    {
        return;
    }
    
    tool         = [SNNHTTPRequest requestWithUrlString:urlString paramasDic:params method:mehod showIndicatorInView:view  completionHandler:completion];
    tool.manager = self;
    [self.requestDic setObject:tool forKey:urlString];
}
//连续请求接口使用
- (void)continuousRequestWithUrlString:(NSString *)urlString andParams:(NSDictionary *)params method:(HttpRequestMehod)mehod showIndicatorInView:(UIView *)view andCompletionHandler:(HttpManagerCompletionHandler)completion
{
    if (![self isNetworkSuccess])
    {
        NSDictionary *userInfo = nil;
        NetWorkError *error = nil;
        userInfo               = @{
                                   NSLocalizedDescriptionKey : @"网络走丢了~"
                                   };
        error                  = [NetWorkError errorWithType:NetworkErrorTypeNoNetConnecting andUerInfo:userInfo];
        completion(nil, error);
        return;
    }
    SNNHTTPRequest *tool = self.requestDic[urlString];
    if (tool)
    {
        [manager removeRequestWithKey:urlString];
    }
    
    tool         = [SNNHTTPRequest requestWithUrlString:urlString paramasDic:params method:mehod showIndicatorInView:view  completionHandler:completion];
    tool.manager = self;
    [self.requestDic setObject:tool forKey:urlString];
}

- (void)uploadImage:(UIImage *)image urlString:(NSString *)urlString contentType:(NSString *)contentType completionHandler:(HttpUploadImageCompletionHandler)completion
{
    if (![self isNetworkSuccess])
    {
        NSDictionary *userInfo = nil;
        NetWorkError *error = nil;
        userInfo               = @{
                                   NSLocalizedDescriptionKey : @"网络走丢了~"
                                   };
        error                  = [NetWorkError errorWithType:NetworkErrorTypeNoNetConnecting andUerInfo:userInfo];
        completion(nil, nil, error);
        return;
    }
    SNNHTTPRequest *tool = self.requestDic[urlString];
    if (tool)
    {
        return;
    }
    
    tool = [[SNNHTTPRequest alloc] init];
    tool.manager = self;
    [tool uploadImage:image urlString:urlString contentType:contentType completionHandler:completion];
    [self.requestDic setObject:tool forKey:urlString];
}

- (void)downloadImageWithUrlString:(NSString *)urlString placeholderImage:(UIImage *)image imageView:(UIImageView *)imageView
{
    
    [SNNHTTPRequest downloadImageWithUrlString:urlString placeholderImage:image imageView:imageView];
}

- (BOOL)removeRequestWithKey:(NSString *)key
{
    SNNHTTPRequest *tool = self.requestDic[key];
    if (tool)
    {
        [tool cancel];
        [self.requestDic removeObjectForKey:key];
    }
    return YES;
}

- (BOOL)removeAllRequests
{
    for (SNNHTTPRequest *tool in self.requestDic.allValues)
    {
        [tool cancel];
    }
    
    [self.requestDic removeAllObjects];
    return YES;
}

- (BOOL)isNetworkSuccess
{
    BOOL isExistenceNetwork = YES;
    //    Reachability *reach = [Reachability reachabilityWithHostName:@"www.baidu.cn"];
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            
            break;
    }
    return isExistenceNetwork;
}

@end
