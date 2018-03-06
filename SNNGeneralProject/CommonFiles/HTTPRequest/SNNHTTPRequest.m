//
//  SNNHTTPRequest.m
//  SNNGeneralProject
//
//  Created by dzcx-shinana on 2017/11/22.
//  Copyright © 2017年 dzcx-shinana. All rights reserved.
//

#import "SNNHTTPRequest.h"
#import "SNNHTTPManager.h"
#import "NetWorkError.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "MBHUDTool.h"

@interface SNNHTTPRequest ()
// 普通网络请求回调
@property (copy, nonatomic  ) HttpCompletionHandler            httpCompletionHandler;
// 上传照片回调
@property (copy, nonatomic  ) HttpUploadImageCompletionHandler uploadImageCompletionHandler;

// POST
// GET
@property (strong, nonatomic) NSMutableURLRequest                      *httpRequest;
// 自定义error
@property (nonatomic, strong) NSError                     *error;
// 等待指示器显示的视图
@property (nonatomic, weak  ) UIView                              *showView;
// 服务器返回的字典
@property (strong, nonatomic) NSDictionary                        *resBodyDic;
@property (strong, nonatomic) NSMutableDictionary                 *paramDic;
@property (nonatomic,strong)  NSString* updateStr;
@property (strong, nonatomic) UIImage *image;

@end

@implementation SNNHTTPRequest

+ (SNNHTTPRequest *)requestWithUrlString:(NSString *)urlString paramasDic:(NSDictionary *)params method:(HttpRequestMehod)method showIndicatorInView:(UIView *)view completionHandler:(HttpCompletionHandler)completion
{
    SNNHTTPRequest *tool          = [[SNNHTTPRequest alloc] init];
    tool.urlString             = urlString;
    tool.paramasDic            = params;
    tool.method                = method;
    tool.httpCompletionHandler = completion;

    if (view)
    {
        tool.showView = view;

    }
    dispatch_async(dispatch_get_main_queue(), ^{
        if (view)
        {
            [MBHUDTool showHUDAddedTo:view animated:YES];
        }
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [tool p_startRequest];
    });

    return tool;
}

+ (void)downloadImageWithUrlString:(NSString *)urlString placeholderImage:(UIImage *)image imageView:(UIImageView *)imageView
{
    [imageView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:image options:SDWebImageLowPriority | SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {


    }];
}

- (void)uploadImage:(UIImage *)image urlString:(NSString *)urlString contentType:(NSString *)contentType completionHandler:(HttpUploadImageCompletionHandler)completion
{
    [self uploadImage:image urlString:urlString contentType:contentType completionHandler:completion];
}

#pragma mark 发起请求
- (void)p_startRequest
{
    kWeakSelf(weakSelf);

    NSMutableDictionary *postBodyDic = [NSMutableDictionary dictionary];
    if (self.paramasDic)
    {
        [postBodyDic setObject:self.paramasDic forKey:@"body"];
    }
    else
    {
        [postBodyDic setObject:[[NSDictionary alloc] init] forKey:@"body"];
    }

    NSDictionary *headDic = @{
                              
                              };
    [postBodyDic setObject:headDic forKey:@"head"];

    self.paramasDic = postBodyDic;

    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:postBodyDic options:NSJSONWritingPrettyPrinted error:nil];

    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];

    manager.securityPolicy.allowInvalidCertificates = YES;
    [manager.securityPolicy setValidatesDomainName:NO];

    NSMutableURLRequest *req;
    if(self.method==HttpRequestMehodGET){
        req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"GET" URLString:self.urlString parameters:nil error:nil];
    }else{
        req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:self.urlString parameters:nil error:nil];
    }

    req.timeoutInterval= 10;

    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];


    [req setHTTPBody:jsonData];
    AFHTTPResponseSerializer *resonseSerial =  [AFHTTPResponseSerializer serializer];
    resonseSerial.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript",@"text/plain", nil];
    manager.responseSerializer = resonseSerial;

    [[manager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        kStrongSelf(strongSelf);
        if (!error) {
            strongSelf.resBodyDic=[NSJSONSerialization JSONObjectWithData:responseObject
                                                                  options: NSJSONReadingMutableContainers
                                                                    error: &error];
            [strongSelf p_requestCompleted];
        } else {
            if (strongSelf.showView)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideHUDForView:strongSelf.showView animated:YES];
                });
            }
            [ToastMessageView showTsMessage:error.localizedDescription inView:[[UIApplication sharedApplication] keyWindow] replaceCurrentIfExists:YES];
            [strongSelf.manager removeRequestWithKey:strongSelf.urlString];
        }
    }] resume];


}
- (void)uploadImage:(UIImage *)image urlString:(NSString *)urlString callBack:(HttpUploadImageCompletionHandler)callBack
{
    self.uploadImageCompletionHandler = callBack;
    self.image = image;
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    //manager.responseSerializer = [AFHTTPResponseSerializer serializer];
#ifdef DEBUG

#else
    NSString * cerPath = [[NSBundle mainBundle] pathForResource:@"bck" ofType:@".cer"];
    NSData * cerData = [NSData dataWithContentsOfFile:cerPath];
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:[NSSet setWithObjects:cerData,nil]];
#endif
    manager.securityPolicy.allowInvalidCertificates = YES;
    [manager.securityPolicy setValidatesDomainName:NO];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/html",
                                                         @"image/jpg",
                                                         @"image/png",
                                                         @"application/octet-stream",
                                                         @"text/json",
                                                         @"text/javascript",
                                                         @"text/plain",
                                                         nil];
    
    [manager POST:urlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
        
        [formData appendPartWithFileData:UIImageJPEGRepresentation(image,0.5) name:@"file"fileName:[CommonMethod getImageName:image] mimeType:@"image/jpg"];
        
    } progress:^(NSProgress *_Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask *_Nonnull task,id _Nullable responseObject) {
        self.uploadImageCompletionHandler(self.image, responseObject, nil);
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        [ToastMessageView showTsMessage:@"上传图片失败!" inView:self.showView replaceCurrentIfExists:YES];
    }];
}

#pragma mark 请求完成
- (void)p_requestCompleted
{
    if (self.httpCompletionHandler)
    {
        if (self.showView)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.showView animated:YES];
            });
        }
        if(!self.resBodyDic){
            return;
        }
        self.httpCompletionHandler(self.resBodyDic, self.error);
        [self.manager removeRequestWithKey:self.urlString];
    }
}

- (void)cancel
{
    self.uploadImageCompletionHandler = nil;
    self.httpCompletionHandler = nil;
    self.httpRequest = nil;
}

-(Boolean )tokenValidation:(NSDictionary *)dic
{
    NSString *success=[dic objectForKeyCheck:@"success"];
    if(success!=nil &&( [success isEqualToString:@"-2"]  || [success isEqualToString:@"-1"])){
        return NO;
    }
    return YES;
}

//字典转字符串
-(NSString*)dictionaryToString:(NSDictionary*)dic {

    NSString *jsonString = nil;
    if (dic) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic
                                                           options:NSJSONWritingPrettyPrinted
                                                             error:&error];
        if (! jsonData) {
            NSLog(@"Got an error: %@", error);
            jsonString = @"";
        } else {
            jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        }
    }
    else {
        jsonString = @"";
    }
    return jsonString;
}

@end


