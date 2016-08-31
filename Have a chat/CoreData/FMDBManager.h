//
//  FMDBManager.h
//  Have a chat
//
//  Created by 马凌云 on 16/8/5.
//  Copyright © 2016年 yun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

@interface FMDBManager : NSObject

// 单例
+ (instancetype)shareFMDBManager;

// 创建数据库
- (void)createDB;

// 建表
- (void)createTableName:(NSString *)tableName;

// 添加
- (void)insertDataWithTableName:(NSString *)tableName account:(NSString *)account password:(NSString *)password nickname:(NSString *)nickname image:(UIImage *)image email:(NSString *)email;

// 删除
- (void)deleteDataWithTableName:(NSString *)tableName account:(NSString *)account;

// 修改
- (void)updataWithTableName:(NSString *)tableName password:(NSString *)password nickname:(NSString *)nickname image:(UIImage *)image email:(NSString *)email forAccount:(NSString *)account;


// 查
// 单个
- (UserModel *)searchOneWithTableName:(NSString *)tableName forAccount:(NSString *)account;


// 所有
- (NSMutableArray *)searchAllWithTableName:(NSString *)tableName;





@end
