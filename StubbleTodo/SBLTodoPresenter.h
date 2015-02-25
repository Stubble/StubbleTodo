#import "SBLTodoModel.h"
#import "SBLTodoView.h"

@interface SBLTodoPresenter : NSObject

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (void)bindWithModel:(SBLTodoModel *)model view:(SBLTodoView *)view;

@end
