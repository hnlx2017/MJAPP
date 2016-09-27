//
//  LXTopic.h
//  百思不得姐
//
//  Created by LiuXing on 16/9/23.
//  Copyright © 2016年 kmznst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXTopic : NSObject
/** 名称 */
@property (nonatomic,copy) NSString *name;
/** 帖子内容 */
@property (nonatomic,copy) NSString *text;
/** 发贴时间 */
@property (nonatomic,copy) NSString *create_time;
/** 用户头像 */
@property (nonatomic,copy) NSString *profile_image;
/** cai */
@property (nonatomic,assign) NSInteger cai;
/** ding */
@property (nonatomic,assign) NSInteger ding;
/** 转发的数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论的数量 */
@property (nonatomic, assign) NSInteger comment;


@end
