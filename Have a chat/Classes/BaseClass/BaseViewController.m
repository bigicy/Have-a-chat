//
//  BaseViewController.m
//  Have a chat
//
//  Created by 马凌云 on 16/8/6.
//  Copyright © 2016年 yun. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)addChildViewControllers{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"BaseVC.json" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    for (NSDictionary *dict in array) {
        [self baseVCWithControllerName:dict[@"controllerName"] title:dict[@"title"] image:dict[@"image"]];
    }
}

- (void)baseVCWithControllerName:(NSString*)controllerName title:(NSString*)title image:(NSString*)image{
    
    UIViewController *controller =(UIViewController *)[[NSClassFromString(controllerName) alloc] init];
    UINavigationController *NC = [[UINavigationController alloc] initWithRootViewController:controller];
    NC.navigationBar.barTintColor = [UIColor colorWithRed:50/255. green:205/255. blue:50/255. alpha:1];
    NC.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    controller.tabBarItem.title = title;
    controller.navigationItem.title = title;
    controller.tabBarItem.image = [UIImage imageNamed:image];
    [self addChildViewController:NC];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBar.tintColor = [UIColor colorWithRed:50/255. green:205/255. blue:50/255. alpha:1];
    self.tabBar.barTintColor = [UIColor whiteColor];
    [self addChildViewControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
