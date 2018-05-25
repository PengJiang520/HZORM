//
//  ViewController.m
//  HZORM
//
//  Created by 江鹏 on 2018/5/16.
//  Copyright © 2018年 江鹏. All rights reserved.
//

#import "ViewController.h"



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTableBtn];
    [self deleteTableBtn];
    [self addDataBtn];
    [self deleteDataBtn];
    [self updateDataBtn];
    [self queryDataBtn];
}

#pragma mark 创建表按钮
- (void)addTableBtn {
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setTitle:@"添加表" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addTable) forControlEvents:UIControlEventTouchUpInside];
    
    addBtn.frame = CGRectMake(30, 60, 100, 50);
    [self.view addSubview:addBtn];
    
}

#pragma mark -- 创建表
- (void)addTable {
    Person *p = [[Person alloc] init];
    p.userName = @"张三";
    p.userPassWord = @"admin";
    p.userImageURL = @"www.baidu.com";
   // p.userInfo = @"大学生";
    p.userAge = 18;
    [p save];
    
    
}


#pragma mark 创建删除表按钮
- (void)deleteTableBtn {
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteBtn setTitle:@"删除表" forState:UIControlStateNormal];
    [deleteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(deleteTable) forControlEvents:UIControlEventTouchUpInside];
    
    deleteBtn.frame = CGRectMake(230, 60, 100, 50);
    [self.view addSubview:deleteBtn];
    
}

#pragma mark -- 删除表
- (void)deleteTable {
    
}

#pragma mark 添加数据按钮
- (void)addDataBtn {
    UIButton *addDataBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addDataBtn setTitle:@"添加数据" forState:UIControlStateNormal];
    [addDataBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [addDataBtn addTarget:self action:@selector(addData) forControlEvents:UIControlEventTouchUpInside];
    
    addDataBtn.frame = CGRectMake(30, 160, 100, 50);
    [self.view addSubview:addDataBtn];
}

#pragma mark -- 添加数据
- (void)addData {
  
    
}

#pragma mark 删除数据按钮
- (void)deleteDataBtn {
    
    UIButton *deleteDataBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteDataBtn setTitle:@"删除数据" forState:UIControlStateNormal];
    [deleteDataBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [deleteDataBtn addTarget:self action:@selector(deleteData) forControlEvents:UIControlEventTouchUpInside];
    
    deleteDataBtn.frame = CGRectMake(230, 160, 100, 50);
    [self.view addSubview:deleteDataBtn];

    
}

#pragma mark -- 删除数据
- (void)deleteData {
    
}

#pragma mark 修改数据按钮
- (void)updateDataBtn {
    
    UIButton *updateDataBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [updateDataBtn setTitle:@"修改数据" forState:UIControlStateNormal];
    [updateDataBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [updateDataBtn addTarget:self action:@selector(updateData) forControlEvents:UIControlEventTouchUpInside];
    
    updateDataBtn.frame = CGRectMake(30, 260, 100, 50);
    [self.view addSubview:updateDataBtn];
}

#pragma mark -- 修改数据
- (void)updateData {
    
}

#pragma mark 查询数据按钮
- (void)queryDataBtn {
    
    UIButton *queryDataBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [queryDataBtn setTitle:@"查询数据" forState:UIControlStateNormal];
    [queryDataBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [queryDataBtn addTarget:self action:@selector(queryData) forControlEvents:UIControlEventTouchUpInside];
    
    queryDataBtn.frame = CGRectMake(230, 260, 100, 50);
    [self.view addSubview:queryDataBtn];
}

#pragma mark -- 查询数据
- (void)queryData {
    
}



@end
