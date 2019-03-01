//
//  YaoFMDBManager.h
//  数据库操作
//
//  Created by shiyong on 2019/2/27.
//  Copyright © 2019年 shiyong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YaoFMDBManager : NSObject

+(YaoFMDBManager *)sharedInstance;

- (BOOL)addDataWithTableName:(NSString *)tableName primaryKey:(NSString *)primaryKey data:(NSArray *)data;

- (void)readDataWithTableName:(NSString *)tableName primaryKey:(NSString *)primaryKey;

- (BOOL)deleteDataWithTableName:(NSString *)tableName primaryKey:(NSString *)primaryKey data:(NSArray *)data;

- (BOOL)updateDataWithTableName:(NSString *)tableName primaryKey:(NSString *)primaryKey data:(NSArray *)data;

@end

NS_ASSUME_NONNULL_END
