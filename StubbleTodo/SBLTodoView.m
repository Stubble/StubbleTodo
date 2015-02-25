#import "SBLTodoView.h"
#import "SBLTodoEditableTableViewCell.h"
#import "SBLTodoTableViewCell.h"

@interface SBLTodoView()<ESCObservableInternal, SBLTodoEditableTableViewCellObserver, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, readonly) UIView *topBorder;
@property (nonatomic, readonly) CAGradientLayer *topBorderGradient;
@property (nonatomic, readonly) UITableView *todoItemsTable;
@property (nonatomic, readonly) NSArray *todoItems;

@end

@implementation SBLTodoView

#define EditableRow 0
#define EditableRowIndexPath ([NSIndexPath indexPathForRow:EditableRow inSection:0])

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self escRegisterObserverProtocol:@protocol(SBLTodoViewObserver)];
        
        UIView *topBorder = [[UIView alloc] init];
        [self addSubview:topBorder];
        
        CAGradientLayer *topBorderGradient = [CAGradientLayer layer];
        UIColor *topColor = [UIColor colorWithRed:0.6 green:0.54 blue:0.51 alpha:1];
        UIColor *bottomColor = [UIColor colorWithRed:0.51 green:0.46 blue:0.44 alpha:1];
        topBorderGradient.colors = [NSArray arrayWithObjects:(id)[topColor CGColor], (id)[bottomColor CGColor], nil];
        [topBorder.layer insertSublayer:topBorderGradient atIndex:0];
        
        UITableView *todoItemsTable = [[UITableView alloc] init];
        todoItemsTable.dataSource = self;
        todoItemsTable.delegate = self;
        todoItemsTable.tableFooterView = [[UIView alloc] init];
        todoItemsTable.alwaysBounceVertical = YES;
        todoItemsTable.allowsMultipleSelectionDuringEditing = NO;
        [todoItemsTable registerClass:SBLTodoEditableTableViewCell.class forCellReuseIdentifier:NSStringFromClass(SBLTodoEditableTableViewCell.class)];
        [todoItemsTable registerClass:SBLTodoTableViewCell.class forCellReuseIdentifier:NSStringFromClass(SBLTodoTableViewCell.class)];
        [self addSubview:todoItemsTable];
        
        _topBorder = topBorder;
        _topBorderGradient = topBorderGradient;
        _todoItemsTable = todoItemsTable;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat topBorderHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    self.topBorder.frame = CGRectMake(0, 0, self.bounds.size.width, topBorderHeight);
    self.topBorderGradient.frame = self.topBorder.frame;
    
    self.todoItemsTable.frame = UIEdgeInsetsInsetRect(self.bounds, UIEdgeInsetsMake(CGRectGetMaxY(self.topBorder.frame), 0, 0, 0));
}

- (id<SBLTodoViewObserver>)notifier {
    return self.escNotifier;
}

- (void)setTodoItems:(NSArray *)todoItems {
    _todoItems = todoItems;
    
    [self.todoItemsTable reloadData];

    SBLTodoEditableTableViewCell *todoEditableTableViewCell = (SBLTodoEditableTableViewCell *)[self.todoItemsTable cellForRowAtIndexPath:EditableRowIndexPath];
    [todoEditableTableViewCell clearText];
}

#pragma mark SBLTodoEditableTableViewCellObserver

- (void)textEntered:(NSString *)text {
    [self.escNotifier textEntered:text];
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.todoItems.count  + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *todoTableViewCell;
    if (indexPath.row == 0) {
        todoTableViewCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(SBLTodoEditableTableViewCell.class)];
    } else {
        todoTableViewCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(SBLTodoTableViewCell.class)];
        todoTableViewCell.textLabel.text = self.todoItems[indexPath.row - 1];
    }
    return todoTableViewCell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row != 0;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.escNotifier todoItemDeletedAtIndex:indexPath.row - 1];
    }
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == EditableRow) {
        SBLTodoEditableTableViewCell *todoEditableTableViewCell = (SBLTodoEditableTableViewCell *)cell;
        [todoEditableTableViewCell escAddObserver:self];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == EditableRow) {
        SBLTodoEditableTableViewCell *todoEditableTableViewCell = (SBLTodoEditableTableViewCell *)cell;
        [todoEditableTableViewCell escRemoveObserver:self];
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row != 0;
}

@end
