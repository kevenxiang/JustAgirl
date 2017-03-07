
#import "DBModel.h"
#import "DBService.h"
#import "NSObject+Sqlite3.h"
#import <objc/runtime.h>
#import "FMDB.h"

@implementation DBModel

+ (NSString *)genUUID {
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuid = CFUUIDCreateString(NULL, uuidRef);
    
    CFRelease(uuidRef);
    NSString *uid = (__bridge_transfer NSString *)uuid;
    uid = [uid stringByReplacingOccurrencesOfString:@"-" withString:@""];//去掉'-'
    return uid;
}

#pragma mark - override method
+ (void)initialize
{
    if (self != [DBModel self]) {
        [self createTable];
    }
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSDictionary *dic = [self.class getAllProperties];
        _columeNames = [[NSMutableArray alloc] initWithArray:[dic objectForKey:@"name"]];
        _columeTypes = [[NSMutableArray alloc] initWithArray:[dic objectForKey:@"type"]];
    }
    
    return self;
}

#pragma mark - base method
/**
 *  获取该类的所有属性
 */
+ (NSDictionary *)getPropertys
{
    NSMutableArray *proNames = [NSMutableArray array];
    NSMutableArray *proTypes = [NSMutableArray array];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        //获取属性名
        NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        [proNames addObject:propertyName];
        //获取属性类型等参数
        NSString *propertyType = [NSString stringWithCString: property_getAttributes(property) encoding:NSUTF8StringEncoding];
        /*
         各种符号对应类型，部分类型在新版SDK中有所变化，如long 和long long
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
         因为在项目中用的类型不多，故只考虑了少数类型
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
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:proNames,@"name",proTypes,@"type",nil];
    return dic;
}

/** 获取所有属性，包含主键pk */
+ (NSDictionary *)getAllProperties
{
    NSDictionary *dict = [self.class getPropertys];
    
    NSMutableArray *proNames = [NSMutableArray array];
    NSMutableArray *proTypes = [NSMutableArray array];
    [proNames addObjectsFromArray:[dict objectForKey:@"name"]];
    [proTypes addObjectsFromArray:[dict objectForKey:@"type"]];

//    [proNames removeObject:[self.class primaryKey]];
//    [proTypes removeObject:[dict objectForKey:[self.class primaryKey]]];
//    [proNames addObject:[self.class primaryKey]];
//    [proTypes addObject:[NSString stringWithFormat:@"%@ %@",SQLINTEGER,@"primary key"]];
    
    return [NSDictionary dictionaryWithObjectsAndKeys:proNames,@"name",proTypes,@"type",nil];
}

/** 数据库中是否存在表 */
+ (BOOL)isExistInTable
{
    __block BOOL res = NO;
    DBService *jkDB = [DBService shareInstance];
    [jkDB.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *tableName = NSStringFromClass(self.class);
         res = [db tableExists:tableName];
    }];
    return res;
}

/** 获取列名 */
+ (NSArray *)getColumns
{
    DBService *jkDB = [DBService shareInstance];
    NSMutableArray *columns = [NSMutableArray array];
     [jkDB.dbQueue inDatabase:^(FMDatabase *db) {
         NSString *tableName = NSStringFromClass(self.class);
         FMResultSet *resultSet = [db getTableSchema:tableName];
         while ([resultSet next]) {
             NSString *column = [resultSet stringForColumn:@"name"];
             [columns addObject:column];
         }
     }];
    return [columns copy];
}

/**
 * 创建表
 * 如果已经创建，返回YES
 */
+ (BOOL)createTable
{
    __block BOOL res = YES;
    DBService *jkDB = [DBService shareInstance];
    [jkDB.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        NSString *tableName = NSStringFromClass(self.class);
        NSString *sql = [self.class getTableSchema];
        if (![db executeUpdate:sql]) {
            res = NO;
            *rollback = YES;
            return;
        };
        
        NSMutableArray *columns = [NSMutableArray array];
        FMResultSet *resultSet = [db getTableSchema:tableName];
        while ([resultSet next]) {
            NSString *column = [resultSet stringForColumn:@"name"];
            [columns addObject:column];
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
                res = NO;
                *rollback = YES;
                return ;
            }
        }
    }];
    
    return res;
}

