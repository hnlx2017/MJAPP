//
//  LXRecommendTagCell.m
//  百思不得姐
//
//  Created by LiuXing on 16/9/21.
//  Copyright © 2016年 kmznst. All rights reserved.
//

#import "LXRecommendTagCell.h"
#import <UIImageView+WebCache.h>
#import "LXRecommendTag.h"
@interface LXRecommendTagCell()
@property (weak, nonatomic) IBOutlet UIImageView *image_listImageView;
@property (weak, nonatomic) IBOutlet UILabel *theme_nameLable;
@property (weak, nonatomic) IBOutlet UILabel *sub_numberLabel;

@end

@implementation LXRecommendTagCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setRecommendTag:(LXRecommendTag *)recommendTag{
    _recommendTag = recommendTag;
    self.theme_nameLable.text = recommendTag.theme_name;
    
    NSString *subNumber = nil;
    if (recommendTag.sub_number < 10000) {
        subNumber = [NSString stringWithFormat:@"%zd人订阅",recommendTag.sub_number];
    }else{
        subNumber = [NSString stringWithFormat:@"%0.1f万人订阅",recommendTag.sub_number / 10000.0];
    }
    self.sub_numberLabel.text = subNumber;
    [self.image_listImageView sd_setImageWithURL:[NSURL URLWithString:recommendTag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    
    
}

- (void)setFrame:(CGRect)frame{
    frame.origin.x = 5;
    frame.size.width -= frame.origin.x *2;
    frame.size.height -= 1;
    
    [super setFrame:frame];
}

@end
