//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Mauricio Minestrelli on 7/4/14.
//  Copyright (c) 2014 Mercadolibre. All rights reserved.
//

#import "CalculatorViewController.h"
#import "Calculator.h"


@interface CalculatorViewController (){
    Calculator * _myCalc;
    id<OperationDelegate> _currentOperation;
    
}

@property (nonatomic,strong) Calculator * myCalc;
@property (nonatomic,strong) id<OperationDelegate> currentOperation;
@property (strong, nonatomic) IBOutlet UILabel *labelDisplayAns;
@property (strong, nonatomic) IBOutlet UILabel *labelFormulaDisplay;

- (IBAction)onNumberButtonPressed:(UIButton *)sender;
- (IBAction)onOperatorButtonPressed:(UIButton *)sender;
- (IBAction)onClearButtonPressed:(UIButton *)sender;
- (IBAction)onCommaButtonPressed:(UIButton *)sender;
- (IBAction)onEqualsButtonPressed:(UIButton *)sender;
- (IBAction)onHistoryButtonPressed:(UIButton *)sender;


@end

@implementation CalculatorViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.myCalc=[[Calculator alloc]init];
        [self.myCalc setDelegate:self];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - Actions


- (IBAction)onNumberButtonPressed:(UIButton *)sender{
    NSString * input= sender.titleLabel.text;
    [self.myCalc numberPressed:input];
};

- (IBAction)onOperatorButtonPressed:(UIButton *)sender{
    
    NSString *input = sender.titleLabel.text;
    if([input isEqualToString:@"+"]) {
        self.currentOperation= [[AddOperation alloc]init];
    } else if([input isEqualToString:@"-"]) {
        self.currentOperation= [[SubstractOperation alloc]init];
    } else if([input isEqualToString:@"x"]) {
        self.currentOperation= [[MultiplicationOperation alloc]init];
    } else if([input isEqualToString:@"/"]) {
        self.currentOperation= [[DivisionOperation alloc]init];
    }
    
    [self.myCalc operationPressed:self.currentOperation];
    
};

- (IBAction)onClearButtonPressed:(UIButton *)sender{
    [self.myCalc reset];
    
};

- (IBAction)onCommaButtonPressed:(UIButton *)sender{
    [self.myCalc commaPressed];
};

- (IBAction)onEqualsButtonPressed:(UIButton *)sender {
    [self.myCalc executeOperation];
}

- (IBAction)onHistoryButtonPressed:(UIButton *)sender{
    [self.myCalc printHistory];
};


#pragma mark - Label update

-(void) onValueUpdate:(NSString*) formula withResult:(NSString*)result{
    [self.labelFormulaDisplay setText:formula ];
    
    [self.labelDisplayAns setText: result];
    [self resultLabelAnimation: self.labelDisplayAns.layer ];
}


#pragma mark - Animations

/* Animation for result displaying*/
-(void) resultLabelAnimation:(CALayer *) myLayer{
    CATransition *transitionAnimation = [CATransition animation];
    [transitionAnimation setType:kCATransitionFromBottom];
    [transitionAnimation setDuration:0.3f];
    [transitionAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [transitionAnimation setFillMode:kCAFillModeBoth];
    [myLayer addAnimation:transitionAnimation forKey:@"fadeanimation"];
}


@end
