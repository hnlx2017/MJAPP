//
//  LXRecommendCategory.m
//  百思不得姐
//
//  Created by LiuXing on 16/9/20.
//  Copyright © 2016年 kmznst. All rights reserved.
//

#import "LXRecommendCategory.h"

@implementation LXRecommendCategory
/** <#注释#> */
- (NSMutableArray *)users{
    if (!_users) {
        _users = [NSMutableArray array];
    }
    return _users;
}


@end
