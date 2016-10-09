//
//  ChatModel.m
//  AutoLayoutCellDemo
//
//  Created by siping ruan on 16/10/9.
//  Copyright © 2016年 Rasping. All rights reserved.
//

#import "ChatModel.h"

@implementation ChatModel

+ (instancetype)modelWithIcon:(NSString *)icon time:(NSString *)time message:(NSString *)message type:(ChatType)type
{
    ChatModel *model = [[ChatModel alloc] init];
    model.icon       = icon;
    model.time       = time;
    model.message    = message;
    model.type       = type;
    return model;
}

@end