- (BOOL)saveOrUpdate
{
    id primaryValue = [self valueForKey:[self.class primaryKey]];
    NSString *primaryKey = [self.class primaryKey];
    NSString *where = [NSString stringWithFormat:@"WHERE %@='%@'", primaryKey, primaryValue];
    NSArray *array = [self.class queryByCondition:where];
    if ([array count] > 0) {
        return [self update];
    } else {
        return [self save];
    }
}

- (BOOL)save
{
    NSString *tableName = NSStringFromClass(self.class);
    NSMutableString *keyString = [NSMutableString string];
    NSMutableString *valueString = [NSMutableString string];
    NSMutableArray *insertValues = [NSMutableArray  array];
    for (int i = 0; i < self.columeNames.count; i++) {
        NSString *proname = [self.columeNames objectAtIndex:i];
        [keyString appendFormat:@"%@,", proname];
        [valueString appendString:@"?,"];
        id value = [[(NSObject*)self valueForKey:proname] toSQLString];
        if (!value) {
            value = @"";
        }
        [insertValues addObject:value];
    }
    
    [keyString deleteCharactersInRange:NSMakeRange(keyString.length - 1, 1)];
    [valueString deleteCharactersInRange:NSMakeRange(valueString.length - 1, 1)];
    
    DBService *jkDB = [DBService shareInstance];
    __block BOOL res = NO;
    [jkDB.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@(%@) VALUES (%@);", tableName, keyString, valueString];
        res = [db executeUpdate:sql withArgumentsInArray:insertValues];
        self.pId = res?[NSNumber numberWithLongLong:db.lastInsertRowId].intValue:0;
        NSLog(res?@"插入成功":@"插入失败");
    }];
    return res;
}

/** 批量保存用户对象 */
+ (BOOL)saveObjects:(NSArray *)array
{
    //判断是否是DBModel的子类
    for (DBModel *model in array) {
        if (![model isKindOfClass:[DBModel class]]) {
            return NO;
        }
    }
    
    __block BOOL res = YES;
    DBService *jkDB = [DBService shareInstance];
    // 如果要支持事务
    [jkDB.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        for (DBModel *model in array) {
            NSString *tableName = NSStringFromClass(model.class);
            NSMutableString *keyString = [NSMutableString string];
            NSMutableString *valueString = [NSMutableString string];
            NSMutableArray *insertValues = [NSMutableArray  array];
            for (int i = 0; i < model.columeNames.count; i++) {
                NSString *proname = [model.columeNames objectAtIndex:i];
                [keyString appendFormat:@"%@,", proname];
                [valueString appendString:@"?,"];
                id value = [(NSObject *)[model valueForKey:proname] toSQLString];
                if (!value) {
                    value = @"";
                }
                [insertValues addObject:value];
            }
            [keyString deleteCharactersInRange:NSMakeRange(keyString.length - 1, 1)];
            [valueString deleteCharactersInRange:NSMakeRange(valueString.length - 1, 1)];
            
            NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@(%@) VALUES (%@);", tableName, keyString, valueString];
           
            BOOL flag = [db executeUpdate:sql withArgumentsInArray:insertValues];
            model.pId = flag?[NSNumber numberWithLongLong:db.lastInsertRowId].intValue:0;
            NSLog(flag?@"插入成功":@"插入失败");
            if (!flag) {
                res = NO;
                *rollback = YES;
                return;
            }
        }
    }];
    return res;
}

