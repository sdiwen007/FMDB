//
//  ViewController.m
//  数据库操作
//
//  Created by shiyong on 2019/2/27.
//  Copyright © 2019年 shiyong. All rights reserved.
//

#import "ViewController.h"
#import "FMDatabase.h"
#import "Person.h"
#import "YaoFMDBManager.h"
@interface ViewController ()
@property(nonatomic , strong)FMDatabase *db;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIButton *changeButton;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;

@end

@implementation ViewController

/*插入数据*/
- (IBAction)addButtonFMDB:(id)sender {
//    BOOL result = [self.db executeUpdate:@"insert into 't_student'(name,phone,score) values(?,?,?)" withArgumentsInArray:@[@"12",@"137",@20]];
//    if (result) {
//        NSLog(@"insert into 't_studet' success");
//    } else {
//        NSLog(@"insert into 't_studet' fail");
//    }
    NSArray *numberArray = @[@"12",@"137",@20];
    

    [[YaoFMDBManager sharedInstance] addDataWithTableName:@"t_student" primaryKey:@"yao" data:numberArray];

}
/*修改数据*/
- (IBAction)changeButtonFMDB:(id)sender {
//    BOOL result = [self.db executeUpdate:@"update 't_student' set ID = ? where name = ?" withArgumentsInArray:@[@114,@"x4"]];
//    if (result) {
//        NSLog(@"update 't_student' success");
//    } else {
//        NSLog(@"update 't_student' fail");
//    }
    [[YaoFMDBManager sharedInstance] updateDataWithTableName:@"t_student" primaryKey:@"yao" data:@[@114,@"linlin"]];
}
/*删除数据*/
- (IBAction)DeleteButtonFMDB:(id)sender {
//    BOOL result = [self.db executeUpdate:@"delete from 't_student' where ID = ?" withArgumentsInArray:@[@113]];
//    if (result) {
//        NSLog(@"delete from 't_student' success");
//    } else {
//        NSLog(@"delete from 't_student' fail");
//    }
    
    [[YaoFMDBManager sharedInstance] deleteDataWithTableName:@"t_student" primaryKey:@"yao" data:@[@117]];
}

/*查询数据*/
- (IBAction)SearchButtonFMDB:(id)sender {
//    FMResultSet *result = [self.db executeQuery:@"select * from 't_student'"];
//    NSMutableArray *arr = [NSMutableArray array];
//    while ([result next]) {
//        Person *person = [Person new];
//        person.ID = [result intForColumn:@"ID"];
//        person.name = [result stringForColumn:@"name"];
//        person.phone = [result stringForColumn:@"phone"];
//        person.score = [result intForColumn:@"score"];
//        [arr addObject:person];
//        NSLog(@"从数据库查询到的人员  %d %@ %@ %d",person.ID,person.name,person.phone,person.score);
//    }
    [[YaoFMDBManager sharedInstance] readDataWithTableName:@"t_student" primaryKey:@"yao"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //1.创建database路径
//    NSString *docuPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
//    NSString *dbPath = [docuPath stringByAppendingPathComponent:@"test.db"];
//    NSLog(@"!!!dbPath = %@",dbPath);
//    //2.创建对应路径下数据库
//    self.db = [FMDatabase databaseWithPath:dbPath];
//    //3.在数据库中进行增删改查操作时，需要判断数据库是否open，如果open失败，可能是权限或者资源不足，数据库操作完成通常使用close关闭数据库
//    [self.db open];
//    if (![self.db open]) {
//        NSLog(@"db open fail");
//        return;
//    }
//    //4.数据库中创建表（可创建多张）
//    NSString *sql = @"create table if not exists t_student ('ID' INTEGER PRIMARY KEY AUTOINCREMENT,'name' TEXT NOT NULL, 'phone' TEXT NOT NULL,'score' INTEGER NOT NULL)";
//    //5.执行更新操作 此处database直接操作，不考虑多线程问题，多线程问题，用FMDatabaseQueue 每次数据库操作之后都会返回bool数值，YES，表示success，NO，表示fail,可以通过 @see lastError @see lastErrorCode @see lastErrorMessage
//    BOOL result = [self.db executeUpdate:sql];
//    if (result) {
//        NSLog(@"create table success");
//        
//    }
}


@end
