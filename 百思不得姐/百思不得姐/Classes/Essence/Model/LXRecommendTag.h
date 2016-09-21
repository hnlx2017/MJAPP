//
//  LXRecommendTag.h
//  百思不得姐
//
//  Created by LiuXing on 16/9/21.
//  Copyright © 2016年 kmznst. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LXRecommendTag : NSObject
/** 头像 */
@property (nonatomic,copy) NSString *image_list;
/** 名称 */
@property (nonatomic,copy) NSString *theme_name;
/** 订阅数 */
@property (nonatomic,assign) NSInteger sub_number;
@end
