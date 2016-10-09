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

+ (instancetype)cellWithTableView:(UITableView *)tableView chatModel:(ChatModel *)model
{
    static NSString *reuseIdentifier;
    NSInteger index = 0;
    if (model.type == ChatTypeOther) {
        reuseIdentifier = @"ChatCellTypeOther";
    }else if (model.type == ChatTypeSelf) {
        reuseIdentifier = @"ChatCellTypeSelf";
        index= 1;
    }
    ChatCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ChatCell" owner:self options:0][index];
    }
    cell.model = model;
    return cell;
}

- (void)setModel:(ChatModel *)model
{
    _model = model;
    
    self.message.text = model.message;
    self.time.text    = model.time;
}

@end
