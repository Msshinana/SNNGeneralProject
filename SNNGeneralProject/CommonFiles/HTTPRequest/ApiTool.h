//
//  ApiTool.h
//  SNNGeneralProject
//
//  Created by nana on 2018/3/5.
//  Copyright © 2018年 dzcx-shinana. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApiTool : NSObject
+ (ApiTool *) sharedInit;

- (NSString *) registerURL;//注册
- (NSString *) loginURL;//登录
@end
