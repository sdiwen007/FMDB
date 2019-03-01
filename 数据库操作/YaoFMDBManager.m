//
//  YaoFMDBManager.m
//  数据库操作
//
//  Created by shiyong on 2019/2/27.
//  Copyright © 2019年 shiyong. All rights reserved.
//

/*对FMDB进行简单的封装*/
#import "YaoFMDBManager.h"
#import "FMDatabase.h"
#import "Person.h"

//首先将sql语句进行宏定义
#define  CREAT_TABLE_IFNOT_EXISTS    @"create table if not exists %@ ('ID' INTEGER PRIMARY KEY AUTOINCREMENT,'name' TEXT NOT NULL, 'phone' TEXT NOT NULL,'score' INTEGER NOT NULL)"

#define   INSERT_INTO_TABLE   @"insert into %@ (name,phone,score) values(?,?,?)"

#define   UPDATE_TABLE     @"update %@ set ID = ? where name = ?"

#define   DELETE_TABLE     @"delete from %@ where ID = ?"

#define   SELETE_TABLE     @"select * from %@"

@interface YaoFMDBManager ()

@property(nonatomic , strong)FMDatabase *dataBase;

@end

@implementation YaoFMDBManager

+(YaoFMDBManager *)sharedInstance{
    static YaoFMDBManager *YaoManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        YaoManager = [[YaoFMDBManager alloc]init];
    });
    return YaoManager;
}

- (NSString *)getDbPath {
    NSString *docuPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *dbPath = [docuPath stringByAppendingPathComponent:@"test.db"];
    NSLog(@"!!!dbPath = %@",dbPath);
    return dbPath;
}
- (BOOL)addDataWithTableName:(NSString *)tableName primaryKey:(NSString *)primaryKey data:(NSArray *)data {
    BOOL ret = false;
    //get the dB path
    NSString *dbPath = [self getDbPath];
    //init a dataBase
    self.dataBase = [FMDatabase databaseWithPath:dbPath];
    [self.dataBase open];
    if (![self.dataBase open]) {
        NSLog(@"dataBase open fail");
    }
    if ([self.dataBase open]) {
        NSString *sql = [NSString stringWithFormat:CREAT_TABLE_IFNOT_EXISTS,tableName];
        ret = [self.dataBase executeUpdate:sql];
        if (ret) {
            NSLog(@"create table success");
            NSString *sql_Insert = [NSString stringWithFormat:INSERT_INTO_TABLE,tableName];
            BOOL result = [self.dataBase executeUpdate:sql_Insert withArgumentsInArray:data];
            if (result) {
                NSLog(@"insert table success");
            }else{
                NSLog(@"insert table fail");
            }
        }
    }
    return ret;
}
- (void)readDataWithTableName:(NSString *)tableName primaryKey:(NSString *)primaryKey {
    NSString *dbPath = [self getDbPath];
    self.dataBase = [FMDatabase databaseWithPath:dbPath];
    [self.dataBase open];
    NSString *sql = [NSString stringWithFormat:SELETE_TABLE,tableName];
    FMResultSet *resultSet = [self.dataBase executeQuery:sql];
    while ([resultSet next]) {
        Person *person = [Person new];
        person.ID = [resultSet intForColumn:@"ID"];
        person.name = [resultSet stringForColumn:@"name"];
        person.phone = [resultSet stringForColumn:@"phone"];
        person.score = [resultSet intForColumn:@"score"];
        NSLog(@"从数据库查询到的人员  %d %@ %@ %d",person.ID,person.name,person.phone,person.score);
    }
}
- (BOOL)deleteDataWithTableName:(NSString *)tableName primaryKey:(NSString *)primaryKey data:(NSArray *)data{
    BOOL ret = false;
    NSString *dbPath = [self getDbPath];
    self.dataBase = [FMDatabase databaseWithPath:dbPath];
    if ([self.dataBase open]) {
        NSString *deleteSql = [NSString stringWithFormat:DELETE_TABLE,tableName];
        ret = [self.dataBase executeUpdate:deleteSql withArgumentsInArray:data];
        if (ret) {
            NSLog(@"delete table success");
        }else{
            NSLog(@"delete table fail");
        }
    }
    return ret;
}
- (BOOL)updateDataWithTableName:(NSString *)tableName primaryKey:(NSString *)primaryKey data:(NSArray *)data {
    
    BOOL ret = false;
    NSString *dbPath = [self getDbPath];
    self.dataBase = [FMDatabase databaseWithPath:dbPath];
    if ([self.dataBase open]) {
        NSString *sql = [NSString stringWithFormat:UPDATE_TABLE,tableName];
        ret = [self.dataBase executeUpdate:sql withArgumentsInArray:data];
        if (ret) {
            NSLog(@"update table success");
        }else{
            NSLog(@"update table fail");
        }
    }
    return ret;
}




@end
