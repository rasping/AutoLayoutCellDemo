//
//  ViewController.m
//  AutoLayoutCellDemo
//
//  Created by siping ruan on 16/10/9.
//  Copyright © 2016年 Rasping. All rights reserved.
//

#import "ViewController.h"
#import "ChatCell.h"
#import "ChatModel.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *textFieldItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sendItem;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
- (IBAction)sendBtnClicked:(UIButton *)btn;
/**
 *  数据源
 */
@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation ViewController

#pragma mark - Setter/Getter

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
        NSString *time = [formatter stringFromDate:[NSDate date]];
        ChatModel *model = [ChatModel modelWithIcon:nil time:time message:@"晚上吃什么？" type:ChatTypeOther];
        [_dataArray addObject:model];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
}

#pragma mark - Private

- (void)setupUI
{
    self.textFieldItem.width = self.toolbar.bounds.size.width - self.sendItem.width;
    UIView *view = self.sendItem.customView;
    view.clipsToBounds = YES;
    view.layer.cornerRadius = 5;
    
    self.textField.returnKeyType = UIReturnKeySend;
    self.textField.enablesReturnKeyAutomatically = YES;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 90;
    [self.tableView layoutIfNeeded];
    if (self.tableView.contentSize.height <= [UIScreen mainScreen].bounds.size.height - 320) {
        CGRect frame = self.tableView.frame;
        frame.size.height = self.tableView.contentSize.height;
        self.tableView.frame = frame;
        [self.tableView layoutIfNeeded];
    }
}

- (void)textFieldTextDidChange:(NSNotification *)notify
{
    UITextField *textField = notify.object;
    self.sendBtn.enabled = textField.text.length ? YES : NO;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatModel *model = self.dataArray[indexPath.row];
    ChatCell *cell = [ChatCell cellWithTableView:tableView chatModel:model];
    return cell;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self sendBtnClicked:self.sendBtn];
    return YES;
}

#pragma mark - Action

- (IBAction)sendBtnClicked:(UIButton *)btn
{
    ChatModel *selfModel       = [ChatModel modelWithIcon:nil time:nil message:self.textField.text type:ChatTypeSelf];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSString *time             = [formatter stringFromDate:[NSDate date]];
    ChatModel *otherModel      = [ChatModel modelWithIcon:nil time:time message:@"晚上吃什么？" type:ChatTypeOther];
    self.textField.text        = nil;
    [_dataArray addObject:selfModel];
    [_dataArray addObject:otherModel];
    
    [self.tableView beginUpdates];
    [self.tableView reloadData];
    [self.tableView beginUpdates];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataArray.count inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

@end
