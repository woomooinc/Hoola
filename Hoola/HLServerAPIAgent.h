//
//  HLServerAPIAgent.h
//  Hoola
//
//  Created by Jonathan Dang on 2013/11/30.
//  Copyright (c) 2013年 Jonathan Dang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HLRequest;
typedef void (^RequestSuccessHandler)(id success);
typedef void (^RequestErrorHandler)(NSError *error);

@interface HLServerAPIAgent : NSObject


#pragma mark - Singleton
+ (HLServerAPIAgent *)getServerAPIAgentInstance;

#pragma mark - Static Method
+ (NSDictionary *)getVendorConfigByVendorName:(NSString *)vendorName;

#pragma mark - Trello
- (void)getTrelloBoardsByUserId:(NSString *)userId
              completionSuccess:(RequestSuccessHandler)successHandler
                          error:(RequestErrorHandler)errorHandler;

- (void)getTrelloListsByBoardId:(NSString *)boardId
              completionSuccess:(RequestSuccessHandler)successHandler
                          error:(RequestErrorHandler)errorHandler;

- (void)getTrelloCardsByListId:(NSString *)listId
             completionSuccess:(RequestSuccessHandler)successHandler
                         error:(RequestErrorHandler)errorHandler;

- (void)updateTrelloCardWithDictionary:(NSDictionary *)configDictionary
                     completionSuccess:(RequestSuccessHandler)successHandler
                                 error:(RequestErrorHandler)errorHandler;

- (void)updateTrelloCardByCardId:(NSString *)cardId
                   withDeltaTime:(NSTimeInterval)deltaTime
               completionSuccess:(RequestSuccessHandler)successHandler
                           error:(RequestErrorHandler)errorHandler;

#pragma mark - Github
// @TODO

@end
