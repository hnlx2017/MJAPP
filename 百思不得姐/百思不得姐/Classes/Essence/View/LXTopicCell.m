//
//  LXTopicCell.m
//  百思不得姐
//
//  Created by LiuXing on 16/9/27.
//  Copyright © 2016年 kmznst. All rights reserved.
//

#import "LXTopicCell.h"
#import "LXTopic.h"
#import <UIImageView+WebCache.h>

/**
 *  Description
 */
@interface LXTopicCell ()
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *profile_imageView;
/** 名称 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 发贴时间 */
@property (weak, nonatomic) IBOutlet UILabel *createTimeLable;
/** ding */
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
/** cai */
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
/** 转发的数量 */
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
/** 评论的数量 */
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@end

@implementation LXTopicCell

- (void)awakeFromNib {
    
    UIImageView *bgImageview = [[UIImageView alloc]init];
    bgImageview.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgImageview;
}

- (void)setTopic:(LXTopic *)topic{
    _topic = topic;
    
    [self.profile_imageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = topic.name;
    self.createTimeLable.text = topic.create_time;
    
    NSDateFormatter *dfm = [[NSDateFormatter alloc]init];
    dfm.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    /** 发贴时间 */
    NSDate *create_time = [dfm dateFromString:topic.create_time];
    /** 当前时间 */
    NSDate *now = [NSDate date];
    /** 日历类 拿到当前日历对象*/

    LXLog(@"%@",topic.create_time);
    LXLog(@"%@",[now deltaFrom:create_time]);
    
    [self setupButtonTitle:self.dingButton count:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton count:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.shareButton count:topic.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentButton count:topic.comment placeholder:@"评论"];
    
    
}

- (void)testDate{
   
    
    
}

/** 设置按钮内容 */
- (void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder
{
  
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%0.1f万",count/10000.0];
    }else if(count > 0){
        placeholder = [NSString stringWithFormat:@"%zd",count];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
    
}

- (void)setFrame:(CGRect)frame{
   static CGFloat margin = 10;
    
    frame.origin.x = margin;
    frame.size.width -= 2 *frame.origin.x;
    frame.size.height -= margin;
    frame.origin.y += margin;
    [super setFrame:frame];
}

@end
