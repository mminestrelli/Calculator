//
//  CalculatorViewController.h
//  Calculator
//
//  Created by Mauricio Minestrelli on 7/4/14.
//  Copyright (c) 2014 Mercadolibre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OperationDelegate.h"
#import "AddOperation.h"
#import "SubstractOperation.h"
#import "MultiplicationOperation.h"
#import "DivisionOperation.h"
#import "CalculatorDelegate.h"

@interface CalculatorViewController : UIViewController<CalculatorDelegate>

@end
