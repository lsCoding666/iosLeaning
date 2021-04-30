//
//  Test.m
//  NumberPickGame
//
//  Created by reburn on 2021/4/30.
//

#import <Foundation/Foundation.h>


@implementation UITools:NSObject

+(CGSize)getCGSizeFromText:(UILabel *)label{
    CGSize size = [label.text sizeWithAttributes:@{NSFontAttributeName:label.font}];
    return size;
}

+(CGSize)getCGSizeFromText:(NSString *)text : (nullable NSDictionary<NSAttributedStringKey, id> *)attrs API_AVAILABLE(macos(10.0), ios(7.0)){
    CGSize size = [text sizeWithAttributes:attrs];
    return size;
}

@end
