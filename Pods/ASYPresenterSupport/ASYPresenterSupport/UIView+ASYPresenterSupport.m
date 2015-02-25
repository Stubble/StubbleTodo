#import "UIView+ASYPresenterSupport.h"
#import <objc/runtime.h>

#define ASYPresenterSupportPresenterArrayKey "ASYPresenterSupportPresenterArrayKey"

static NSMutableArray *asyRetainedPresenters(id self) {
    return objc_getAssociatedObject(self, ASYPresenterSupportPresenterArrayKey);
}

static void asyRetainPresenter(id self, SEL _cmd, id presenter) {
    NSMutableArray *presenterArray = asyRetainedPresenters(self);
    if (!presenterArray) {
        presenterArray = [NSMutableArray array];
        objc_setAssociatedObject(self, ASYPresenterSupportPresenterArrayKey, presenterArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [presenterArray addObject:presenter];
}

static void asyReleaseAllPresenters(id self, SEL _cmd) {
    [asyRetainedPresenters(self) removeAllObjects];
}

static void asyAddPresenterSupportToClass(Class aClass) {
	if (aClass != NULL) {
        class_replaceMethod(aClass, @selector(retainPresenter:), (IMP) asyRetainPresenter, "v@:@");
        class_replaceMethod(aClass, @selector(releaseAllPresenters), (IMP) asyReleaseAllPresenters, "v@:");
	}
}

__attribute__((constructor)) static void asyAddPresenterSupportForDefaultClasses() {
    asyAddPresenterSupportToClass(UIView.class);
    asyAddPresenterSupportToClass(objc_getClass("SBLMockObject"));
    asyAddPresenterSupportToClass(objc_getClass("OCMockObject"));
}


@implementation UIView (ASYPresenterSupport)

- (void)retainPresenter:(id)presenter {}
- (void)releaseAllPresenters {}

@end
