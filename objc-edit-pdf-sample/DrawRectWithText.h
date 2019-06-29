//
//  DrawRectWithText.h
//  objc-edit-pdf-sample
//
//  Created by devWill on 2019/06/29.
//  Copyright © 2019 devWill. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DrawRectWithText : UIView

+ (void) draw:(CGRect)rect withText:(NSString *)text fontSize:(CGFloat)fontSize backgroundColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
