//
//  ChatCell.h
//  AutoLayoutCellDemo
//
//  Created by siping ruan on 16/10/9.
//  Copyright © 2016年 Rasping. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChatModel;

@interface ChatCell : UITableViewCell

@property (strong, nonatomic) ChatModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView chatModel:(ChatModel *)model;

@end
