//
//  CalculatorViewController.h
//  Calculator
//
//  Created by Mauricio Minestrelli on 7/4/14.
//  Copyright (c) 2014 Mercadolibre. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalculatorViewController : UIViewController
@property (retain, nonatomic) IBOutlet UILabel *resultDisplayLabel;
@property (retain, nonatomic) IBOutlet UILabel *operationResultDisplayLabel;


- (IBAction)onNumberButtonPressed:(UIButton *)sender;

- (IBAction)onOperatorButtonPressed:(UIButton *)sender;

- (IBAction)onClearButtonPressed:(UIButton *)sender;

- (IBAction)onCommaButtonPressed:(UIButton *)sender;
- (IBAction)onEqualsButtonPressed:(UIButton *)sender;
- (IBAction)onHistoryButtonPressed:(UIButton *)sender;

@end
