//
//  StatuesViewModel.m
//  SNNGeneralProject
//
//  Created by nana on 2018/3/7.
//  Copyright © 2018年 dzcx-shinana. All rights reserved.
//

#import "StatuesViewModel.h"
#import "StatuesModel.h"

@implementation StatuesViewModel
- (id)initWithUIViewConroller:(UIViewController *)viewController{
    self = [super init];
    if (self) {
        self.viewController = viewController;
    }
    return self;
}

- (void)p_getWeiboStatuseTimeline:(ReturnStatuesValueBlock )returnBlock{
    self.returnBlock=returnBlock;
    NSString *url = [NSString stringWithFormat:@"%@?access_token=%@",STATUSES_TIMELINE,[[CommonParams shareInstance] accessToken]];
    
    [[SNNHTTPManager shareManger]GETrequestWithUrlString:url showIndicatorInView:self.viewController.view andCompletionHandler:^(NSDictionary *resBodyDic, NSError *error) {
        
        if (resBodyDic) {
            NSArray *statuesArray = [resBodyDic objectForKeyCheck:@"statuses"];
            NSMutableArray *statuesModelArray = [NSMutableArray array];
            for (int i=0; i<statuesArray.count; i++) {
                NSDictionary *statuesDic = [statuesArray objectAtIndexCheck:i];
                StatuesModel *statuesModel = [[StatuesModel alloc]initWithDic:statuesDic];
                [statuesModelArray addObject:statuesModel];
            }
            if (self.returnBlock) {
                self.returnBlock(statuesModelArray);
            }
            
        }
    }];
}
@end
