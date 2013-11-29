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

@end
