//
//  RegisterViewController.m
//  Have a chat
//
//  Created by 马凌云 on 16/8/5.
//  Copyright © 2016年 yun. All rights reserved.
//

#import "RegisterViewController.h"
#import "FMDBManager.h"
#import "YGValidator.h"

@interface RegisterViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>

// 头像
@property (weak, nonatomic) IBOutlet UIImageView *headerPic;

// 昵称
@property (weak, nonatomic) IBOutlet UITextField *nickName;
// 账号
@property (weak, nonatomic) IBOutlet UITextField *account;
// 密码
@property (weak, nonatomic) IBOutlet UITextField *passWord;
// 邮箱
@property (weak, nonatomic) IBOutlet UITextField *email;

@end

@implementation RegisterViewController


- (IBAction)registerBtn:(id)sender {
    
    // 判断(重用名的问题)
    
    if ([_account.text isEqualToString:@""] || [_passWord.text isEqualToString:@""]|| [_nickName.text isEqualToString:@""] || [_email.text isEqualToString:@""]) {
        
        [self informationShow:@"您的信息不全，请查证"];
        
    } else{
        
        EMError *error = [[EMClient sharedClient] registerWithUsername:_account.text password:_passWord.text];
        // block传值
        self.mess(_account.text, _passWord.text);
        
        if (error == nil) {
            NSLog(@"注册成功");
        }
        
        // 自己的数据库
        [FMDBManager.shareFMDBManager createDB];
        [FMDBManager.shareFMDBManager createTableName:@"userInfo"];
        
        [FMDBManager.shareFMDBManager insertDataWithTableName:@"userInfo" account:_account.text password:_passWord.text nickname:_nickName.text image:_headerPic.image email:_email.text];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
    
}

// 判断弹出

- (void)informationShow:(NSString *)message{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    
    
    [alert addAction:action1];
    [self presentViewController:alert animated:YES completion:nil];

}

// 界面设计
- (void)viewDesign{
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.headerPic addGestureRecognizer:tap];
    
    
    _headerPic.layer.cornerRadius = 50;
    _headerPic.layer.masksToBounds = YES;
    
}
// 手势
- (void)tapAction:(UITapGestureRecognizer*) tap{
    
    [self imageShow];
    
}

// 图片弹出
- (void)imageShow{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"本地" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self pickerImage];
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:action1];
    [alert addAction:action2];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

// 图片选取
- (void)pickerImage{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self viewDesign];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --------- 代理 ---------

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    _headerPic.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSMutableString *str = [NSMutableString stringWithString:textField.text];
    [str appendString:string];
    
    [YGValidator validateText:str regular:@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.(com|cn)" textField:textField correctImage:@"1" errorImage:@"0"];
    
    return YES;

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
