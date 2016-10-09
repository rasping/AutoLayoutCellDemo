//
//  ChatModel.h
//  AutoLayoutCellDemo
//
//  Created by siping ruan on 16/10/9.
//  Copyright © 2016年 Rasping. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  聊天列表cell类型
 */
typedef NS_ENUM(NSInteger, ChatType) {
    /**
     *  别人发的
     */
    ChatTypeOther,
    /**
     *  自己发的
     */
    ChatTypeSelf
};

@interface ChatModel : NSObject

@property (copy, nonatomic) NSString *icon;
@property (copy, nonatomic) NSString *time;
@property (copy, nonatomic) NSString *message;
@property (assign, nonatomic) ChatType type;

+ (instancetype)modelWithIcon:(NSString *)icon
                         time:(NSString *)time
                      message:(NSString *)message
                         type:(ChatType)type;

@end
