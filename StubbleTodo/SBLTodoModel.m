#import "SBLTodoModel.h"

@interface SBLTodoModel()<ESCObservableInternal>

@property (nonatomic) NSMutableArray *todoItemsArray;

@end

@implementation SBLTodoModel

- (id)init {
    if (self = [super init]) {
        [self escRegisterObserverProtocol:@protocol(SBLTodoModelObserver)];
        _todoItemsArray = [NSMutableArray array];
    }
    return self;
}

- (NSArray *)todoItems {
    return self.todoItemsArray;
}

- (void)addTodoItemWithText:(NSString *)text {
    [self.todoItemsArray insertObject:text atIndex:0];
    [self.escNotifier todoItemsUpdated];
}

- (void)deleteTodoItemAtIndex:(NSInteger)index {
    [self.todoItemsArray removeObjectAtIndex:index];
    [self.escNotifier todoItemsUpdated];
}

@end
