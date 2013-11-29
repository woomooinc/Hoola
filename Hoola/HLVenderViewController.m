//
//  HLVenderViewController.m
//  Hoola
//
//  Created by Jonathan Dang on 2013/11/29.
//  Copyright (c) 2013年 Jonathan Dang. All rights reserved.
//

#import "HLVenderViewController.h"
#import "HLTrelloCellView.h"

@interface HLVenderViewController ()
@end

@implementation HLVenderViewController{
    NSArray *_rawBoards;
    NSMutableArray *_activeBoards;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    if (self) {
        _activeBoards = [NSMutableArray new];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(onBoardClickHandler)
                                                     name:NSPopUpButtonWillPopUpNotification
                                                   object:Nil];
        [self getBoards];
    }
    return self;
}

- (void)getBoards
{
    HLServerAPIAgent *agent = [HLServerAPIAgent getServerAPIAgentInstance];
    
    [agent getTrelloBoardsByUserId:@"test"
                 completionSuccess:^(id success) {
                     _rawBoards = (NSArray *)success;
                     
                     for (NSDictionary* board in _rawBoards){
                         
                         if([[board objectForKey:@"closed"] boolValue] == YES){
                             continue;
                         }
                         
                         [_activeBoards addObject:[board objectForKey:@"name"]];
                     }
                     
                     [self.boardsPopUpButton removeAllItems];
                     [self.boardsPopUpButton addItemsWithTitles:_activeBoards];
                     
                 } error:^(NSError *error) {
                     
                 }];
    
}

- (void)onBoardClickHandler
{
    NSLog(@"hello");
    
}
# pragma mark - NSMenuDelegate
- (void)menuWillOpen:(NSMenu *)menu
{
    NSLog(@"click");
}

# pragma mark - NSTableViewDataSource
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [_activeBoards count];
}

# pragma mark - NSTableViewDelegate
- (NSView *)tableView:(NSTableView *)tableView
   viewForTableColumn:(NSTableColumn *)tableColumn
                  row:(NSInteger)row
{
    NSDictionary *board = _activeBoards[row];
    NSString *boardId = [board objectForKey:@"id"];
    NSString *name = [board objectForKey:@"name"];

    HLTrelloCellView *result = [tableView makeViewWithIdentifier:@"MainCell" owner:self];
    
    [result.cardId setStringValue:[NSString stringWithFormat:@"%ld", row]];
    [result.cardTitle setStringValue:name];
    
    return result;
}

- (IBAction)onMenuItem:(id)sender {
    NSLog(@"fuck");
}
@end
