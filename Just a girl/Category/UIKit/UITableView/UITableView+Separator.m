//
//  UITableView+Separator.m
//  APP_iOS
//
//  Created by 林小果 on 15/8/28.
//  Copyright (c) 2015年 Li. All rights reserved.
//

#import "UITableView+Separator.h"

@implementation UITableView (Separator)

- (void) SetFooterNoSeparator {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    [self setTableFooterView:view];
}

- (void) setSeparatorFullWidth {
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsZero];
    }
}

//copy 以下代码到UIViewController，实现系统UITableView分割线fullWidth
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
@end
