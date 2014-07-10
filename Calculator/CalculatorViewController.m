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
    float _operand;
    NSString * _operator;
    NSString * _upperDisplay;
    NSString * _ansString;
    NSString * _operandString;
    Boolean _decimalMode;
    Boolean _erase;
    Boolean _printed;
    Calculator * _myCalc;
    NSMutableDictionary * _history;
    id<Operation> _currentOperation;
    
}

@property (nonatomic,copy) NSString * operator;
@property (nonatomic,copy) NSString * upperDisplay;
@property (nonatomic,copy) NSString * ansString;
@property (nonatomic,copy) NSString * operandString;
@property (nonatomic,retain) Calculator * myCalc;
@property (nonatomic,assign) Boolean  decimalMode;
@property (nonatomic,assign) Boolean  erase;
@property (nonatomic,assign) Boolean printed;
@property (nonatomic,retain) NSMutableDictionary * history;
@property (nonatomic,assign) float operand;
@property (nonatomic,retain) id<Operation> currentOperation;

@end

@implementation CalculatorViewController
@synthesize operator=_operator;
@synthesize ansString=_ansString;
@synthesize upperDisplay=_upperDisplay;
@synthesize operandString=_operandString;
@synthesize myCalc=_myCalc;
@synthesize decimalMode=_decimalMode;
@synthesize erase=_erase;
@synthesize printed=_printed;
@synthesize history=_history;
@synthesize operand=_operand;
@synthesize currentOperation=_currentOperation;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.myCalc=[[[Calculator alloc]init]autorelease];
        self.ansString=@"";
        self.operandString=@"";
        self.ansString=@"";
        self.upperDisplay=@"";
        self.history= [[[NSMutableDictionary alloc]init]autorelease];
        self.decimalMode=NO;
        self.erase=NO;
        self.printed=NO;
        
        
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
    if(self.erase){
        [self.operationResultDisplayLabel setText:@""];
        self.erase=NO;
    }
    if(self.operator!=nil){
        //The number is part of the operand
        //NSLog(self.operandString);
        self.operandString= [self.operandString stringByAppendingString:input];
        //NSLog(self.operandString);
        self.operand=[self.operandString floatValue];
        //NSLog(operandString);
        
    }else{
        //The number is part of ans
        //NSLog(ansString);
        self.ansString= [self.ansString stringByAppendingString:input];
        //NSLog(self.ansString);
        [self.myCalc setAns:[NSNumber numberWithFloat:[self.ansString floatValue]]];
        //NSLog(self.ansString);
    }
    self.upperDisplay= [self.upperDisplay stringByAppendingString:input];
    //Refresh operation Label
    [self.operationResultDisplayLabel setText:self.upperDisplay];
    //NSLog(self.upperDisplay);
};

- (IBAction)onOperatorButtonPressed:(UIButton *)sender{
    
    NSString *input = sender.titleLabel.text;
    if(self.erase){
        [self.operationResultDisplayLabel setText:@""];
        self.erase=NO;
    }
    if(self.operator!=nil){
        if(![self.operandString isEqualToString:@""]){
            //resolve operation and reDraw
            [self onEqualsButtonPressed:sender];
            self.ansString=[NSString stringWithString:[[NSNumber numberWithFloat:[self.myCalc.ans floatValue]] stringValue]];
        }
    }else{
        self.ansString=[NSString stringWithString:[[NSNumber numberWithFloat:[self.myCalc.ans floatValue]] stringValue]];
    }
    self.upperDisplay=self.ansString;
    self.decimalMode=NO;
    self.operator=sender.titleLabel.text;
    self.upperDisplay= [self.upperDisplay stringByAppendingString:input];
    [self.operationResultDisplayLabel setText:self.upperDisplay];
    
};

- (IBAction)onClearButtonPressed:(UIButton *)sender{
    [self.myCalc reset];
    self.operand=0.0;
    [self resetVariables];
    [self.operationResultDisplayLabel setText:@""];
    [self.resultDisplayLabel setText:@"0"];
    
};

- (IBAction)onCommaButtonPressed:(UIButton *)sender{
    if(!self.decimalMode){
        self.decimalMode=YES;
        self.upperDisplay= [self.upperDisplay stringByAppendingString:sender.titleLabel.text];
        if(self.operator!=nil){
            self.operandString= [self.operandString stringByAppendingString:@"."];
        }else{
            self.ansString= [self.ansString stringByAppendingString:@"."];
            //NSLog(self.ansString);
        }
        
        [self.operationResultDisplayLabel setText:self.upperDisplay];
    }
};

- (IBAction)onEqualsButtonPressed:(UIButton *)sender {
    //if operator not null do operation, else assign operand the number builted, make operand null
    
    if(self.operator!=nil){
        if([self.operator isEqualToString:@"+"]) {
            self.currentOperation= [[AddOperation alloc]init];
        } else if([self.operator isEqualToString:@"-"]) {
            self.currentOperation= [[SubstractOperation alloc]init];
            //[self.myCalc substract:self.operand];
        } else if([self.operator isEqualToString:@"X"]) {
            self.currentOperation= [[MultiplicationOperation alloc]init];
            //[self.myCalc multiply:self.operand];
        } else if([self.operator isEqualToString:@"/"]) {
            
            if(self.operand==0.0 && ![self.operandString isEqualToString:@""]){
                self.printed=YES;
                [self.resultDisplayLabel setText:@"∞"];
            }else{
                self.currentOperation= [[DivisionOperation alloc]init];
                //[self.myCalc divide:self.operand];
            }
        }
        
    }
    [self.myCalc executeOperation:self.currentOperation withValue:self.operand];
    
    [self.history setValue:self.myCalc.ans forKey:self.upperDisplay];
    self.operand=0.0;
    [self resetVariables];
    self.erase=YES;
    self.decimalMode=NO;
    if(!self.printed){
        [self resultLabelAnimation:self.resultDisplayLabel.layer];
        [self changeLabelValue:[self.myCalc.ans floatValue]];
    }
    self.printed=NO;
}
- (IBAction)onHistoryButtonPressed:(UIButton *)sender{
    NSLog(@"History");
    for (NSString* key in self.history) {
        NSLog(@"%@ = %@ \n", key, [self.history objectForKey:key]);
    }
    /*UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"History" message:@"Last operations" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
     [alert show];*/
};


#pragma mark - Custom messages

-(void) changeLabelValue:(float) value{
    NSString * valueString= [NSString stringWithString:[[NSNumber numberWithFloat:value] stringValue]];
    [self.resultDisplayLabel setText:valueString];
}
-(void) resetVariables{
    self.upperDisplay=@"";
    self.ansString=@"";
    self.operandString=@"";
    self.operator=nil;
    
}

#pragma mark - Animations
-(void) resultLabelAnimation:(CALayer *) myLayer{
    CATransition *transitionAnimation = [CATransition animation];
    [transitionAnimation setType:kCATransitionFromBottom];
    [transitionAnimation setDuration:0.3f];
    [transitionAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [transitionAnimation setFillMode:kCAFillModeBoth];
    [myLayer addAnimation:transitionAnimation forKey:@"fadeanimation"];
}


#pragma mark - Memory

- (void)dealloc {
    [_resultDisplayLabel release];
    [_operationResultDisplayLabel release];
    [super dealloc];
}
@end
