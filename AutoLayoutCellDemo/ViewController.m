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
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewBottom;
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

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Private

//初始化UI
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
}

//textField文字改变通知
- (void)textFieldTextDidChange:(NSNotification *)notify
{
    UITextField *textField = notify.object;
    self.sendBtn.enabled = textField.text.length ? YES : NO;
}

//插入一条消息
- (void)insertMessage:(ChatModel *)model
{
    //将新的消息插入到最后
    [self.dataArray addObject:model];
    NSIndexPath *index = [NSIndexPath indexPathForRow:(self.dataArray.count - 1) inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationBottom];
    
    //让tableView滚动到最低部
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:(self.dataArray.count - 1) inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatModel *model = self.dataArray[indexPath.row];
    ChatCell *cell = nil;
    if (model.type == ChatTypeOther) {
        cell = [ChatCell cellWithTableView:tableView chatCellType:ChatCellTypeOther];
    }else if (model.type == ChatTypeSelf) {
        cell = [ChatCell cellWithTableView:tableView chatCellType:ChatCellTypeSelf];
    }
    cell.model = model;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"+++++");
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.textField.isEditing) {
        [self.view endEditing:YES];
    }
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
    [self insertMessage:selfModel];
    [self performSelector:@selector(insertMessage:) withObject:otherModel afterDelay:0.3];
}

@end
