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

- (NSString *) userInfoURL;//获取用户信息
- (NSString *) statusesTimelineURL;//获取用户所发布的微博

@end
