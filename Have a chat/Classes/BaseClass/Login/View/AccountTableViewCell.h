//
//  AccountTableViewCell.h
//  Have a chat
//
//  Created by 马凌云 on 16/8/6.
//  Copyright © 2016年 yun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"
#import "FMDBManager.h"

@interface AccountTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headerPic;

@property (weak, nonatomic) IBOutlet UILabel *account;


- (void)setValueWithModel:(UserModel *)model;

@end
