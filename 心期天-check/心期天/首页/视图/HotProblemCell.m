//
//  HotProblemCell.m
//  心期天
//
//  Created by qianfeng on 15/10/23.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "HotProblemCell.h"

@interface HotProblemCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@end

@implementation HotProblemCell
-(void)refreshUI:(HotProblemModel *)mode{
    [LJHttpManager setImageView:self.iconImageView withUrl:mode.photo];
    self.titleLabel.text = mode.title;
    self.descLabel.text = mode.content;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
