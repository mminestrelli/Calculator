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

-(void) updateLabel;
@end

@implementation CalculatorViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.myCalc=[[Calculator alloc]init];
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
    
    NSString *input = sender.titleLabel.text;
    
    [self.myCalc numberPressed:input];
    [self updateLabel];
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
        /*if((self.operand==0.0 && ![self.operandString isEqualToString:@""])||([self.myCalc.ans floatValue]==0.0 && [self.operandString isEqualToString:@""])){
         self.printed=YES;
         [self.resultDisplayLabel setText:@"∞"];
         }else{*/
        self.currentOperation= [[DivisionOperation alloc]init];
        
        //}
    }
    
    [self.myCalc operationPressed:self.currentOperation];
    [self updateLabel];
    
};

- (IBAction)onClearButtonPressed:(UIButton *)sender{
    [self.myCalc reset];
    [self.resultDisplayLabel setText:@"0"];
    
};

- (IBAction)onCommaButtonPressed:(UIButton *)sender{
    
    [self.myCalc commaPressed];
    [self updateLabel];
};

- (IBAction)onEqualsButtonPressed:(UIButton *)sender {
    
    [self.myCalc executeOperation];
    [self updateLabel];
    if([self.myCalc redrawIsNeeded]){
        [self updateLabel];
    }else{
    [self.resultDisplayLabel setText: [self.numberFormatter stringFromNumber:[NSNumber numberWithFloat:[self.myCalc.ans floatValue]]]];
    }
}
- (IBAction)onHistoryButtonPressed:(UIButton *)sender{
    [self.myCalc printHistory];
};


#pragma mark - Custom messages
-(void) updateLabel{
    [self.operationResultDisplayLabel setText:[self.myCalc lastOperationPerformed] ];
    
    [self.resultDisplayLabel setText: [self.numberFormatter stringFromNumber:[NSNumber numberWithFloat:[self.myCalc.ans floatValue]]]];
    [self resultLabelAnimation: self.resultDisplayLabel.layer ];
}

-(void) changeLabelValue:(float) value{
    NSString * valueString= [self.numberFormatter stringFromNumber:[NSNumber numberWithFloat:value] ];
    [self.resultDisplayLabel setText:valueString];
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
