//
//  UIBarButtonItem+LXExtension.h
//  百思不得姐
//
//  Created by LiuXing on 16/9/19.
//  Copyright © 2016年 kmznst. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (LXExtension)
+ (instancetype)itemWithimage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
@end