+ (BOOL)saveObjects:(NSArray *)array completion:(void(^)(NSInteger index, NSInteger total))complete
{
   __block NSInteger tIndex=0;
   __block NSInteger tTotal=0;
    //判断是否是DBModel的子类
    for (DBModel *model in array) {
        if (![model isKindOfClass:[DBModel class]]) {
            return NO;
        }
    }
    
    __block BOOL res = YES;
    DBService *jkDB = [DBService shareInstance];
    // 如果要支持事务
    [jkDB.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        for (DBModel *model in array) {
            NSString *tableName = NSStringFromClass(model.class);
            NSMutableString *keyString = [NSMutableString string];
            NSMutableString *valueString = [NSMutableString string];
            NSMutableArray *insertValues = [NSMutableArray  array];
            for (int i = 0; i < model.columeNames.count; i++) {
                NSString *proname = [model.columeNames objectAtIndex:i];
                [keyString appendFormat:@"%@,", proname];
                [valueString appendString:@"?,"];
                id value = [(NSObject *)[model valueForKey:proname] toSQLString];
                if (!value) {
                    value = @"";
                }
                [insertValues addObject:value];
            }
            [keyString deleteCharactersInRange:NSMakeRange(keyString.length - 1, 1)];
            [valueString deleteCharactersInRange:NSMakeRange(valueString.length - 1, 1)];
            
            NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@(%@) VALUES (%@);", tableName, keyString, valueString];
            
            BOOL flag = [db executeUpdate:sql withArgumentsInArray:insertValues];
            model.pId = flag?[NSNumber numberWithLongLong:db.lastInsertRowId].intValue:0;
            //插入成功: falg 1
            if (flag != 0) {
                tIndex++;
            }
//            NSLog(flag?@"插入成功":@"插入失败");
            if (!flag) {
                res = NO;
                *rollback = YES;
                return;
            }
            tTotal=array.count;
           
        }
        
         complete(tIndex,tTotal);
    }];
    return res;
}


/** 更新单个对象 */
- (BOOL)update
{
   
    __block BOOL isAdd = NO;//是否已add to server
    NSString *primaryKey = [self.class primaryKey];
    id primaryValue = [self valueForKey:[self.class primaryKey]];
    NSString *where = [NSString stringWithFormat:@"WHERE %@='%@'", primaryKey, primaryValue];
    id model = [self.class queryFirstByCondition:where];
    NSArray *cols = [self.class getColumns];
    BOOL hasCol = NO;
    if (model) {
        NSString *selString = @"synFlag";
        for (NSString *col in cols) {
            if ([col isEqualToString:selString])
                hasCol = YES;
        }
        if (hasCol) {
            SEL selector = NSSelectorFromString(selString);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            id value = [model performSelector:selector];
#pragma clang diagnostic pop
            if ([value integerValue] == 1) {
                isAdd = NO;
            } else {
                isAdd = YES;
            }
        }
    }
    
    DBService *jkDB = [DBService shareInstance];
    __block BOOL res = NO;
    [jkDB.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *tableName = NSStringFromClass(self.class);
        id primaryValue = [self valueForKey:[self.class primaryKey]];
        if (!primaryValue || primaryValue <= 0) {
            return ;
        }
        
        NSMutableString *keyString = [NSMutableString string];
        NSMutableArray *updateValues = [NSMutableArray  array];
        for (int i = 0; i < self.columeNames.count; i++) {
            NSString *proname = [self.columeNames objectAtIndex:i];
            if ([proname isEqualToString:[self.class primaryKey]]) {
                continue;
            }
            [keyString appendFormat:@" %@=?,", proname];
            id value = [[(NSObject*)self valueForKey:proname] toSQLString];
            if (!value) {
                value = @"";
            }
            
#pragma mark - 可能有bug
//            if ([proname isEqualToString:@"synFlag"] && !isAdd) {
//
//            } else if ([proname isEqualToString:@"synFlag"] && isAdd) {
//                value = @"2";
//            }
            [updateValues addObject:value];
        }
        
        //删除最后那个逗号
        [keyString deleteCharactersInRange:NSMakeRange(keyString.length - 1, 1)];
        NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET %@ WHERE %@ = ?", tableName, keyString, [self.class primaryKey]];
        [updateValues addObject:primaryValue];
        res = [db executeUpdate:sql withArgumentsInArray:updateValues];
        NSLog(res?@"更新成功":@"更新失败");
    }];
    return res;
}

