//
//  DebugDatabaseManager.h
//  YYDebugDatabase
//
//  Created by wentian on 17/8/10.
//  Copyright © 2017年 wentian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GCDWebServer/GCDWebServer.h>

@interface DebugDatabaseManager : GCDWebServer

+ (instancetype)shared;

- (void)startServerOnPort:(NSInteger)port directories:(NSArray*)directories;

//默认目录为cache目录和document目录
- (void)startServerOnPort:(NSInteger)port;

@end
