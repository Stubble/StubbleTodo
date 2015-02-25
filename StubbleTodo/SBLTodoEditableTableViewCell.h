#import <ESCObservable/ESCObservable.h>

@protocol SBLTodoEditableTableViewCellObserver

- (void)textEntered:(NSString *)text;

@end

@interface SBLTodoEditableTableViewCell : UITableViewCell<ESCObservable>

- (void)clearText;

@end
