//
//  LXRecommendCategory.h
//  百思不得姐
//
//  Created by LiuXing on 16/9/20.
//  Copyright © 2016年 kmznst. All rights reserved.
// 推荐关注左边的数据模型

#import <Foundation/Foundation.h>

@interface LXRecommendCategory : NSObject
/** id */
@property (nonatomic,assign) NSInteger id;
/** 总数 */
@property (nonatomic,assign) NSInteger total;
/** 名字 */
@property (nonatomic,copy) NSString *name;


/**
 *  每个用户保存它右边的数据
 */
@property (nonatomic,strong) NSMutableArray *users;
@end
