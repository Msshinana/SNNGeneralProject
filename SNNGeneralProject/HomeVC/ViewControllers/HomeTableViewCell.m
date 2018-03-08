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
        cell.titleLabel.hidden = NO;
        cell.titleHeight.constant = 50;
    }
    
    NSString *thumbnail_pic = [stuatuesModel.thumbnail_picArray objectAtIndexCheck:0];
    if (thumbnail_pic == nil || [thumbnail_pic isEqualToString:@""]) {
        cell.ImageContent.hidden = YES;
        cell.imageHeight = 0;
    }else{
        cell.ImageContent.hidden = NO;
        [cell.ImageContent sd_setImageWithURL:[NSURL URLWithString:thumbnail_pic]];

       UIImage *thumbImage = [CommonMethod imageCompressForWidth:[CommonMethod getImageFromUrlString:thumbnail_pic] targetWidth:kScreenWidth];
        cell.imageHeight = thumbImage.size.height;
    }
    return cell;
}
- (CGFloat)getCellHeight{
    CGRect rect = self.frame;
    rect.size.width = kScreenWidth;
    self.frame = rect;
    [self layoutIfNeeded];
    return 70+self.imageHeight;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
