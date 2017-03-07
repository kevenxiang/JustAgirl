//
//  NSString+AdaptWithContent.m
//  KouDaiDuoBao
//
//  Created by 曾垂东 on 16/4/11.
//  Copyright © 2016年 CitiesTechnology. All rights reserved.
//

#import "NSString+AdaptWithContent.h"

@implementation NSString (AdaptWithContent)
+(CGFloat)adaptiveWithText:(NSString *)text{
    //指定自适应过程中以多打的文字作为参考
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:17]};
    //参数1代表文字自适应的范围，参数2代表文字自适应的方式（前三种），参数3代表文字在自适应过程中以多大的字体作为依据
    return [text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, 10000000) options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size.height;
}

@end
