//
//  ViewController.h
//  lsDemo2
//
//  Created by reburn on 2021/4/27.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *list;
@end

