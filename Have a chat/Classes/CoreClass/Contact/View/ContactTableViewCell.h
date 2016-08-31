//
//  ContactTableViewCell.h
//  Have a chat
//
//  Created by 马凌云 on 16/8/8.
//  Copyright © 2016年 yun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *state;


@end
