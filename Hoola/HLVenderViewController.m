//
//  HLVenderViewController.m
//  Hoola
//
//  Created by Jonathan Dang on 2013/11/29.
//  Copyright (c) 2013年 Jonathan Dang. All rights reserved.
//

#import "HLVenderViewController.h"
#import "HLTrelloCellView.h"
#import "HLTodoCardCollection.h"

@interface HLVenderViewController ()
@end

@implementation HLVenderViewController{
    NSArray *_rawBoards;
    NSMutableArray *_activeBoards;
    NSArray *_rawLists;
    NSMutableArray *_activeLists;
    NSArray *_rawCards;
    NSMutableArray *_activeCards;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    if (self) {
        _activeBoards = [NSMutableArray new];
        _activeLists = [NSMutableArray new];
        _activeCards = [NSMutableArray new];
        
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
                     _activeBoards = [NSMutableArray new];
                     
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

- (void)getListsByBoardId:(NSString *)boardId
{
    HLServerAPIAgent *agent = [HLServerAPIAgent getServerAPIAgentInstance];
    [agent getTrelloListsByBoardId:boardId
                 completionSuccess:^(id success) {
                     _rawLists = (NSArray *)success;
                     _activeLists = [NSMutableArray new];

                     for (NSDictionary* list in _rawLists){
                         
                         if([[list objectForKey:@"closed"] boolValue] == YES){
                             continue;
                         }
                         
                         [_activeLists addObject:[list objectForKey:@"name"]];
                     }
                     
                     [self.listsPopUpButton removeAllItems];
                     [self.listsPopUpButton addItemsWithTitles:_activeLists];

                 } error:^(NSError *error) {
                     
                 }];
}

- (void)getCardsByListId:(NSString *)listId
{
    HLServerAPIAgent *agent = [HLServerAPIAgent getServerAPIAgentInstance];
    
    [agent getTrelloCardsByListId:listId
                completionSuccess:^(id success) {
                    _rawCards = (NSArray *)success;
                    _activeCards = [NSMutableArray new];

                    for (NSDictionary* card in _rawCards){


                        if([[card objectForKey:@"closed"] boolValue] == YES){
                            continue;
                        }
                         
                        [_activeCards addObject:card];
                    }
                     
                    [self.tableView reloadData];
                     
                } error:^(NSError *error) {
                     
                }];
}

# pragma mark - NSMenuDelegate

# pragma mark - NSTableViewDataSource
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [_activeCards count];
}

# pragma mark - NSTableViewDelegate
- (NSView *)tableView:(NSTableView *)tableView
   viewForTableColumn:(NSTableColumn *)tableColumn
                  row:(NSInteger)row
{
    NSDictionary *board = _activeCards[row];

    HLTrelloCellView *result = [tableView makeViewWithIdentifier:@"MainCell" owner:self];
    //    Set row number
    [result.cardId setStringValue:[NSString stringWithFormat:@"%ld", row + 1]];
    //    Set row title
    [result.cardTitle setStringValue:[board objectForKey:@"name"]];
    //    Set row created time
    [result.cardCreatedTime setStringValue:[board objectForKey:@"dateLastActivity"]];
    
    return result;
}

# pragma mark - Action
- (IBAction)onBoardItemClick:(id)sender {
    NSPopUpButton *btn = (NSPopUpButton *)sender;
    NSInteger index = [btn indexOfSelectedItem] + 1;
    NSLog( @"%ld", (long)index );
    NSDictionary *selectedBoard = [_rawBoards objectAtIndex:index];
    NSString *selectedBoardId = [selectedBoard objectForKey:@"id"];
    
//    [btn selectItemAtIndex:index];
    [self getListsByBoardId:selectedBoardId];
}

- (IBAction)onListItemClick:(id)sender {
    NSPopUpButton *btn = (NSPopUpButton *)sender;
    NSInteger index = [btn indexOfSelectedItem];
    
    NSDictionary *selectedList = [_rawLists objectAtIndex:index];
    NSString *selectedListId = [selectedList objectForKey:@"id"];

    [self getCardsByListId:selectedListId];
}

- (IBAction)addButtonClicked:(NSButton *)sender
{
    NSInteger row = [self.tableView rowForView:[sender superview]];
    [[HLTodoCardCollection sharedCollection] addCard:[_activeCards objectAtIndex:row]];
}

- (IBAction)removeButtonClicked:(id)sender
{
    NSInteger row = [self.tableView rowForView:[sender superview]];
    NSString *cardId = [[_activeCards objectAtIndex:row] objectForKey:@"id"];
    [[HLTodoCardCollection sharedCollection] removeCardWithId:cardId];
}
@end
