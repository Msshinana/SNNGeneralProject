//
//  SNNHTTPRequest.h
//  SNNGeneralProject
//
//  Created by dzcx-shinana on 2017/11/22.
//  Copyright © 2017年 dzcx-shinana. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class SNNHTTPManager, SNNHTTPRequest;

typedef NS_ENUM(NSUInteger, HttpRequestMehod) {
    HttpRequestMehodGET = 1,
    HttpRequestMehodPOST,
};

typedef void(^HttpCompletionHandler)(NSDictionary *resBodyDic, NSError *error);
typedef void(^HttpUploadImageCompletionHandler)(UIImage *image, NSDictionary *resBodyDic, NSError *error);

@interface SNNHTTPRequest : NSObject

@property (copy, nonatomic) NSString                         *urlString;
@property (strong, nonatomic) NSDictionary                   *paramasDic;
@property (weak, nonatomic) SNNHTTPManager                   *manager;
@property (assign, nonatomic) HttpRequestMehod                method;

+ (SNNHTTPRequest *)requestWithUrlString:(NSString *)urlString
                           paramasDic:(NSDictionary *)params
                               method:(HttpRequestMehod)method
                    completionHandler:(HttpCompletionHandler)completion;

+ (SNNHTTPRequest *)requestWithUrlString:(NSString *)urlString
                           paramasDic:(NSDictionary *)params
                               method:(HttpRequestMehod)method
                  showIndicatorInView:(UIView *)view
                    completionHandler:(HttpCompletionHandler)completion;

+ (SNNHTTPRequest *)postWithUrlString:(NSString *)urlString
                        paramasDic:(NSDictionary *)params
                            method:(HttpRequestMehod)method
                 completionHandler:(HttpCompletionHandler)completion;

+ (SNNHTTPRequest *)getWithUrlString:(NSString *)urlString
                       paramasDic:(NSDictionary *)params
                           method:(HttpRequestMehod)method
                completionHandler:(HttpCompletionHandler)completion;

+ (void)downloadImageWithUrlString:(NSString *)urlString placeholderImage:(UIImage *)image imageView:(UIImageView *)imageView;

- (void) uploadImage:(UIImage *)image
           urlString:(NSString *)urlString
         contentType:(NSString *)contentType
   completionHandler:(HttpUploadImageCompletionHandler)completion;

- (void)cancel;

@end
