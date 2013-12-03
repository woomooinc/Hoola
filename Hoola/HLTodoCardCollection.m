//
//  HLTodoCardCollection.m
//  Hoola
//
//  Created by Jonathan Dang on 2013/11/30.
//  Copyright (c) 2013年 Jonathan Dang. All rights reserved.
//

#import "HLTodoCardCollection.h"

static HLTodoCardCollection *_todoCardCollection;

@interface HLTodoCardCollection ()

@property (strong, readonly) NSMutableDictionary *store;

@end

@implementation HLTodoCardCollection
@synthesize store = _store;

+ (HLTodoCardCollection *)sharedCollection
{
    @synchronized([self class]){
        if (_todoCardCollection == nil) {
            _todoCardCollection = [[self alloc] init];
        }
    }
    
    return _todoCardCollection;
}

- (NSMutableDictionary *)store
{
    if (_store == nil) {
        _store = [NSMutableDictionary dictionary];
    }
    
    return _store;
}

- (void)addCard:(NSDictionary *)cardDict
{
    NSString *idString = [cardDict objectForKey:@"id"];
    [self.store setValue:cardDict forKey:idString];
}

- (void)removeCardWithId:(NSString *)idString
{
    [self.store removeObjectForKey:idString];
}

- (NSDictionary *)cardWithId:(NSString *)idString
{
    return [self.store objectForKey:idString];
}

- (NSArray *)cards
{
    return [self.store allValues];
}

@end
