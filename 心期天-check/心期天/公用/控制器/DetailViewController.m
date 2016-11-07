//
//  ProblemViewController.m
//  心期天
//
//  Created by qianfeng on 15/10/23.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailModel.h"
#import "DetailTableViewCell.h"
#import "ContentModel.h"
#import "ContentTableViewCell.h"

@interface DetailViewController ()
<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *contentTextField;
@property (nonatomic,strong)ContentModel *contentMode;
@property (nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation DetailViewController
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
    }
    return _dataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tabBarController.tabBar.hidden = YES;
    
    self.tableView.estimatedRowHeight = 90;
    [self createKeyBoard];
    [self requestData];
}
#pragma mark-网络数据相关
- (void)requestData{
    [LJHttpManager get:KDETAIL_URL parameters:@{@"woliaoid":self.userId} complement:^(id responseObject, NSError *error) {
        if (error) {
            NSLog(@"error = %@",error);
        } else {
            self.contentMode = [[ContentModel alloc] initWithDictionary:responseObject error:nil];
            //NSLog(@"message = %@",self.contentMode.message);
            self.dataArr = self.contentMode.list;
            [self.dataArr sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                    DetailModel *mode1 = (DetailModel *)obj1;
                    DetailModel *mode2 = (DetailModel *)obj2;
                    if ([mode1.userId integerValue] < [mode2.userId integerValue]) {
                        return NSOrderedAscending;
                    } else if ([mode1.userId integerValue] > [mode2.userId integerValue]){
                        return NSOrderedDescending;
                    } else {
                        return NSOrderedSame;
                    }
            }];
            [self.tableView reloadData];
        }
    }];
}
#pragma mark-UITableView代理方法
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return @"精彩评论";
    }
    return nil;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    } else {
        return self.dataArr.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        ContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContentCell"];
        [cell refreshUI:self.contentMode];
        return cell;
    } else {
        DetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell"];
        [cell refreshUI:self.dataArr[indexPath.row]];
        return cell;
    }
}
#pragma mark-评论
-(void)createKeyBoard{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardUp:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardDown:) name:UIKeyboardWillHideNotification object:nil];
}
-(void)keyBoardUp:(NSNotification *)noti{
    CGRect keyboardShow = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat height = keyboardShow.size.height;
    CGRect rect = self.view.frame;
    rect.origin.y = 0 - height;
    self.view.frame = rect;
}
-(void)keyBoardDown:(NSNotification *)noti{
    CGRect rect = self.view.frame;
    rect.origin.y = 0;
    self.view.frame = rect;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    //[LJHttpManager test];
    [self.view endEditing:YES];
    return YES;
}
- (IBAction)commentAction:(id)sender {
    if ([[LJHttpManager userNum] length] != 0) {
        [LJHttpManager get:KCOMMENT_URL parameters:@{@"content":self.contentTextField.text,@"userid":[LJHttpManager userNum],@"woliaoId":self.userId} complement:^(id responseObject, NSError *error) {
            if (error) {
                NSLog(@"error = %@",error);
            } else {
                //if ([responseObject[@"msg"] isEqualToString:@"缺少userid参数"]) {
                
                //}
                [self requestData];
            }
        }];

    } else {
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请登录后再操作" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterView show];
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}




@end
