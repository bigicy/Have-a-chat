//
//  ContactViewController.m
//  Have a chat
//
//  Created by 马凌云 on 16/8/6.
//  Copyright © 2016年 yun. All rights reserved.
//

#import "ContactViewController.h"
#import "ContactTableViewCell.h"
#import "addFriendViewController.h"

@interface ContactViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

//
@property (nonatomic,strong) NSArray *firendArray;


@end

@implementation ContactViewController

- (NSArray *)firendArray{
    if (!_firendArray) {
        _firendArray = [[NSArray alloc] init];
    }
    return _firendArray;
}

//界面设置

- (void)viewDesign{
    
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(addBtnAction)];
    self.navigationItem.rightBarButtonItem = addBtn;
    
    // 从服务器获取所有的好友
    EMError *error = nil;
    self.firendArray = [[EMClient sharedClient].contactManager getContactsFromServerWithError:&error];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ContactTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    
}

// 添加好友

- (void)addBtnAction{
    
    addFriendViewController *addVC = [[addFriendViewController alloc] init];
    
    [self.navigationController pushViewController:addVC animated:YES];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.firendArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return nil;
}

@end
