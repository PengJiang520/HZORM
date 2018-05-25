//
//  Person.h
//  HZORM
//
//  Created by 江鹏 on 2018/5/24.
//  Copyright © 2018年 江鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKDBModel.h"

@interface Person : JKDBModel


/** 用户姓名 */
@property (nonatomic,strong) NSString *userName;

/** 用户密码 */
@property (nonatomic,strong) NSString *userPassWord;

/** 用户头像url */
@property (nonatomic,strong) NSString *userImageURL;

/** 用户简介(比如新增字段) */
@property (nonatomic,strong) NSString *userInfo;

/** 年龄 */
@property (nonatomic,assign) int userAge;




@end
