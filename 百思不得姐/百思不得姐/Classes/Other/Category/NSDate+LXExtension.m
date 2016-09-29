//
//  NSDate+LXExtension.m
//  百思不得姐
//
//  Created by LiuXing on 16/9/29.
//  Copyright © 2016年 kmznst. All rights reserved.
//

#import "NSDate+LXExtension.h"

@implementation NSDate (LXExtension)
- (NSDateComponents *)deltaFrom:(NSDate *)from{
  
    /** 日历类 拿到当前日历对象*/
    NSCalendar *calendar  = [NSCalendar currentCalendar];
    NSCalendarUnit calendarUnit = NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:calendarUnit fromDate:from toDate:self options:0];
}
@end
