//
//  CommonParams.h
//  SNNGeneralProject
//
//  Created by nana on 2018/3/7.
//  Copyright © 2018年 dzcx-shinana. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonParams : NSObject

@property (nonatomic,strong) NSString *accessToken;
@property (nonatomic,strong) NSString *userId;

+(CommonParams *)shareInstance;

@end
