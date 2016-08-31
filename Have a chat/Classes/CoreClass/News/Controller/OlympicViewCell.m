//
//  OlympicViewCell.m
//  Have a chat
//
//  Created by 黄兵 on 16/8/9.
//  Copyright © 2016年 yun. All rights reserved.
//

#import "OlympicViewCell.h"

@implementation OlympicViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setValueWithModel:(OlympicModel *)model
{
    if (model.images.count != 0) {
        [_imageV sd_setImageWithURL:[NSURL URLWithString:model.images[0][@"url"]]];
    }else{
        _imageV.image = [UIImage imageNamed:@"奥运"];
    }
    _titleLabel.text = model.title;
   _visitLabel.text = [[model.content_length stringValue] stringByAppendingString:@"人评论"];
    _categoryLabel.text = model.source_name;
}

@end