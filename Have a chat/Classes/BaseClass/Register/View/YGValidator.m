//
//  ValidatorTextField.m
//  iOS-Validator
//
//  Created by Lovecx on 16/4/27.
//  Copyright © 2016年 Lovecx. All rights reserved.
//

#import "YGValidator.h"

@implementation YGValidator

static UIImageView *_imageView;
static const NSInteger imageWH = 20; // 图片的宽高

#pragma mark - 内部判断

/** 内部判断 */
+ (void)validateText:(NSString *)text regular:(NSString *)regular textField:(UITextField *)textField correctImage:(NSString *)correctImage errorImage:(NSString *)errorImage
{
    YGValidator *validator = [[YGValidator alloc] init];

    if (_imageView == nil) {
        CGFloat textFieldH = textField.frame.size.height;
        CGFloat imgY = (textFieldH - imageWH) / 2;
        _imageView  = [[UIImageView alloc] initWithFrame:CGRectMake(0, imgY, imageWH, imageWH)];
        textField.rightView = _imageView;
        textField.rightViewMode = UITextFieldViewModeAlways;
    }
    
    if ([validator isValidateText:text regular:regular]) {
        _imageView.image = [UIImage imageNamed:correctImage];
    } else {
        _imageView.image = [UIImage imageNamed:errorImage];
    }
}

- (BOOL)isValidateText:(NSString *)text regular:(NSString *)regular {
    NSString *rule = regular;
    NSPredicate *ruleTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", rule];
    return [ruleTest evaluateWithObject:text];
}

#pragma mark - 外部判断

/** 外部判断 */
+ (BOOL)validateType:(YGSTextFieldType)type text:(NSString *)text
{
    YGValidator *validator = [[YGValidator alloc] init];
    
    if (type == YGTextFieldNumber)
    {
        BOOL isNumber = [validator isValidateNumber:text];
        return isNumber;
    }
    else if (type == YGTextFieldName)
    {
        BOOL isName = [validator isValidateName:text];
        return isName;
    }
    else if (type == YGTextFieldPhoneNumber)
    {
        BOOL isPhoneNumber = [validator isValidatePhoneNumber:text];
        return isPhoneNumber;
    }
    else if (type == YGTextFieldEmail)
    {

        BOOL isEmail = [validator isValidateEmail:text];
        return isEmail;
    }
    else if (type == YGTextFieldPassWord)
    {
        BOOL isPaw = [validator isValidatePassWord:text];
        return isPaw;
    } else {
        return NO;
    }
    
}

/** 数字校验器 */
- (BOOL)isValidateNumber:(NSString *)number
{
    NSCharacterSet *characterSet = [[NSCharacterSet characterSetWithCharactersInString:numberSperiod] invertedSet];
    NSString *fileText = [[number componentsSeparatedByCharactersInSet:characterSet] componentsJoinedByString:@""];
    BOOL basicTest = [number isEqualToString:fileText];
    return basicTest;
}

/** 判断用户名 */
- (BOOL)isValidateName:(NSString *)name
{
    NSString *regex = @"^\\w{2,16}{1}";
    NSPredicate *nameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [nameTest evaluateWithObject:name];
}

/** 判断手机号，1开头的11位 */
- (BOOL)isValidatePhoneNumber:(NSString *)phoneNumber
{
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     * 联通号段: 130,131,132,155,156,185,186,145,176,1709
     * 电信号段: 133,153,180,181,189,177,1700
     */
    NSString *mobile = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|70)\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobile];
    return [phoneTest evaluateWithObject:phoneNumber];
}

/** 判断邮箱 */
- (BOOL)isValidateEmail:(NSString *)email
{
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [emailTest evaluateWithObject:email];
}

/** 判断密码，6-16位 */
- (BOOL)isValidatePassWord:(NSString *)passWord
{
    NSString *regex = @"\\w(6,16)";
    NSPredicate *pawTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pawTest evaluateWithObject:passWord];
}

@end
