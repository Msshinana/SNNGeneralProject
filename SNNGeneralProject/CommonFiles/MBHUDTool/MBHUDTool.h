//
//  MBHUDTool.h
//  DaZhongChuXing
//
//  Created by dzcx-shinana on 17/3/30.
//  Copyright © 2017年 tony. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class MBProgressHUD;

@interface MBHUDTool : NSObject
+ (MBProgressHUD *)showHUDAddedTo:(UIView *)view animated:(BOOL)animated ;
@end
