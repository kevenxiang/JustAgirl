
#import <Foundation/Foundation.h>

@interface NSString (Sqlite3)
- (NSString *) toSQLString;
+ (id) objectFromSQLString:(NSString* )sql;
@end
