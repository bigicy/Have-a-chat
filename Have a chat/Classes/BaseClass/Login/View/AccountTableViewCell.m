//
//  AccountTableViewCell.m
//  Have a chat
//
//  Created by 马凌云 on 16/8/6.
//  Copyright © 2016年 yun. All rights reserved.
//

#import "AccountTableViewCell.h"
#import "LoginViewController.h"
@implementation AccountTableViewCell

- (IBAction)deleteBtn:(id)sender {
    
    AccountTableViewCell *cell = (AccountTableViewCell*)((UIButton *)sender).superview.superview;
    
    UITableView *tableView = (UITableView *)cell.superview.superview;
    LoginViewController * vc = (LoginViewController *)tableView.superview;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"你确定删除当前账号？" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [FMDBManager.shareFMDBManager deleteDataWithTableName:@"userInfo" account:cell.account.text];
        dispatch_async(dispatch_get_main_queue(), ^{
            [tableView reloadData];
        });
        
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:action1];
    [alert addAction:action2];

    [vc presentViewController:alert animated:YES completion:nil];

    
}



- (void)setValueWithModel:(UserModel *)model{
    
    self.headerPic.image  = model.image;
    self.account.text = model.account;
    
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.headerPic.layer.cornerRadius = 20;
    self.headerPic.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
