#import "SBLTodoConstants.h"

@implementation SBLTodoConstants

+ (UIFont *)cellPlaceholderFont {
    CGFloat placeholderFontSize = [UIFont systemFontSize];
    return [UIFont italicSystemFontOfSize:placeholderFontSize];
}

+ (UIFont *)cellFont {
    CGFloat placeholderFontSize = [UIFont systemFontSize];
    return [UIFont systemFontOfSize:placeholderFontSize];
}

@end
