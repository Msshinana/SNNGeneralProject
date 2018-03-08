//
//  StatuesModel.h
//  SNNGeneralProject
//
//  Created by nana on 2018/3/7.
//  Copyright © 2018年 dzcx-shinana. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StatuesModel : NSObject

@property (nonatomic,strong)NSString *text;//微博信息内容
@property (nonatomic,strong)NSMutableArray *thumbnail_picArray;//缩略图片地址

- (id)initWithDic:(NSDictionary *)dic;

@end
