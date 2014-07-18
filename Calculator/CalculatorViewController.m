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
    id<Operation> _currentOperation;
    NSNumberFormatter * _numberFormatter;
    
}

@property (nonatomic,strong) Calculator * myCalc;
@property (nonatomic,strong) id<Operation> currentOperation;
@property (strong, nonatomic) IBOutlet UILabel *resultDisplayLabel;
@property (strong, nonatomic) IBOutlet UILabel *operationResultDisplayLabel;
@property (nonatomic,strong) NSNumberFormatter * numberFormatter;

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
        self.numberFormatter = [[NSNumberFormatter alloc] init];
        [self.numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        
        
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

-(void) onDisplayChange:(NSString*) upperDisplay withResult:(NSNumber*)result{
    [self.operationResultDisplayLabel setText:upperDisplay ];
    
    [self.resultDisplayLabel setText: [self.numberFormatter stringFromNumber:[NSNumber numberWithFloat:[result  floatValue]]]];
    [self resultLabelAnimation: self.resultDisplayLabel.layer ];
}


#pragma mark - Animations

-(void) resultLabelAnimation:(CALayer *) myLayer{
    CATransition *transitionAnimation = [CATransition animation];
    [transitionAnimation setType:kCATransitionFromBottom];
    [transitionAnimation setDuration:0.5f];
    [transitionAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [transitionAnimation setFillMode:kCAFillModeBoth];
    [myLayer addAnimation:transitionAnimation forKey:@"fadeanimation"];
}


@end
