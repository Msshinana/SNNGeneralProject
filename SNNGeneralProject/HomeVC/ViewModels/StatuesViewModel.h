//
//  StatuesViewModel.h
//  SNNGeneralProject
//
//  Created by nana on 2018/3/7.
//  Copyright © 2018年 dzcx-shinana. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ReturnStatuesValueBlock) (NSMutableArray * returnValue);

@interface StatuesViewModel : NSObject

@property (nonatomic, strong) UIViewController *viewController;
@property (nonatomic, copy) ReturnStatuesValueBlock returnBlock;

- (id)initWithUIViewConroller:(UIViewController *)viewController;
- (void)p_getWeiboStatuseTimeline:(ReturnStatuesValueBlock )returnBlock;

@end