/** 批量更新用户对象*/
+ (BOOL)updateObjects:(NSArray *)array
{
   
    for (DBModel *model in array) {
        if (![model isKindOfClass:[DBModel class]]) {
            return NO;
        }
    }
    __block BOOL res = YES;
    DBService *jkDB = [DBService shareInstance];
    // 如果要支持事务
    [jkDB.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        for (DBModel *model in array) {
            NSString *tableName = NSStringFromClass(model.class);
            id primaryValue = [model valueForKey:[self.class primaryKey]];
            if (!primaryValue || primaryValue <= 0) {
                res = NO;
                *rollback = YES;
                return;
            }
            
            NSMutableString *keyString = [NSMutableString string];
            NSMutableArray *updateValues = [NSMutableArray  array];
            for (int i = 0; i < model.columeNames.count; i++) {
                NSString *proname = [model.columeNames objectAtIndex:i];
                if ([proname isEqualToString:[self.class primaryKey]]) {
                    continue;
                }
                [keyString appendFormat:@" %@=?,", proname];
                id value = [(NSObject *)[model valueForKey:proname] toSQLString];
                if (!value) {
                    value = @"";
                }
                [updateValues addObject:value];
            }
            
            //删除最后那个逗号
            [keyString deleteCharactersInRange:NSMakeRange(keyString.length - 1, 1)];
            NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET %@ WHERE %@=?;", tableName, keyString, [self.class primaryKey]];
            [updateValues addObject:primaryValue];
            BOOL flag = [db executeUpdate:sql withArgumentsInArray:updateValues];
            NSLog(flag?@"更新成功":@"更新失败");
            if (!flag) {
                res = NO;
                *rollback = YES;
                return;
            }
        }
    }];
    
    return res;
}

/** 删除单个对象 */
- (BOOL)deleteObject
{

    DBService *jkDB = [DBService shareInstance];
    __block BOOL res = NO;
    [jkDB.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *tableName = NSStringFromClass(self.class);
        id primaryValue = [self valueForKey:[self.class primaryKey]];
        if (!primaryValue || primaryValue <= 0) {
            return ;
        }
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@ = ?",tableName,[self.class primaryKey]];
        res = [db executeUpdate:sql withArgumentsInArray:@[primaryValue]];
         NSLog(res?@"删除成功":@"删除失败");
    }];
    return res;
}

/** 批量删除用户对象 */
+ (BOOL)deleteObjects:(NSArray *)array
{
    
    for (DBModel *model in array) {
        if (![model isKindOfClass:[DBModel class]]) {
            return NO;
        }
    }
    
    __block BOOL res = YES;
    DBService *jkDB = [DBService shareInstance];
    // 如果要支持事务
    [jkDB.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        for (DBModel *model in array) {
            NSString *tableName = NSStringFromClass(model.class);
            id primaryValue = [model valueForKey:[self.class primaryKey]];
            if (!primaryValue || primaryValue <= 0) {
                return ;
            }
            
            NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@ = ?",tableName,[self.class primaryKey]];
            BOOL flag = [db executeUpdate:sql withArgumentsInArray:@[primaryValue]];
             NSLog(flag?@"删除成功":@"删除失败");
            if (!flag) {
                res = NO;
                *rollback = YES;
                return;
            }
        }
    }];
    return res;
}

/** 通过条件删除数据 */
+ (BOOL)deleteObjectsByCriteria:(NSString *)criteria
{
   
    DBService *jkDB = [DBService shareInstance];
    __block BOOL res = NO;
    [jkDB.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *tableName = NSStringFromClass(self.class);
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ %@ ",tableName,criteria];
        res = [db executeUpdate:sql];
        NSLog(res?@"删除成功":@"删除失败");
    }];
    return res;
}

/** 清空表 */
+ (BOOL)clearTable
{
    DBService *jkDB = [DBService shareInstance];
    __block BOOL res = NO;
    [jkDB.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *tableName = NSStringFromClass(self.class);
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@",tableName];
        res = [db executeUpdate:sql];
        NSLog(res?@"清空成功":@"清空失败");
    }];
    return res;
}

