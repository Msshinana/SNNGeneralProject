//
//  HomeTableViewCell.h
//  SNNGeneralProject
//
//  Created by nana on 2018/3/7.
//  Copyright © 2018年 dzcx-shinana. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^GetCellHeightBlock) (CGFloat cellHeight);
@interface HomeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ImageContent;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleHeight;
@property (nonatomic, assign) CGFloat imageHeight;
@property (nonatomic, copy) GetCellHeightBlock cellHeightBlock;

+ (instancetype)creatCellWithItemsContent:(NSMutableArray *)array inTableView:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)getCellHeight;
@end
