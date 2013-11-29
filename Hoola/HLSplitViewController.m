//
//  HLSplitViewController.m
//  Hoola
//
//  Created by Jonathan Dang on 2013/11/29.
//  Copyright (c) 2013年 Jonathan Dang. All rights reserved.
//

#import "HLSplitViewController.h"
#import "HLTodoViewController.h"
#import "HLVenderViewController.h"
#import "HLUtils.h"

@interface HLSplitViewController ()
@property (strong) NSArray *groupTitleItems;
@property (strong) NSArray *todoListItems;
@property (strong) NSArray *vendorListItems;
@property (strong) NSArray *list;
@property (weak) IBOutlet NSOutlineView *outlineView;
@property (weak) IBOutlet NSView *detailViewWrapper;
@property (weak) NSView *detailView;
@property (strong, readonly) HLTodoViewController *todoViewController;
@property (strong, readonly) HLVenderViewController *venderViewController;


@end

@implementation HLSplitViewController
@synthesize todoViewController = _todoViewController;
@synthesize venderViewController = _venderViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
//        Initialize coulumn value
        self.groupTitleItems = [NSArray arrayWithObjects:@"Todo List", @"Vendor List", nil];
        self.todoListItems = [NSArray arrayWithObjects:@"Default", nil];
        self.vendorListItems = [NSArray arrayWithObjects:@"trello", @"github", nil];
        
        self.list = @[@{@"name":@"Todo List", @"items": self.todoListItems},
                      @{@"name":@"Vendor List", @"items": self.vendorListItems}];
        
    }
    return self;
}

# pragma mark - NSOutlineViewDataSource
- (BOOL)outlineView:(NSOutlineView *)outlineView
   isItemExpandable:(id)item
{
    if (item == nil || [item isKindOfClass:[NSDictionary class]]) {
        return YES;
    }
    return NO;
}

- (NSInteger)outlineView:(NSOutlineView *)outlineView
  numberOfChildrenOfItem:(id)item
{
    if (item==nil) {
        return [self.list count];
    }
    
    return [[item objectForKey:@"items"] count];
}

- (id)outlineView:(NSOutlineView *)outlineView
            child:(NSInteger)index
           ofItem:(id)item
{
    if (item==nil) {
        return [self.list objectAtIndex:index];
    }
    
    return [[item objectForKey:@"items"] objectAtIndex:index];
}

# pragma mark - NSOutlineViewDelegate
- (NSView *)outlineView:(NSOutlineView *)outlineView
     viewForTableColumn:(NSTableColumn *)tableColumn
                   item:(id)item
{
    if ([item isKindOfClass:[NSDictionary class]]) {
        NSTableCellView *result = [outlineView makeViewWithIdentifier:@"HeaderCell" owner:self];
        NSString *value = [item objectForKey:@"name"];
        [result.textField setStringValue:value];
        return result;
    }
    
    NSTableCellView *result = [outlineView makeViewWithIdentifier:@"DataCell" owner:self];
    // Uppercase the string value, but don't set anything else. NSOutlineView automatically applies attributes as necessary
    NSString *value = [item uppercaseString];
    [result.textField setStringValue:value];
    return result;
}

- (void)outlineViewSelectionDidChange:(NSNotification *)notification
{
    NSInteger index = [self.outlineView selectedRow];
    id item = [self.outlineView itemAtRow:index];
    if ([item isKindOfClass:[NSDictionary class]] == NO){
        NSString *typeName = [[self.outlineView parentForItem:item] objectForKey:@"name"];
        [self switchDetailViewControllerWithTypeName:typeName];
    }
}

- (HLTodoViewController *)todoViewController
{
    if (!_todoViewController) {
        _todoViewController = [[HLTodoViewController alloc] initWithNibName:@"HLTodoViewController" bundle:nil];
    }
    
    return _todoViewController;
}

- (HLVenderViewController *)venderViewController
{
    if (!_venderViewController) {
        _venderViewController = [[HLVenderViewController alloc] initWithNibName:@"HLVenderViewController" bundle:nil];
    }
    
    return _venderViewController;
}

- (void)switchDetailViewControllerWithTypeName:(NSString *)typeName
{
    if (self.detailView) {
        [self.detailView removeFromSuperview];
        self.detailView = nil;
    }
    
    NSView *view;
    if ([typeName isEqualToString:@"Todo List"]) {
        view = self.todoViewController.view;
    } else if ([typeName isEqualToString:@"Vendor List"]) {
        view = self.venderViewController.view;
    }
    
    [HLUtils fillParent:view];
    [view setFrame:self.detailViewWrapper.bounds];
    [self.detailViewWrapper addSubview:view];
    self.detailView = view;
    
}


@end
