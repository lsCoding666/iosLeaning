//
//  ViewController.h
//  NumberPickGame
//
//  Created by reburn on 2021/4/28.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (strong, nonatomic) UISlider *slider;
@property (strong, nonatomic) UITextField *minTextField;
@property (strong, nonatomic) UITextField *maxTextField;
@property (strong, nonatomic) UITextField *targetValueTextField;
@property (strong, nonatomic) UITextField *scoreTextField;
//回合数
@property (strong, nonatomic) UITextField *numOfRoundsTextField;
//本轮回合的尝试次数
@property (strong, nonatomic) UITextField *numOfTryTextField;
@end

