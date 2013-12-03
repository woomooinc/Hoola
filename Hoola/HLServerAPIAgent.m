//
//  HLServerAPIAgent.m
//  Hoola
//
//  Created by Jonathan Dang on 2013/11/30.
//  Copyright (c) 2013年 Jonathan Dang. All rights reserved.
//

#import "HLServerAPIAgent.h"
#import "AFNetworking.h"

@implementation HLServerAPIAgent

# pragma mark - Static Method
+ (HLServerAPIAgent *)getServerAPIAgentInstance
{
    static dispatch_once_t pred;
    static HLServerAPIAgent *APIAgent = nil;
    
    dispatch_once(&pred, ^{
        APIAgent = [[self alloc] init];
    });
    return APIAgent;
}

+ (NSDictionary *)getVendorConfigByVendorName:(NSString *)vendorName
{
    //Get Info.plist
    NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"Vendors" ofType:@"plist"];
    //Get Dictionary object from plist
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: plistPath];
    //Get Value of "Server URL"
    return [dict objectForKey:vendorName];
}

- (void)getTrelloBoardsByUserId:(NSString *)userId
              completionSuccess:(RequestSuccessHandler)successHandler
                          error:(RequestErrorHandler)errorHandler;
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *dict = [HLServerAPIAgent getVendorConfigByVendorName:@"Trello"];
    NSString *url = [NSString stringWithFormat:@"%@members/me/boards", [dict objectForKey:@"APIURL"]];
    NSDictionary *parameters = @{@"key" : [dict objectForKey:@"AppKey"],
                                 @"token" : [dict objectForKey:@"UserToken"]};

    [manager GET:url
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             successHandler(responseObject);
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             errorHandler(error);
         }];
}


- (void)getTrelloListsByBoardId:(NSString *)boardId
              completionSuccess:(RequestSuccessHandler)successHandler
                          error:(RequestErrorHandler)errorHandler;
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *dict = [HLServerAPIAgent getVendorConfigByVendorName:@"Trello"];
    NSString *url = [NSString stringWithFormat:@"%@boards/%@/lists", [dict objectForKey:@"APIURL"], boardId];
    NSDictionary *parameters = @{@"key" : [dict objectForKey:@"AppKey"],
                                 @"token" : [dict objectForKey:@"UserToken"]};
    
    [manager GET:url
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             successHandler(responseObject);
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             errorHandler(error);
         }];
}

- (void)getTrelloCardsByListId:(NSString *)listId
             completionSuccess:(RequestSuccessHandler)successHandler
                         error:(RequestErrorHandler)errorHandler
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *dict = [HLServerAPIAgent getVendorConfigByVendorName:@"Trello"];
    NSString *url = [NSString stringWithFormat:@"%@lists/%@/cards", [dict objectForKey:@"APIURL"], listId];
    NSDictionary *parameters = @{@"key" : [dict objectForKey:@"AppKey"],
                                 @"token" : [dict objectForKey:@"UserToken"]};
    
    [manager GET:url
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             successHandler(responseObject);
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             errorHandler(error);
         }];
}


- (void)updateTrelloCardByCardId:(NSString *)cardId
                   withDeltaTime:(NSTimeInterval)deltaTime
               completionSuccess:(RequestSuccessHandler)successHandler
                           error:(RequestErrorHandler)errorHandler
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *dict = [HLServerAPIAgent getVendorConfigByVendorName:@"Trello"];
    NSInteger minutes = deltaTime/60;
    NSInteger seconds = (int)deltaTime % 60;
    NSString *desc = [ NSString stringWithFormat:@"This task has DONE!! It took me %ld mins %ld secs on this work.", minutes, seconds ];
    NSString *url = [NSString stringWithFormat:@"%@cards/%@/desc", [dict objectForKey:@"APIURL"], cardId];
    NSDictionary *parameters = @{@"key" : [dict objectForKey:@"AppKey"],
                                 @"token" : [dict objectForKey:@"UserToken"],
                                 @"value" : desc};
    
    [manager PUT:url
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             successHandler(responseObject);
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             errorHandler(error);
         }];
}
@end
