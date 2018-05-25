#FMDB映射模型和真机可视化操作数据库

### 1.如何对FMDB映射模型的操作:直接操作模型即可操作数据库

* 使用FMDatabaseQueue对数据操作(线程安全并且支持数据库事物操作)

	```
	[jkDB.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
	 
 }];
   
	```
	
* 利用runtime对模型属性转换成数据库字段(这个是整个操作的关键)

```

+ (NSDictionary *)getPropertys
{
    NSMutableArray *proNames = [NSMutableArray array];
    NSMutableArray *proTypes = [NSMutableArray array];
    NSArray *theTransients = [[self class] transients];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        //获取属性名
        NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        if ([theTransients containsObject:propertyName]) {
            continue;
        }
        [proNames addObject:propertyName];
        //获取属性类型等参数
        NSString *propertyType = [NSString stringWithCString: property_getAttributes(property) encoding:NSUTF8StringEncoding];
        /*
         c char         C unsigned char
         i int          I unsigned int
         l long         L unsigned long
         s short        S unsigned short
         d double       D unsigned double
         f float        F unsigned float
         q long long    Q unsigned long long
         B BOOL
         @ 对象类型 //指针 对象类型 如NSString 是@“NSString”
         
         
         64位下long 和long long 都是Tq
         SQLite 默认支持五种数据类型TEXT、INTEGER、REAL、BLOB、NULL
         */
        if ([propertyType hasPrefix:@"T@"]) {
            [proTypes addObject:SQLTEXT];
        } else if ([propertyType hasPrefix:@"Ti"]||[propertyType hasPrefix:@"TI"]||[propertyType hasPrefix:@"Ts"]||[propertyType hasPrefix:@"TS"]||[propertyType hasPrefix:@"TB"]) {
            [proTypes addObject:SQLINTEGER];
        } else {
            [proTypes addObject:SQLREAL];
        }
        
    }
    free(properties);
    
    return [NSDictionary dictionaryWithObjectsAndKeys:proNames,@"name",proTypes,@"type",nil];
}

/** 获取所有属性，包含主键pk */
+ (NSDictionary *)getAllProperties
{
    NSDictionary *dict = [self.class getPropertys];
    
    NSMutableArray *proNames = [NSMutableArray array];
    NSMutableArray *proTypes = [NSMutableArray array];
    [proNames addObject:primaryId];
    [proTypes addObject:[NSString stringWithFormat:@"%@ %@",SQLINTEGER,PrimaryKey]];
    [proNames addObjectsFromArray:[dict objectForKey:@"name"]];
    [proTypes addObjectsFromArray:[dict objectForKey:@"type"]];
    
    return [NSDictionary dictionaryWithObjectsAndKeys:proNames,@"name",proTypes,@"type",nil];
}


 NSDictionary *dict = [self.class getAllProperties];
    NSArray *properties = [dict objectForKey:@"name"];
    NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"NOT (SELF IN %@)",columns];
    //过滤数组
    NSArray *resultArray = [properties filteredArrayUsingPredicate:filterPredicate];

    for (NSString *column in resultArray) {
        NSUInteger index = [properties indexOfObject:column];
        NSString *proType = [[dict objectForKey:@"type"] objectAtIndex:index];
        NSString *fieldSql = [NSString stringWithFormat:@"%@ %@",column,proType];
        NSString *sql = [NSString stringWithFormat:@"ALTER TABLE %@ ADD COLUMN %@ ",NSStringFromClass(self.class),fieldSql];
        if (![db executeUpdate:sql]) {
            return NO;
        }
    }
    [db close];

```
	
### 如何操作数据库（注意:模型类必须继承JKDBModel）
* 插入数据库

	 ```
 	Person *p = [[Person alloc] init];
    p.userName = @"张三";
    p.userPassWord = @"admin";
    p.userImageURL = @"www.baidu.com";
    p.userInfo = @"大学生";
    p.userAge = 18;
    [p save];
    ```
  
* 利用事务批量插入数据库

   ```
    NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i < 500; i++) {
            User *user = [[User alloc] init];
            user.name = [NSString stringWithFormat:@"李四%d",i];
            user.age = 10+i;
            user.sex = @"女";
            [array addObject:user];
        }
       [User saveObjects:array];
    ```
    
   
* 删除数据 
	`[User deleteObjectsByCriteria:@" WHERE pk < 10"];`
	
	
* 利用事务批量删除数据
 	
 	```
 	  NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i < 500; i++) {
            User *user = [[User alloc] init];
            user.pk = 501+i;
            [array addObject:user];
        }
        
        [User deleteObjects:array];
      ```
      
      
* 修改数据

	```
  for (int i = 0; i < 500; i++) {
            User *user = [[User alloc] init];
            user.name = [NSString stringWithFormat:@"啊我			哦%d",i];
            user.age = 88+i;
            user.pk = 10+i;
            [array addObject:user];
        }
        [User updateObjects:array];
	```
* 查询所有数据

	`[User findAll]`
	
* 分页查询数据

	```
	static int pk = 5;
   	NSArray *array = [User findByCriteria:[NSString stringWithFormat:@" WHERE pk > %d limit 10",pk]];
    pk = ((User *)[array lastObject]).pk;
	```
* 根据条件查询数据

	```
	[User findByCriteria:@" WHERE age < 20 "]
	```
	
	
#### 源码代码请看:[代码](https://github.com/Haley-Wong/JKDBModel.git)



### 2.真机可视化操作数据库调试
[iOS开发过程中优雅的调试数据库](https://www.jianshu.com/p/c5d6d329731b)

* 打开手机查看手机连接的wifi的ip地址(看下图:注意手机连上的wifi要跟你电脑连上的wifi是同一个)
![wifi图片](https://upload-images.jianshu.io/upload_images/1375938-5b1d7982092e67e6.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240))


* 在AppDelegate里面didFinishLaunchingWithOptions方法添加配置端口9002,还需要配置你数据库存在的位置,默认情况下会自动从NSHomeDirectory(),
 Library/Cache, Documents目录找

	```
	- (BOOL)application:(UIApplication *)application 	didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 	{
    // Override point for customization after application launch.
    
    //配置数据库放在哪里
    //NSString *resourceDirectory = [[NSBundle mainBundle] 	resourcePath];
   	 NSString *databaseDirectory = [NSHomeDirectory() 	stringByAppendingPathComponent:@"Documents/JKBD"];
	//NSString *documentDirectory = [NSHomeDirectory() 	stringByAppendingPathComponent:@"Documents"];
	//NSString *cacheDirectory = [NSHomeDirectory() 	stringByAppendingPathComponent:@"Library/Cache"];
   	[[DebugDatabaseManager shared] startServerOnPort:9002 	directories:@[databaseDirectory]];
   	 return YES;
	}

	```

* 最后运行app 在浏览器输入您的手机ip:9002 例如我的:http://192.168.90.145:9002

![](https://upload-images.jianshu.io/upload_images/1375938-0ceda2a50ced9dc6.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


代码移至我的github:[欢迎指正](https://github.com/PengJiang520/HZORM.git)