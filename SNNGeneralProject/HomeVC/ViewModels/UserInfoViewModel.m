//
//  UserInfoViewModel.m
//  SNNGeneralProject
//
//  Created by nana on 2018/3/7.
//  Copyright © 2018年 dzcx-shinana. All rights reserved.
//

#import "UserInfoViewModel.h"

@implementation UserInfoViewModel
- (id)initWithUIViewConroller:(UIViewController *)viewController{
    self = [super init];
    if (self) {
        self.viewController = viewController;
    }
    return self;
}
- (void)p_getWeiboUserInfo:(ReturnUserInfoValueBlock )returnBlock{
    self.returnBlock=returnBlock;
    NSString *url =[NSString stringWithFormat:
                    @"%@?access_token=%@&uid=%@",USERINFO,[[CommonParams shareInstance] accessToken],[[CommonParams shareInstance] userId]];
    [[SNNHTTPManager shareManger]GETrequestWithUrlString:url showIndicatorInView:self.viewController.view andCompletionHandler:^(NSDictionary *resBodyDic, NSError *error) {
        if(resBodyDic){
            UserInfoModel *userInfoModel = [[UserInfoModel alloc]initWithDic:resBodyDic];
            if (self.returnBlock) {
                self.returnBlock(userInfoModel);
            }
        }
    }];
}

@end
