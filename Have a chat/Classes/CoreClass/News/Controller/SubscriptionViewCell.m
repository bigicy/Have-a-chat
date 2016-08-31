//
//  SubscriptionViewCell.m
//  Have a chat
//
//  Created by 黄兵 on 16/8/9.
//  Copyright © 2016年 yun. All rights reserved.
//

#import "SubscriptionViewCell.h"

@implementation SubscriptionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setValueWithModel:(SubscriptionModel *)model
{
    if (model.imgUrlList.count == 0) {
        _imageV.image = [UIImage imageNamed:@"奥运.jpg"];
    }else{
        [_imageV sd_setImageWithURL:[NSURL URLWithString:model.imgUrlList[0]]];}    _titleLabel.text = model.title;
    _visitLabel.text = [[model.pv stringValue] stringByAppendingString:@"人看过"];
    _categoryLabel.text = model.contentSourceName;
}



@end
