//
//  NSDate+LXExtension.h
//  百思不得姐
//
//  Created by LiuXing on 16/9/29.
//  Copyright © 2016年 kmznst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LXExtension)
/** 比较 from 和 self 的差值*/
- (NSDateComponents *)deltaFrom:(NSDate *)from;

@end
