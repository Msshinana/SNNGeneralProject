//
//  SNNHTTPManager.h
//  SNNGeneralProject
//
//  Created by nana on 2018/3/5.
//  Copyright © 2018年 dzcx-shinana. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SNNHTTPRequest.h"

@class SNNHTTPManager;

typedef void(^HttpManagerCompletionHandler)(NSDictionary *resBodyDic, NSError *error);

@interface SNNHTTPManager : NSObject

+ (SNNHTTPManager *)shareManger;
/**
 *
 *  @param urlString  url
 *  @param params     入参
 *  @param mehod      请求方式 GET/POST
 *  @param view       请求加载进度条
 *  @param completion 结果回调
 */

- (void)requestWithUrlString:(NSString *)urlString
                   andParams:(NSDictionary *)params
                      method:(HttpRequestMehod)mehod
         showIndicatorInView:(UIView *)view
        andCompletionHandler:(HttpManagerCompletionHandler)completion;//单次请求

- (void)continuousRequestWithUrlString:(NSString *)urlString
                             andParams:(NSDictionary *)params
                                method:(HttpRequestMehod)mehod
                   showIndicatorInView:(UIView *)view
                  andCompletionHandler:(HttpManagerCompletionHandler)completion;//连续请求
/**
 *  默认GET
 */
- (void)GETrequestWithUrlString:(NSString *)urlString
         showIndicatorInView:(UIView *)view
        andCompletionHandler:(HttpManagerCompletionHandler)completion;
/**
 *  默认POST
 */
- (void)POSTrequestWithUrlString:(NSString *)urlString
                      andParams:(NSDictionary *)params
            showIndicatorInView:(UIView *)view
           andCompletionHandler:(HttpManagerCompletionHandler)completion;
/**
 *  下载图片
 */
- (void)downloadImageWithUrlString:(NSString *)urlString
                  placeholderImage:(UIImage *)image
                         imageView:(UIImageView *)imageView;
/**
 *  上传图片
 */
- (void)uploadImage:(UIImage *)image
          urlString:(NSString *)urlString
        contentType:(NSString *)contentType
  completionHandler:(HttpUploadImageCompletionHandler)completion;

/**
 *  移除指定请求
 *  @param key 请求对应的key
 *  @return 成功或者失败
 */
- (BOOL)removeRequestWithKey:(NSString *)key;
- (BOOL)removeAllRequests;
- (BOOL)isNetworkSuccess;

@end
