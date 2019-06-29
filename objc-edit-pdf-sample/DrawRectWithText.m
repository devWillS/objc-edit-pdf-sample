//
//  DrawRectWithText.m
//  objc-edit-pdf-sample
//
//  Created by devWill on 2019/06/29.
//  Copyright © 2019 devWill. All rights reserved.
//

#import "DrawRectWithText.h"

@implementation DrawRectWithText

+ (void) draw:(CGRect)rect withText:(NSString *)text fontSize:(CGFloat)fontSize backgroundColor:(UIColor *)color {
    // 四角形（短形）
    UIBezierPath *rectangle = [UIBezierPath bezierPathWithRect:rect];
    // 内側の色
    [color setFill];
    // 内側を塗りつぶす
    [rectangle fill];
    // 線の色
    [color setStroke];
    // 線の太さ
    [rectangle setLineWidth:2.0f];
    // 線を塗りつぶす
    [rectangle stroke];
    // フォント設定
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    
    NSDictionary *dictionary = [[NSDictionary alloc] initWithObjectsAndKeys: font, NSFontAttributeName,
                                nil];
    // テキストを描画
    [text drawInRect:rect withAttributes:dictionary];
}

@end
