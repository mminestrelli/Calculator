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
    float operand;
    int intPart;
    int decimal;
    NSString * operator;
    NSString * upperDisplay;
    NSString * ansString;
    NSString * operandString;
    Boolean decimalMode;
    Boolean erase;
    Boolean printed;
    Calculator * myCalc;
    NSDictionary * history;
    
}

@end

@implementation CalculatorViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        myCalc=[[Calculator alloc]init];
        [self resetVariables];
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
    if(erase){
        [self.operationResultDisplayLabel setText:@""];
        erase=NO;
    }
    if(operator!= nil){
        //The number is part of the operand
        //NSLog(operandString);
        operandString= [operandString stringByAppendingString:input];
        //NSLog(operandString);
        operand=[operandString floatValue];
        //NSLog(operandString);
        
    }else{
        //The number is part of ans
        //NSLog(ansString);
        ansString= [ansString stringByAppendingString:input];
         //NSLog(ansString);
        [myCalc setAns:[NSNumber numberWithFloat:[ansString floatValue]]];
        //NSLog(ansString);
    }
    upperDisplay= [upperDisplay stringByAppendingString:input];
    //Refresh operation Label
    [self.operationResultDisplayLabel setText:upperDisplay];
    //NSLog(upperDisplay);
     };

- (IBAction)onOperatorButtonPressed:(UIButton *)sender{

    NSString *input = sender.titleLabel.text;
    if(erase){
        [self.operationResultDisplayLabel setText:@""];
        erase=NO;
    }
    if(operator!=nil){
        if(![operandString isEqualToString:@""]){
            upperDisplay=ansString;
        }
    }else{
        ansString=[NSString stringWithFormat:@"%f",[myCalc.ans floatValue]];
        upperDisplay=ansString;
    }
    decimalMode=NO;
    operator=sender.titleLabel.text;
    upperDisplay= [upperDisplay stringByAppendingString:input];
    [self.operationResultDisplayLabel setText:upperDisplay];
    
};

- (IBAction)onClearButtonPressed:(UIButton *)sender{
    [myCalc reset];
    operand=0.0;
    [self resetVariables];
    [self.operationResultDisplayLabel setText:@""];
    [self.resultDisplayLabel setText:@"0"];
    
};

- (IBAction)onCommaButtonPressed:(UIButton *)sender{
    if(!decimalMode){
        decimalMode=YES;
        upperDisplay= [upperDisplay stringByAppendingString:sender.titleLabel.text];
        if(operator!=nil){
            //operandString= [operandString stringByAppendingString:@"."];
        }else{
            //ansString= [ansString stringByAppendingString:@"."];
             //NSLog(ansString);
        }
        
        [self.operationResultDisplayLabel setText:upperDisplay];
    }
};

- (IBAction)onEqualsButtonPressed:(UIButton *)sender {
    //if operator not null do operation, else assign operand the number builted, make operand null
    
    if(operator!=nil){
        if([operator isEqualToString:@"+"]) {
            [myCalc add:operand];
        } else if([operator isEqualToString:@"-"]) {
            [myCalc substract:operand];
        } else if([operator isEqualToString:@"X"]) {
            [myCalc multiply:operand];
        } else if([operator isEqualToString:@"/"]) {
            if(operand==0.0 && ![operandString isEqualToString:@""]){
                printed=YES;
                [self.resultDisplayLabel setText:@"∞"];
            }else{
                [myCalc divide:operand];
            }
        }

    }
    [history setValue:[NSString stringWithFormat:@"%f",[myCalc.ans floatValue]] forKey:upperDisplay];
    operand=0.0;
    [self resetVariables];
    erase=YES;
    decimalMode=NO;
    if(!printed){
        [self changeLabelValue:[myCalc.ans floatValue]];
    }
    printed=NO;
}
- (IBAction)onHistoryButtonPressed:(UIButton *)sender{
    NSLog(@"@");
    for (NSString* key in history) {
        NSLog(@"key: %@, value: %@ \n", key, [history objectForKey:key]);
    }
};


#pragma mark - Custom messages
-(void) changeLabelValue:(float) value{
    NSString *valueString = [NSString stringWithFormat:@"%f",value];
    [self.resultDisplayLabel setText:valueString];
}
-(void) resetVariables{
    upperDisplay=@"";
    ansString=@"";
    operandString=@"";
    operator=nil;
    
}
- (void)dealloc {
    [_resultDisplayLabel release];
    [_operationResultDisplayLabel release];
    [super dealloc];
}
@end
