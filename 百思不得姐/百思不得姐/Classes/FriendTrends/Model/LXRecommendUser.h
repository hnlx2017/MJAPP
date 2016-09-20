//
//  LXRecommendUser.h
//  百思不得姐
//
//  Created by LiuXing on 16/9/20.
//  Copyright © 2016年 kmznst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXRecommendUser : NSObject
/**
 *  header : http://wimg.spriteapp.cn/profile/large/2015/09/30/560b557be210a_mini.jpg,
	uid : 9017486,
	is_vip : 0,
	is_follow : 0,
	introduction : ,
	fans_count : 7719,
	gender : 2,
	tiezi_count : 156,
	screen_name : 孙逊 等1227人
 */
/** 头像 */
@property (nonatomic,copy) NSString *header;
/** 粉丝数 */
@property (nonatomic,assign) NSInteger fans_count;
/** 昵称 */
@property (nonatomic,copy) NSString *screen_name;

@end
