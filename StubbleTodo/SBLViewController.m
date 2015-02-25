#import "SBLViewController.h"
#import "SBLTodoPresenter.h"

@interface SBLViewController ()

@end

@implementation SBLViewController

- (void)loadView {
    [super loadView];
    
    //SBLTodoModel *todoModel = [[SBLTodoModel alloc] initWithPersistence:todoPersistence];
    SBLTodoModel *todoModel = [[SBLTodoModel alloc] init];
    
    SBLTodoView *todoView = [[SBLTodoView alloc] init];
    todoView.frame = self.view.bounds;
	todoView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	[self.view addSubview:todoView];
    
	[SBLTodoPresenter bindWithModel:todoModel view:todoView];
}

@end
