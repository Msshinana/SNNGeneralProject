//
//  CommonParams.m
//  SNNGeneralProject
//
//  Created by nana on 2018/3/7.
//  Copyright © 2018年 dzcx-shinana. All rights reserved.
//

#import "CommonParams.h"

@implementation CommonParams

static CommonParams *commonParams;

+(CommonParams *)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        commonParams=[[CommonParams alloc]init];
    });
    
    return commonParams;
}

@end
