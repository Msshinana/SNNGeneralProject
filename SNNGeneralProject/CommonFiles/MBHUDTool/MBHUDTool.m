//
//  MBHUDTool.m
//  DaZhongChuXing
//
//  Created by dzcx-shinana on 17/3/30.
//  Copyright © 2017年 tony. All rights reserved.
//

#import "MBHUDTool.h"
#import "MBProgressHUD.h"

@implementation MBHUDTool
+ (MBProgressHUD *)showHUDAddedTo:(UIView *)view animated:(BOOL)animated {
   MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
   UIImageView *gifView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
   NSMutableArray * _loadingArray = [NSMutableArray array];
   for (int i=0; i<24; i++) {
      [_loadingArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"加载_000%02d",i]]];
   }
   [(UIImageView *)gifView setAnimationImages:_loadingArray];
   [(UIImageView *)gifView setAnimationRepeatCount:MAXFLOAT];
   [(UIImageView *)gifView setAnimationDuration:1.0];
   [(UIImageView *)gifView startAnimating];
   hud.customView = gifView;
   hud.color=[UIColor clearColor];
   hud.mode = MBProgressHUDModeCustomView;
   hud.removeFromSuperViewOnHide = YES;
   [view addSubview:hud];
   [hud show:animated];
   return hud;
}

@end
