#import <ESCObservable/ESCObservable.h>
#import "SBLTodoPresenter.h"
#import "UIView+ASYPresenterSupport.h"

@interface SBLTodoPresenter()<SBLTodoModelObserver, SBLTodoViewObserver>

@property (nonatomic, readonly) SBLTodoModel *model;
@property (nonatomic, readonly, weak) SBLTodoView *view;

@end

@implementation SBLTodoPresenter

+ (void)bindWithModel:(SBLTodoModel *)model view:(SBLTodoView *)view {
    SBLTodoPresenter *presenter = [[self alloc] initWithModel:model view:view];
	[view retainPresenter:presenter];
}

- (instancetype)initWithModel:(SBLTodoModel *)model view:(SBLTodoView *)view {
	if (self = [super init]) {
		[model escAddObserver:self];
		[view escAddObserver:self];
        [view setTodoItems:model.todoItems];
        
		_model = model;
		_view = view;
	}
	return self;
}

#pragma mark SBLTodoModelObserver

- (void)todoItemsUpdated {
    [self.view setTodoItems:self.model.todoItems];
}

#pragma mark SBLTodoViewObserver

- (void)textEntered:(NSString *)text {
    [self.model addTodoItemWithText:text];
}

- (void)todoItemDeletedAtIndex:(NSInteger)index {
    [self.model deleteTodoItemAtIndex:index];
}

@end
