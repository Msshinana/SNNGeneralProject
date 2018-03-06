//
//  Api.h
//  SNNGeneralProject
//
//  Created by dzcx-shinana on 2017/11/22.
//  Copyright © 2017年 dzcx-shinana. All rights reserved.
//

#ifndef Api_h
#define Api_h
#import "ApiTool.h"
#import "SNNHTTPManager.h"
//测试环境、生产环境

//微博API为例
#ifdef DEBUG
#define MYDOMAINURL                        @"https://api.weibo.com"
#else
#define MYDOMAINURL                        @"https://api.weibo.com"

#endif
//获取用户信息
#define USERINFO                           @"/2/users/show.json"
//获取用户所发布的微博
#define STATUSES_TIMELINE                  @"/2/statuses/user_timeline.json"
//分享链接到微博
#define STATUSES_SHARE                     @"/2/statuses/share.json"


#endif /* Api_h */
