//
//  ContentCollectionViewCell.m
//  Just a girl
//
//  Created by xiang on 16/5/6.
//  Copyright © 2016年 xiang. All rights reserved.
//

#import "ContentCollectionViewCell.h"

CGFloat featuredHeight = 213.0;
CGFloat standardHegiht = 100.0;
CGFloat minAlpha = 0.1;
CGFloat maxAlpha = 0.45;

@implementation ContentCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
    
    CGFloat delta = 1 - (featuredHeight - CGRectGetHeight(self.frame)) / (featuredHeight - standardHegiht);
    CGFloat alpha = maxAlpha - (delta * (maxAlpha - minAlpha));
    _overLayView.alpha = alpha;
}

@end

