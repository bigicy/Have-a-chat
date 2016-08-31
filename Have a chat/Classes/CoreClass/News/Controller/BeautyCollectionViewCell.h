//
//  BeautyCollectionViewCell.h
//  Have a chat
//
//  Created by 黄兵 on 16/8/9.
//  Copyright © 2016年 yun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BeautyModel.h"
@interface BeautyCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

- (void)setValueWithModel:(BeautyModel *)model;

@end
