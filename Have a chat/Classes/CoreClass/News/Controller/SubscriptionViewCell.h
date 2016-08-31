//
//  SubscriptionViewCell.h
//  Have a chat
//
//  Created by 黄兵 on 16/8/9.
//  Copyright © 2016年 yun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubscriptionModel.h"
@interface SubscriptionViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;


@property (weak, nonatomic) IBOutlet UILabel *visitLabel;

- (void)setValueWithModel:(SubscriptionModel *)model;

@end
