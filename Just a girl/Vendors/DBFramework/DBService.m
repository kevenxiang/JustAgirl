
#import "DBService.h"

@interface DBService ()

@end

@implementation DBService

static DBService *_instance = nil;

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init] ;
    }) ;
    
    return _instance;
}

- (NSString *)dbPath {
    if (_dbPath == nil) {
        NSString *docsdir = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSFileManager *filemanage = [NSFileManager defaultManager];
        docsdir = [docsdir stringByAppendingPathComponent:@"DB"];
        BOOL isDir;
        BOOL exit =[filemanage fileExistsAtPath:docsdir isDirectory:&isDir];
        if (!exit || !isDir) {
            [filemanage createDirectoryAtPath:docsdir withIntermediateDirectories:YES attributes:nil error:nil];
        }
        NSString *dbpath = [docsdir stringByAppendingPathComponent:@"db.sqlite"];
        return dbpath;
    }
    return _dbPath;
}

- (void)setDbPathUpdate:(BOOL)dbPathUpdate {
    if (dbPathUpdate) {
        _dbQueue = nil;
    }
}

- (FMDatabaseQueue *)dbQueue
{
    if (_dbQueue == nil) {
        _dbQueue = [[FMDatabaseQueue alloc] initWithPath:[self dbPath]];
    }
    return _dbQueue;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [DBService shareInstance];
}

- (id)copyWithZone:(struct _NSZone *)zone
{
    return [DBService shareInstance];
}
@end
