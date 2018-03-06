//
//  Config.h
//  SNNGeneralProject
//
//  Created by dzcx-shinana on 2017/11/22.
//  Copyright © 2017年 dzcx-shinana. All rights reserved.
//

#ifndef Config_h
#define Config_h
#define kWB_AppKey                     @"2759558236"
#define kRedirectURL                   @"http://www.shinana.com"

#define kWeakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self
#define kStrongSelf(strongSelf)  __strong __typeof(weakSelf)strongSelf = weakSelf

//屏幕高度
#define kScreenHeight MAX([UIScreen mainScreen].bounds.size.width, \
[UIScreen mainScreen].bounds.size.height)
//屏幕宽度
#define kScreenWidth  MIN([UIScreen mainScreen].bounds.size.width, \
[UIScreen mainScreen].bounds.size.height)


#endif /* Config_h */
