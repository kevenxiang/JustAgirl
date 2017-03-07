
#import "NSString_Sqlite3.h"

@implementation NSString (Sqlite3)
#warning @"'"--@"''"
- (NSString *) toSQLString {
//    return [NSString stringWithFormat:@"%@", [self stringByReplacingOccurrencesOfString:@"'" withString:@"''"]];
    return [NSString stringWithFormat:@"%@", [self stringByReplacingOccurrencesOfString:@"'" withString:@"'"]];
}

+ (id) objectFromSQLString:(NSString* )sql{
    return sql;
}
@end
