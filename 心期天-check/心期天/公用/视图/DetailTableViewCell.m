//
//  DetailTableViewCell.m
//  心期天
//
//  Created by qianfeng on 15/10/23.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "DetailTableViewCell.h"

@interface DetailTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userTyoe;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation DetailTableViewCell
-(void)refreshUI:(DetailModel *)mode{
    self.nameLabel.text = mode.name;
    self.contentLabel.text = mode.content;
    [LJHttpManager setImageView:self.photoImageView withUrl:mode.photo];
    if ([mode.replyusertype integerValue] == 2) {
        self.userTyoe.hidden = NO;
    } else {
        self.userTyoe.hidden = YES;
    }
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
