
#import <Foundation/Foundation.h>

/** SQLite五种数据类型 */
#define SQLTEXT     @"TEXT"
#define SQLINTEGER  @"INTEGER"
#define SQLREAL     @"REAL"
#define SQLBLOB     @"BLOB"
#define SQLNULL     @"NULL"

#define TYPEMAP(__key, __objcType, __sqlType) \
__key:@[__objcType, __sqlType]
#define kObjectCTypeMap \
@{\
TYPEMAP(@"c",               @"NSNumber",        @"INTEGER"),\
TYPEMAP(@"C",               @"NSNumber",        @"INTEGER"),\
TYPEMAP(@"s",               @"NSNumber",        @"INTEGER"),\
TYPEMAP(@"S",               @"NSNumber",        @"INTEGER"),\
TYPEMAP(@"i",               @"NSNumber",        @"INTEGER"),\
TYPEMAP(@"I",               @"NSNumber",        @"INTEGER"),\
TYPEMAP(@"q",               @"NSNumber",        @"INTEGER"),\
TYPEMAP(@"B",               @"NSNumber",        @"INTEGER"),\
TYPEMAP(@"f",               @"NSNumber",        @"REAL"),\
TYPEMAP(@"d",               @"NSNumber",        @"REAL"),\
TYPEMAP(@"NSString",        @"NSString",        @"TEXT"),\
TYPEMAP(@"NSMutableString", @"NSMutableString", @"TEXT"),\
TYPEMAP(@"NSDate",          @"NSDate",          @"REAL"),\
TYPEMAP(@"NSNumber",        @"NSNumber",        @"REAL"),\
TYPEMAP(@"NSDictionary",    @"NSDictionary",    @"TEXT"),\
}

#define primaryId   @"pId"

@interface DBModel : NSObject

+ (NSString *)genUUID;

/** 主键 id */
@property (nonatomic, assign)int pId;
/** 列名 */
@property (retain, readonly, nonatomic)NSMutableArray *columeNames;
/** 列类型 */
@property (retain, readonly, nonatomic)NSMutableArray  *columeTypes;

/** 主键 */
+ (NSString* )primaryKey;

/** 
 *  获取该类的所有属性
 */
+ (NSDictionary *)getPropertys;

/** 获取所有属性，包括主键 */
+ (NSDictionary *)getAllProperties;

/** 数据库中是否存在表 */
+ (BOOL)isExistInTable;

/** 表中的字段*/
+ (NSArray *)getColumns;

/** 保存或更新
 * 如果不存在主键，保存，
 * 有主键，则更新
 */
- (BOOL)saveOrUpdate;
/** 保存单个数据 */
- (BOOL)save;
/** 更新单个数据 */
- (BOOL)update;
/** 删除单个数据 */
- (BOOL)deleteObject;

/** 批量更新数据*/
+ (BOOL)updateObjects:(NSArray *)array;
/** 批量保存数据 */
+ (BOOL)saveObjects:(NSArray *)array;
/** 批量删除数据 */
+ (BOOL)deleteObjects:(NSArray *)array;
/** 通过条件删除数据 */
+ (BOOL)deleteObjectsByCriteria:(NSString *)criteria;
/** 清空表 */
+ (BOOL)clearTable;


/** 查询全部数据 */
+ (NSArray *)queryAll;

/** 通过主键查询 */
+ (instancetype)queryByPId:(int)inPid;

/** 查找某条数据 */
+ (instancetype)queryFirstByCondition:(NSString *)condition;

/** 通过条件查找数据 
 * 这样可以进行分页查询 @" WHERE pId > 5 limit 10"
 */
+ (NSArray *)queryByCondition:(NSString *)condition;

/** 通过条件查找数据
 * 例：@"select * from web_note WHERE id = '1'"
 */
+ (NSArray *)queryBySql:(NSString *)sqlString;

/*
 * 执行数据库语句
 */
+ (BOOL)excuteSql:(NSString *)sqlString;

/**
 * 创建表
 * 如果已经创建，返回YES
 */
+ (BOOL)createTable;

/**
 * 类属性映射集合，属性名称->属性类型
 */
+ (NSDictionary *)varMap;

/**
 * 类属性映射集合，小写属性名称->属性名称
 */
+ (NSDictionary *)lowercaseVarMap;

+ (BOOL)saveObjects:(NSArray *)array completion:(void(^)(NSInteger index, NSInteger total))complete;

@end
