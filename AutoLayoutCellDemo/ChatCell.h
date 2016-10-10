//
//  ChatCell.h
//  AutoLayoutCellDemo
//
//  Created by siping ruan on 16/10/9.
//  Copyright © 2016年 Rasping. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChatModel;

/**
 *  聊天列表cell类型
 */
typedef NS_ENUM(NSInteger, ChatCellType) {
    /**
     *  别人发的
     */
    ChatCellTypeOther,
    /**
     *  自己发的
     */
    ChatCellTypeSelf
};

@interface ChatCell : UITableViewCell

@property (strong, nonatomic) ChatModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView chatCellType:(ChatCellType)type;

@end

@interface ChatCellSelf : ChatCell

@end
