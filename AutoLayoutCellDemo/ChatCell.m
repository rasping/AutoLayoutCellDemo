//
//  ChatCell.m
//  AutoLayoutCellDemo
//
//  Created by siping ruan on 16/10/9.
//  Copyright © 2016年 Rasping. All rights reserved.
//

#import "ChatCell.h"
#import "ChatModel.h"

@interface ChatCell ()

@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *message;

@end

@implementation ChatCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView chatCellType:(ChatCellType)type
{
    static NSString *reuseIdentifier;
    NSInteger index = 0;
    if (type == ChatCellTypeOther) {
        reuseIdentifier = @"ChatCellTypeOther";
    }else if (type == ChatCellTypeSelf) {
        reuseIdentifier = @"ChatCellTypeSelf";
        index= 1;
    }
    ChatCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ChatCell" owner:self options:0][index];
        cell.backgroundColor = [UIColor clearColor];
    }
    return cell;
}

- (void)setModel:(ChatModel *)model
{
    _model = model;
    
    if (model.type == ChatTypeOther) {
        self.time.text    = model.time;
        self.message.text = model.message;
    }
}

@end

@interface ChatCellSelf ()
@property (weak, nonatomic) IBOutlet UILabel *timeSelf;
@property (weak, nonatomic) IBOutlet UIImageView *iconSelf;
@property (weak, nonatomic) IBOutlet UILabel *messageSelf;

@end

@implementation ChatCellSelf

- (void)setModel:(ChatModel *)model
{
    [super setModel:model];
    
    if (model.type == ChatTypeSelf) {
        self.timeSelf.text    = model.time;
        self.messageSelf.text = model.message;
    }
}

@end
