//
//  MakeFunnyViewCell.h
//  Have a chat
//
//  Created by 黄兵 on 16/8/9.
//  Copyright © 2016年 yun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MakeFunnyModel.h"
@interface MakeFunnyViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;

@property (weak, nonatomic) IBOutlet UILabel *visitLabel;

@property (weak, nonatomic) IBOutlet UIImageView *imageV;

- (void)setValueWithModel:(MakeFunnyModel *)model;

@end
