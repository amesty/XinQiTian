//
//  HomeTableViewCell.h
//  心期天
//
//  Created by qianfeng on 15/10/23.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ZJBlock)(NSString *);
@interface HomeTableViewCell : UITableViewCell
- (void)refreshUI:(NSArray *)arr;
@property (nonatomic,strong)ZJBlock block;
@end
