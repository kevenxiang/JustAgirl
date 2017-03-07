
#import "NSDate+Sqlite3.h"

@implementation NSDate (Sqlite3)

- (NSString *) toSQLString {
    return [NSString stringWithFormat:@"%f", [self timeIntervalSince1970]];
}

+ (id) objectFromSQLString:(NSString* )sql{
    return [NSDate dateWithTimeIntervalSince1970:[sql doubleValue]];
}
@end
