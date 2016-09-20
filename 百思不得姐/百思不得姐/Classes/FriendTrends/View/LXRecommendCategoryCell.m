//
//  LXRecommendCategoryCell.m
//  百思不得姐
//
//  Created by LiuXing on 16/9/20.
//  Copyright © 2016年 kmznst. All rights reserved.
//

#import "LXRecommendCategoryCell.h"
#import "LXRecommendCategory.h"
@interface LXRecommendCategoryCell()
@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;

@end

@implementation LXRecommendCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = LXRGBColor(244, 244, 244);
    self.selectedIndicator.backgroundColor = LXRGBColor(219, 21, 26);
    //self.textLabel.textColor = LXRGBColor(78, 78, 78);
//    self.textLabel.highlightedTextColor = LXRGBColor(219, 21, 26);
    UIView *bg = [[UIView alloc]init];
    bg.backgroundColor = [UIColor clearColor];
    self.selectedBackgroundView = bg;
}

- (void)setCategory:(LXRecommendCategory *)category{
    _category = category;
    self.textLabel.text = category.name;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectedIndicator.hidden = !selected;
    self.textLabel.textColor = selected? self.selectedIndicator.backgroundColor: LXRGBColor(78, 78, 78);
    
}


-(void)layoutSubviews{
    [super layoutSubviews];
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height -2*self.textLabel.y;
}

@end