/** 查询全部数据 */
+ (NSArray *)queryAll
{
    DBService *jkDB = [DBService shareInstance];
    __block NSMutableArray *array = [NSMutableArray array];
    [jkDB.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *tableName = NSStringFromClass(self.class);
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@",tableName];
        FMResultSet *resultSet = [db executeQuery:sql];
        NSArray* columns = [[resultSet columnNameToIndexMap] allKeys];
        NSDictionary* vars = [self varMap];
        NSDictionary* classMap = kObjectCTypeMap;
        NSDictionary* lowVarMap = [self lowercaseVarMap];
        
        while ([resultSet next]) {
            id obj = [[self alloc] init];
            for (NSString* var in columns) {
                NSString* varName = lowVarMap[var];
                NSString *key = [vars objectForKey:varName];
                NSArray *typeArray = [classMap objectForKey:key];
                NSString* className = [typeArray objectAtIndex:0];
                
                Class cls = NSClassFromString(className);
                id value = [cls objectFromSQLString:[resultSet stringForColumn:var]];
                if (cls && value) {
                    [obj setValue:value forKey:varName];
                }
            }
            [array addObject:obj];
            FMDBRelease(obj);
        }
        [resultSet close];
    }];
    
    return array;
}

/** 查找某条数据 */
+ (instancetype)queryFirstByCondition:(NSString *)condition
{
    NSArray *results = [self.class queryByCondition:condition];
    if (results.count < 1) {
        return nil;
    }
    
    return [results firstObject];
}

+ (instancetype)queryByPId:(int)inPid
{
    NSString *condition = [NSString stringWithFormat:@"WHERE %@=%d",[self.class primaryKey],inPid];
    return [self queryFirstByCondition:condition];
}

/** 通过条件查找数据 */
+ (NSArray *)queryByCondition:(NSString *)condition
{
    DBService *jkDB = [DBService shareInstance];
    __block NSMutableArray *array = [NSMutableArray array];
    [jkDB.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *tableName = NSStringFromClass(self.class);
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ %@",tableName, condition];
        FMResultSet *resultSet = [db executeQuery:sql];
        NSArray* columns = [[resultSet columnNameToIndexMap] allKeys];
        NSDictionary* vars = [self varMap];
        NSDictionary* classMap = kObjectCTypeMap;
        NSDictionary* lowVarMap = [self lowercaseVarMap];
        
        while ([resultSet next]) {
            id obj = [[self alloc] init];
            for (NSString* var in columns) {
                NSString* varName = lowVarMap[var];
                NSString *key = [vars objectForKey:varName];
                NSArray *typeArray = [classMap objectForKey:key];
                NSString* className = [typeArray objectAtIndex:0];
                
                Class cls = NSClassFromString(className);
                id value = [cls objectFromSQLString:[resultSet stringForColumn:var]];
                if (cls && value) {
                    [obj setValue:value forKey:varName];
                }
            }
            [array addObject:obj];
            FMDBRelease(obj);
        }
        [resultSet close];
    }];
    
    return array;
}

+ (NSArray *)queryBySql:(NSString *)sqlString {

    DBService *jkDB = [DBService shareInstance];
    __block NSMutableArray *array = [NSMutableArray array];
    [jkDB.dbQueue inDatabase:^(FMDatabase *db) {
//        NSString *tableName = NSStringFromClass(self.class);
        NSString *sql = [NSString stringWithFormat:@"%@", sqlString];
        FMResultSet *resultSet = [db executeQuery:sql];
        NSArray* columns = [[resultSet columnNameToIndexMap] allKeys];
        NSDictionary* vars = [self varMap];
        NSDictionary* classMap = kObjectCTypeMap;
        NSDictionary* lowVarMap = [self lowercaseVarMap];
        
        while ([resultSet next]) {
            id obj = [[self alloc] init];
            for (NSString* var in columns) {
                NSString* varName = lowVarMap[var];
                NSString *key = [vars objectForKey:varName];
                NSArray *typeArray = [classMap objectForKey:key];
                NSString* className = [typeArray objectAtIndex:0];
                
                Class cls = NSClassFromString(className);
                id value = [cls objectFromSQLString:[resultSet stringForColumn:var]];
                if (cls && value) {
                    [obj setValue:value forKey:varName];
                }
            }
            [array addObject:obj];
            FMDBRelease(obj);
        }
        [resultSet close];
    }];
    
    return array;
}

