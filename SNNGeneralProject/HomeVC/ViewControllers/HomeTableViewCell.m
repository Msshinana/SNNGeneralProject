//
//  HomeTableViewCell.m
//  SNNGeneralProject
//
//  Created by nana on 2018/3/7.
//  Copyright © 2018年 dzcx-shinana. All rights reserved.
//

#import "HomeTableViewCell.h"
#import "StatuesModel.h"
@implementation HomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+ (instancetype)creatCellWithItemsContent:(NSMutableArray *)array inTableView:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath{
    static NSString *Identifier = @"HomeTableViewCell";
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:Identifier owner:nil options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    StatuesModel *stuatuesModel = (StatuesModel *)[array objectAtIndexCheck:indexPath.row];
    if (stuatuesModel.text == nil || [stuatuesModel.text isEqualToString:@""]) {
        cell.titleLabel.hidden = YES;
        cell.titleHeight.constant = 0;
    }else{
        cell.titleLabel.text = stuatuesModel.text;
    }
    NSString *thumbnail_pic = [stuatuesModel.thumbnail_picArray objectAtIndexCheck:0];
    if (thumbnail_pic == nil || [thumbnail_pic isEqualToString:@""]) {
        cell.ImageContent.hidden = YES;
    }else{
        [cell.ImageContent sd_setImageWithURL:[NSURL URLWithString:thumbnail_pic]];
    }
    return cell;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
