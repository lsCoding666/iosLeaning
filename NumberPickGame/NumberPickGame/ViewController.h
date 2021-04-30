//
//  ViewController.h
//  NumberPickGame
//
//  Created by reburn on 2021/4/28.
//

#import <UIKit/UIKit.h>
@class ViewController;
@interface ViewController : UIViewController
@property (strong, nonatomic) UISlider *slider;
@property (strong, nonatomic) UILabel *minValueLabel;
@property (strong, nonatomic) UILabel *maxValueLabel;
@property (strong, nonatomic) UILabel *targetValueLabel;
@property (strong, nonatomic) UILabel *scoreLabel;
//回合数
@property (strong, nonatomic) UILabel *numOfRoundsTextField;
//本轮回合的尝试次数
@property (strong, nonatomic) UILabel *numOfTryTextField;
@property ( nonatomic) int currentValue;
@property ( nonatomic) int targetValue;
@property ( nonatomic) int countOfTry;
@property ( nonatomic) int score;
@property ( nonatomic) int rounds;
@end

