
#import <Foundation/Foundation.h>

@interface NSObject (Sqlite3)
- (NSString *) toSQLString;
+ (id) objectFromSQLString:(NSString* )sql;
@end
