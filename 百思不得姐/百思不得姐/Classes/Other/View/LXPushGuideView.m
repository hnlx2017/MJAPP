//
//  LXPushGuideView.m
//  百思不得姐
//
//  Created by LiuXing on 16/9/22.
//  Copyright © 2016年 kmznst. All rights reserved.
//

#import "LXPushGuideView.h"

@implementation LXPushGuideView

+ (instancetype)guideView{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}
- (IBAction)close:(id)sender {
    
    [self removeFromSuperview];
    
}

+ (void)show{
    NSString *key = @"CFBundleShortVersionString";
    NSString *curVersion = [NSBundle mainBundle].infoDictionary[key];
    NSString *sanboxVersion = [[NSUserDefaults standardUserDefaults]objectForKey:key];
    
    if (![curVersion isEqualToString:sanboxVersion]) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        LXPushGuideView *guideV = [LXPushGuideView guideView];
        guideV.frame = window.bounds;
        [window addSubview:guideV];
        [[NSUserDefaults standardUserDefaults] setObject:curVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
@end
