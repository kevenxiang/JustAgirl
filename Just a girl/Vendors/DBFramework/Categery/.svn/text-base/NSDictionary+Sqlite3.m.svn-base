
#import "NSDictionary+Sqlite3.h"
#import "NSString_Sqlite3.h"
#import "JSONKit.h"

@implementation NSDictionary (Sqlite3)
- (NSString *) toSQLString {
    return [[self JSONString] toSQLString];
}

+ (id) objectFromSQLString:(NSString* )sql{
    if (!sql) return nil;
    return [sql objectFromJSONString];
}
@end