+ (BOOL)excuteSql:(NSString *)sqlString {
    DBService *jkDB = [DBService shareInstance];
    __block BOOL res = NO;
    [jkDB.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sql = sqlString;
        res = [db executeUpdate:sql];
        NSLog(res?@"插入成功":@"插入失败");
    }];
    return res;
}

#pragma mark - 生成model的schema
+ (NSString *)getTableSchema
{
    NSMutableString* pars = [NSMutableString string];
    NSDictionary *dict = [self.class getAllProperties];
    
    NSMutableArray *proNames = [dict objectForKey:@"name"];
    NSMutableArray *proTypes = [dict objectForKey:@"type"];
    
    NSString *defValue = @"";
    for (int i=0; i< proNames.count; i++) {
        NSString *proName = [proNames objectAtIndex:i];
        NSString *proType = [proTypes objectAtIndex:i];
        if ([proType hasPrefix:@"TEXT"])
            defValue = @"";
        else if ([proType hasPrefix:@"INTEGER"])
            defValue = @" DEFAULT 0";
        else if ([proType hasPrefix:@"REAL"])
            defValue = @" DEFAULT 0.0";

        if ([proName isEqualToString:[self.class primaryKey]])
            [pars appendFormat:@"%@ %@%@ primary key",proName, proType, defValue];
        else
            [pars appendFormat:@"%@ %@%@",proName, proType, defValue];
        if(i+1 != proNames.count)
        {
            [pars appendString:@","];
        }
    }
    
    NSString *tableName = NSStringFromClass(self.class);
    NSString *schema = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(%@);",tableName,pars];
    NSLog(@"schema:%@", schema);
    return schema;
}

- (NSString *)description
{
    NSString *result = @"";
    NSDictionary *dict = [self.class getAllProperties];
    NSMutableArray *proNames = [dict objectForKey:@"name"];
    for (int i = 0; i < proNames.count; i++) {
        NSString *proName = [proNames objectAtIndex:i];
        id  proValue = [[(NSObject*)self valueForKey:proName] toSQLString];
        result = [result stringByAppendingFormat:@"%@:%@\n",proName,proValue];
    }
    return result;
}

#pragma mark - 子类可重写实现方法
+ (NSString* )primaryKey {
    return primaryId;
}

static NSMutableDictionary *varCache;
+ (NSDictionary *)varMap {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        varCache = [NSMutableDictionary dictionary];
    });
    //是否存在Cache
    NSString* className = NSStringFromClass([self class]);
    if (varCache[className]) {
        return varCache[className];
    }
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    unsigned int count = 0;
    Class clazz = [self class];
    do {
        Ivar * ivars = class_copyIvarList(clazz, &count);
        if (ivars) {
            for(int i = 0; i < count; i++) {
                Ivar ivar = ivars[i];
                const char *type = ivar_getTypeEncoding(ivar);
                NSString *typeStr =  [NSString stringWithCString:type encoding:NSUTF8StringEncoding];
                NSString* var = [NSString stringWithUTF8String:ivar_getName(ivar)];
                if ([var hasPrefix:@"_"]) {
                    var = [var substringFromIndex:1];
                }
                
                if ([typeStr hasPrefix:@"@"]) {
                    typeStr = [typeStr substringWithRange:NSMakeRange(2, typeStr.length-3)];
                } else if ([typeStr hasPrefix:@"\""]) {
                    typeStr = [typeStr substringWithRange:NSMakeRange(1, typeStr.length-2)];
                }
                dic[var] = typeStr;
            }
            free(ivars);
        }
        clazz = class_getSuperclass(clazz);
    } while(clazz && strcmp(object_getClassName(clazz), "NSObject"));
    varCache[className] = dic;
    return dic;
}

static NSMutableDictionary *lowercaseVarMapCache;
+ (NSDictionary *)lowercaseVarMap {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lowercaseVarMapCache = [NSMutableDictionary dictionary];
    });
    //是否存在Cache
    NSString* className = NSStringFromClass([self class]);
    if (lowercaseVarMapCache[className]) {
        return lowercaseVarMapCache[className];
    }
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    NSDictionary* varMap = [self varMap];
    for (NSString* var in varMap) {
        dic[[var lowercaseString]] = var;
    }
    lowercaseVarMapCache[className] = dic;
    return dic;
}
@end
