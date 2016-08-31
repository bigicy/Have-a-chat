//
//  ValidatorTextField.h
//  iOS-Validator
//
//  Created by Lovecx on 16/4/27.
//  Copyright © 2016年 Lovecx. All rights reserved.
//

/**
 *  例：输入框
 *  外部使用请实现textField的代理方法
 *  - (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
    
    @"^\\w{2,16}{1}"
    @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|70)\\d{8}$
    @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
    @"\\w(6,16)"
 
 */

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YGSTextFieldType)
{
    YGTextFieldNumber,          // 数字校验
    YGTextFieldName,            // 用户名校验
    YGTextFieldPhoneNumber,     // 手机号校验
    YGTextFieldEmail,           // 邮箱校验
    YGTextFieldPassWord,        // 密码校验
    
};

static NSString * const numberSperiod = @"0123456789";

@interface YGValidator : NSObject

/** 枚举 */
@property (nonatomic, assign) YGSTextFieldType *type;

#pragma mark - 内部判断

/** 内部判断 */
+ (void)validateText:(NSString *)text regular:(NSString *)regular textField:(UITextField *)textField correctImage:(NSString *)correctImage errorImage:(NSString *)errorImage;
- (BOOL)isValidateText:(NSString *)text regular:(NSString *)regular;

#pragma mark - 外部判断
/** 外部判断 */
+ (BOOL)validateType:(YGSTextFieldType)type text:(NSString *)text;
/** 数字校验器 */
- (BOOL)isValidateNumber:(NSString *)number;
/** 判断用户名 */
- (BOOL)isValidateName:(NSString *)name;
/** 判断手机号，1开头的11位 */
- (BOOL)isValidatePhoneNumber:(NSString *)phoneNumber;
/** 判断邮箱 */
- (BOOL)isValidateEmail:(NSString *)email;
/** 判断密码，6-16位 */
- (BOOL)isValidatePassWord:(NSString *)passWord;

@end
