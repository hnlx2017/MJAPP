//
//  LXTopicCell.m
//  百思不得姐
//
//  Created by LiuXing on 16/9/27.
//  Copyright © 2016年 kmznst. All rights reserved.
//

#import "LXTopicCell.h"
#import "LXTopic.h"

@implementation LXTopicCell

- (void)awakeFromNib {
    
    UIImageView *bgImageview = [[UIImageView alloc]init];
    bgImageview.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgImageview;
}

- (void)setTopic:(LXTopic *)topic{
    _topic = topic;
    
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
