//
//  FMDBManager.m
//  Have a chat
//
//  Created by 马凌云 on 16/8/5.
//  Copyright © 2016年 yun. All rights reserved.
//

#import "FMDBManager.h"


static FMDBManager *handle = nil;
static FMDatabase *db = nil;

@implementation FMDBManager

// 单例
+ (instancetype)shareFMDBManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handle = [[FMDBManager alloc] init];
    });
    return  handle;
}

// 创建数据库路径

- (NSString *)createSqlitePath:(NSString *)path{
    
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:path];
}


// 创建数据库
- (void)createDB{
    if (db != nil) {
        return;
    }
    
    NSString *dataPath = [self createSqlitePath:@"FMDB.sqlite"];
    NSLog(@"%@",dataPath);
    db = [FMDatabase databaseWithPath:dataPath];
}

// 建表
- (void)createTableName:(NSString *)tableName{
    
    [db open];
    
    NSString *sqlString = [NSString stringWithFormat:@"create table if not exists %@ (ID integer primary key autoincrement, account text, password text, nickname text, image blob, email text)",tableName];
    
   BOOL flag = [db executeUpdate:sqlString];
    if (flag == YES) {
        printf("建表成功");
    }
    [db close];
}

// 添加
- (void)insertDataWithTableName:(NSString *)tableName account:(NSString *)account password:(NSString *)password nickname:(NSString *)nickname image:(UIImage *)image email:(NSString *)email{
   
    [db open];
    
    NSString *sqlString = [NSString stringWithFormat:@"insert into %@ (account, password, nickname, image, email) values (?, ?, ?, ?, ?)",tableName];
    
    [db executeUpdate:sqlString,account,password,nickname,UIImagePNGRepresentation(image),email];
    
    [db close];
}

// 删除
- (void)deleteDataWithTableName:(NSString *)tableName account:(NSString *)account{
    
    [db open];
    
    NSString *sqlString = [NSString stringWithFormat:@"delete from %@ where account = ?",tableName];
    
    [db executeUpdate:sqlString,account];
    
    [db close];
}

// 修改
- (void)updataWithTableName:(NSString *)tableName password:(NSString *)password nickname:(NSString *)nickname image:(UIImage *)image email:(NSString *)email forAccount:(NSString *)account{
    
    [db open];
    
    NSString *sqlString = [NSString stringWithFormat:@"update %@ set password = ?, nickname = ?, image = ?, email = ? where account = ?",tableName];
    
    [db executeUpdate:sqlString,password,nickname,UIImagePNGRepresentation(image),email];
    [db close];
}

// 查
// 单个
- (UserModel *)searchOneWithTableName:(NSString *)tableName forAccount:(NSString *)account{
    
    [db open];
    
    NSString *sqlString = [NSString stringWithFormat:@"select * from %@ where account = ?",tableName];
    // 查询语句
    FMResultSet *set = [db executeQuery:sqlString,account];
    
    UserModel *model = [[UserModel alloc] init];
    
    while ([set next]) {
        model.account = [set stringForColumn:@"account"];
        model.password =[set stringForColumn:@"password"];
        model.nickname = [set stringForColumn:@"nickname"];
        NSData *data = [set dataForColumn:@"image"];
        model.image = [UIImage imageWithData:data];
        model.email = [set stringForColumn:@"email"];
         
    }
    [db close];
    
    return model;
    
}

// 所有
- (NSMutableArray *)searchAllWithTableName:(NSString *)tableName{
    
    [db open];
    
    NSString *sqlString = [NSString stringWithFormat:@"select * from %@",tableName];
    
    FMResultSet *set = [db executeQuery:sqlString];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    while ([set next]) {
        UserModel *model = [[UserModel alloc] init];
        
        model.account = [set stringForColumn:@"account"];
        model.password =[set stringForColumn:@"password"];
        model.nickname = [set stringForColumn:@"nickname"];
        NSData *data = [set dataForColumn:@"image"];
        model.image = [UIImage imageWithData:data];
        model.email = [set stringForColumn:@"email"];
        [array addObject:model];

    }
    [db close];
    return array;
}

@end
