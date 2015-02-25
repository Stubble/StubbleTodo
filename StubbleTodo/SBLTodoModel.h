#import <ESCObservable/ESCObservable.h>

@protocol SBLTodoModelObserver

- (void)todoItemsUpdated;

@end

@interface SBLTodoModel : NSObject<ESCObservable>

@property (nonatomic, readonly) NSArray *todoItems;

- (void)addTodoItemWithText:(NSString *)text;
- (void)deleteTodoItemAtIndex:(NSInteger)index;

@end
