//
//  UIColor+HexColor.h
//  04-颜色常识
//
//  Created by mac on 16/7/21.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexColor)
/**
 *  将美工给的十六进制颜色字符串转换成颜色
 *  可以解析的颜色字符串：#666666 0x666666 666666
 *
 *  @param colorStr 十六进制颜色字符串
 *
 *  @return UIColor 默认透明度为1.0
 */
+ (UIColor *)colorWithHexColorStr:(NSString *)colorStr;

+ (UIColor *)colorWithHexColorStr:(NSString *)colorStr alpha:(CGFloat)alpha;














@end
