//
//  HLTodoViewController.m
//  Hoola
//
//  Created by Jonathan Dang on 2013/11/29.
//  Copyright (c) 2013年 Jonathan Dang. All rights reserved.
//

#import "HLTodoViewController.h"
#import "HLTodoCardCollection.h"
#import "HLTodoCellView.h"
#import "HLServerAPIAgent.h"

@interface HLTodoViewController ()<NSTableViewDataSource, NSTableViewDelegate>{
    NSDictionary *_currentTask;
    NSTextField *_currentUpdateView;
    NSTimer *_currentTimer;
    NSString *_currentCardId;
    NSTimeInterval _initialTime;
    NSTimeInterval _deltaTime;
    
    BOOL _isPause;
}

@property (strong) HLTodoCardCollection *cardCollection;

@end

@implementation HLTodoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
        self.cardCollection = [HLTodoCardCollection sharedCollection];
    }
    return self;
}

- (void)updateCardWithCardId:(NSString *)cardId
                andDeltaTime:(NSTimeInterval) deltaTime
{
    HLServerAPIAgent *agent = [HLServerAPIAgent getServerAPIAgentInstance];
    [agent updateTrelloCardByCardId:cardId
                      withDeltaTime:deltaTime
                  completionSuccess:^(id success) {
                      NSLog(@"successs");
                  } error:^(NSError *error) {

                  }];
}

- (void)reload
{
    [self.tableView reloadData];
}

# pragma mark - NSTableViewDataSource
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [[self.cardCollection cards] count];
}

- (NSView *)tableView:(NSTableView *)tableView
   viewForTableColumn:(NSTableColumn *)tableColumn
                  row:(NSInteger)row
{
    NSDictionary *card = [[self.cardCollection cards] objectAtIndex:row];
    
    HLTodoCellView *cellView = [self.tableView makeViewWithIdentifier:@"TodoCell" owner:self];
    [cellView.idField setStringValue:[NSString stringWithFormat:@"%ld", row + 1]];
    [cellView.titleField setStringValue: [card objectForKey: @"name"]];
    [cellView.createdDateField setStringValue:[card objectForKey:@"dateLastActivity"]];
    
    return cellView;
}
- (void)updateTimer:(NSTimer *)timer
{
    NSDate *date = [NSDate date];
    NSTimeInterval currentTime = [date timeIntervalSince1970];
    NSTimeInterval deltaTime = currentTime - _initialTime + _deltaTime;
    _currentUpdateView.stringValue = [NSString stringWithFormat:@"%.0f", deltaTime];
}

- (void)startTimer:(NSButton *)btn
{
    NSDate *date = [NSDate date];
    NSTimeInterval initialTime = [date timeIntervalSince1970];
    _initialTime = initialTime;
    _currentUpdateView = (NSTextField *)(((HLTodoCellView *)[btn superview]).createdDateField);
    NSString *index = [(NSTextField *)(((HLTodoCellView *)[btn superview]).idField) stringValue];
    
    _currentCardId = [(NSDictionary *)[self.cardCollection cards][[index intValue] - 1] objectForKey:@"id"];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1
                                             target:self
                                           selector:@selector(updateTimer:)
                                           userInfo:Nil
                                            repeats:YES];
    _currentTimer = timer;
}

- (void)pauseTimer:(NSButton *)btn
{
    NSDate *date = [NSDate date];
    NSTimeInterval currentTime = [date timeIntervalSince1970];
    
    if (_isPause) {
        _initialTime = currentTime;
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                          target:self
                                                        selector:@selector(updateTimer:)
                                                        userInfo:Nil
                                                         repeats:YES];
        _currentTimer = timer;
    } else {
        [_currentTimer invalidate];
        _deltaTime += currentTime - _initialTime;
        _currentUpdateView.stringValue = @"Pause";
    }
    
    _isPause = !_isPause;
}

- (void)doneTimer:(NSButton *)btn
{
    NSDate *date = [NSDate date];
    [_currentTimer invalidate];
    NSTimeInterval currentTime = [date timeIntervalSince1970];
    NSTimeInterval deltaTime = currentTime - _initialTime + _deltaTime;
    
    [self updateCardWithCardId:_currentCardId andDeltaTime:deltaTime];
}

@end
