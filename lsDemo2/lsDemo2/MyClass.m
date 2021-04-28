//
//  MyClass.m
//  lsDemo2
//
//  Created by reburn on 2021/4/28.
//

#import <Foundation/Foundation.h>
@interface MyClass(customAdditions)
- (void)sampleCategoryMethod;
@end
@implementation MyClass(categoryAdditions)

-(void)sampleCategoryMethod{
   NSLog(@"Just a test category");
}
