//
//  RegisterViewController.h
//  Have a chat
//
//  Created by 马凌云 on 16/8/5.
//  Copyright © 2016年 yun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^block) (NSString *, NSString *);

@interface RegisterViewController : UIViewController

//
@property (nonatomic,copy) block mess;


@end
