//
//  LoginViewController.m
//  Have a chat
//
//  Created by 马凌云 on 16/8/5.
//  Copyright © 2016年 yun. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "AccountTableViewCell.h"
#import "FMDBManager.h"
#import "UserModel.h"
#import "BaseViewController.h"

// cell高度
#define cellHeight 50
// tableView高度
#define tableViewHeight 260

@interface LoginViewController ()<UITableViewDelegate,UITableViewDataSource,EMClientDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *headerPic;

@property (weak, nonatomic) IBOutlet UIButton *upAndDown;

@property (weak, nonatomic) IBOutlet UITextField *accountTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;


// 账号数组
@property (nonatomic,strong) NSMutableArray *accountArray;


// 账号显示
@property (nonatomic) BOOL isOpen;

// 账号
@property (nonatomic,strong) UITableView *tableView;


@end

@implementation LoginViewController

- (NSMutableArray *)accountArray{
    
    if (_accountArray == nil) {
        _accountArray = [[NSMutableArray alloc] init];
    }
    return _accountArray;
}

- (IBAction)Users:(UIButton *)sender {
    
    if (self.isOpen == NO) {
        [self.upAndDown setImage:[UIImage imageNamed:@"向上"] forState:UIControlStateNormal];
        
        [UIView animateWithDuration:1 animations:^{
            [self tableViewShow:_accountArray.count];
        } completion:^(BOOL finished) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }];
        
    } else {
        [self.upAndDown setImage:[UIImage imageNamed:@"向下"] forState:UIControlStateNormal];
        
        [UIView animateWithDuration:1 animations:^{
            [self tableViewShow:0];
        } completion:nil];
    }
    
    _isOpen = !_isOpen;
    
}

- (IBAction)loginBtn:(id)sender {
    
    // 自动登录
    
    EMError *error = [[EMClient sharedClient] loginWithUsername:_accountTextField.text password:_passwordTextField.text];
    if (!error)
    {
        [[EMClient sharedClient].options setIsAutoLogin:YES];
        BaseViewController *baseVC = [[BaseViewController alloc] init];
        
        [self presentViewController:baseVC animated:YES completion:nil];
            
    } else {
            
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"提示" message:@"登录失败，请重新输入" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *aa = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [ac addAction:aa];
        [self presentViewController:ac animated:YES completion:nil];

        }
    
//    BaseViewController *baseVC = [[BaseViewController alloc] init];
//    
//    [self presentViewController:baseVC animated:YES completion:nil];

    
}

- (IBAction)registerBtn:(id)sender {
    
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    registerVC.mess = ^(NSString *account, NSString *password){
        
        self.accountTextField.text = account;
        self.passwordTextField.text = password;
    };
    [self.navigationController pushViewController:registerVC animated:YES];
    
}

- (IBAction)questionBtn:(id)sender {
    
    
}

// tableView
- (void)tableViewShow:(NSInteger)count {
    
    _tableView.frame = CGRectMake(0, tableViewHeight, kScreenWidth, count * cellHeight);
    
}



// UI
- (void)viewDesign {
    
//    self.accountArray = [@[@"asdasd",@"sd"]mutableCopy];
    
    _headerPic.layer.cornerRadius = 50;
    _headerPic.layer.masksToBounds = YES;
    
    self.tableView = [[UITableView alloc] initWithFrame: CGRectMake(0, tableViewHeight, kScreenWidth, 0) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    _tableView.rowHeight = cellHeight;
    
    [_tableView registerNib:[UINib nibWithNibName:@"AccountTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];

    
}

// 设置代理
- (void)viewWillAppear:(BOOL)animated
{
    self.accountArray = [FMDBManager.shareFMDBManager searchAllWithTableName:@"userInfo"];
    [[EMClient sharedClient] addDelegate:self delegateQueue:nil];
    
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _accountArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AccountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    UserModel *model = _accountArray[indexPath.row];
    [cell setValueWithModel:model];
    
    return cell;
}

- (void)didAutoLoginWithError:(EMError *)aError{
    
    BaseViewController *baseVC = [[BaseViewController alloc] init];
    
    [self presentViewController:baseVC animated:YES completion:nil];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSInteger index = textField.tag;
    if (index != 6) {
        [[self.view viewWithTag:index +1] becomeFirstResponder];
    }else{
        [[self.view viewWithTag:index] resignFirstResponder];
    }
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
