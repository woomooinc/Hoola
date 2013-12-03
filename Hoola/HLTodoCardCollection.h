//
//  HLTodoCardCollection.h
//  Hoola
//
//  Created by Jonathan Dang on 2013/11/30.
//  Copyright (c) 2013年 Jonathan Dang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLTodoCardCollection : NSObject

+ (HLTodoCardCollection *)sharedCollection;

- (void)addCard:(NSDictionary *)cardDict;
- (void)removeCardWithId:(NSString *)idString;
- (NSDictionary *)cardWithId:(NSString *)idString;
- (NSArray *)cards;

@end
