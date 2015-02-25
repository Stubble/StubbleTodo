#import <UIKit/UIKit.h>

@interface UIView (ASYPresenterSupport)

- (void)retainPresenter:(id)presenter;
- (void)releaseAllPresenters;

@end
