//
//  BeautyCollectionViewCell.m
//  Have a chat
//
//  Created by 黄兵 on 16/8/9.
//  Copyright © 2016年 yun. All rights reserved.
//

#import "BeautyCollectionViewCell.h"

@implementation BeautyCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setValueWithModel:(BeautyModel *)model
{
    [_imageV sd_setImageWithURL:[NSURL URLWithString:model.imagesUrl]];
    _titleLabel.text = model.subTitle;
    _titleLabel.layer.borderWidth = 0.1;
    _titleLabel.layer.borderColor = [[UIColor blackColor]CGColor];
}

@end
