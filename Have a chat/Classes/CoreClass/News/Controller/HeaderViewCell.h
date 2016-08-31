//
//  HeaderViewCell.h
//  Have a chat
//
//  Created by 黄兵 on 16/8/8.
//  Copyright © 2016年 yun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderlineModel.h"
@interface HeaderViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *visitLabel;

- (void)setvalueWithModel:(HeaderlineModel *)model;

@end
