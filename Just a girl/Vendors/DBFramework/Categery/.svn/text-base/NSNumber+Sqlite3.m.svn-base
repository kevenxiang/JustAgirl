
#import "NSNumber+Sqlite3.h"

@implementation NSNumber (Sqlite3)

- (NSString *) toSQLString {
    return [self stringValue];
}

+ (id) objectFromSQLString:(NSString* )sql {
    NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
    return [fmt numberFromString:sql];
}
@end
