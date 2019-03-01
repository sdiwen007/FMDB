//
//  Person.h
//  数据库操作
//
//  Created by shiyong on 2019/2/27.
//  Copyright © 2019年 shiyong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property (nonatomic, assign) int ID;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, assign) int score;

@end

NS_ASSUME_NONNULL_END
