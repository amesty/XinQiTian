//
//  InfoViewController.h
//  心期天
//
//  Created by qianfeng on 15/10/31.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^blockType)(void);

@interface InfoViewController : UIViewController
@property (nonatomic,strong)blockType block;
@end
