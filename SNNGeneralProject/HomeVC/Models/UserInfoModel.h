//
//  UserInfoModel.h
//  SNNGeneralProject
//
//  Created by nana on 2018/3/6.
//  Copyright © 2018年 dzcx-shinana. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject

@property (nonatomic,strong)NSString *name;//昵称
@property (nonatomic,strong)NSString *profile_image_url;//头像
@property (nonatomic,strong)NSString *userDescription;//签名
@property (nonatomic,assign)NSInteger statuses_count;//微博数量
@property (nonatomic,assign)NSInteger followers_count;//粉丝数量
@property (nonatomic,assign)NSInteger friends_count;//关注数量

- (id)initWithDic:(NSDictionary *)dic;

@end
