//
//  UserInfoViewModel.h
//  SNNGeneralProject
//
//  Created by nana on 2018/3/7.
//  Copyright © 2018年 dzcx-shinana. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ReturnUserInfoValueBlock) (UserInfoModel *returnValue);

@interface UserInfoViewModel : NSObject

@property (nonatomic, strong) UIViewController *viewController;
@property (nonatomic, copy) ReturnUserInfoValueBlock returnBlock;

- (id)initWithUIViewConroller:(UIViewController *)viewController;
- (void)p_getWeiboUserInfo:(ReturnUserInfoValueBlock )returnBlock;

@end
