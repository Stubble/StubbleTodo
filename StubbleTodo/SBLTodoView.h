#import "SBLTodoEditableTableViewCell.h"
#import <ESCObservable/ESCObservable.h>

@protocol SBLTodoViewObserver<SBLTodoEditableTableViewCellObserver>

- (void)todoItemDeletedAtIndex:(NSInteger)index;

@end

@interface SBLTodoView : UIView<ESCObservable>

- (void)setTodoItems:(NSArray *)todoItems;

@end
