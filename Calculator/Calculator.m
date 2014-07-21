//
//  Calculator.m
//  Calculator
//
//  Created by Mauricio Minestrelli on 7/2/14.
//  Copyright (c) 2014 Mercadolibre. All rights reserved.
//

#import "Calculator.h"

@interface Calculator(){
    NSNumber * _firstOperand;
    NSNumber * _secondOperand;
    NSNumber * _lastSecondOperand;
    NSNumber * _ans;
    NSString * _operandString;
    NSMutableDictionary * _history;
    NSNumberFormatter * _numberFormatter;
    BOOL _commaYetPressed;
    BOOL _firstOperandDerivated;
    id<OperationDelegate> _operation;
    id<OperationDelegate> _lastOperation;

}
    //First operand of a binary operation
    @property (nonatomic,strong) NSNumber * firstOperand;
    //Second Operand of a binary operation
    @property (nonatomic,strong) NSNumber * secondOperand;
    //Second operand used in the last excuted operation to allow the user to repeat the operation
    @property (nonatomic,strong) NSNumber * lastSecondOperand;
    //User number formatting preferences
    @property (nonatomic,strong) NSNumberFormatter * numberFormatter;
    //Current operator 
    @property (nonatomic,copy) NSString * operandString;
    //Indicates wheter comma has been pressed in the current operand or not
    @property (nonatomic) BOOL commaYetPressed;
    //Indicates wheter first operand was written by the user or is derivated from the last operation executed result
    @property (nonatomic) BOOL firstOperandDerivated;
    //History of operations done in the last session.
    @property (nonatomic,strong) NSMutableDictionary * history;
    //Current binary operation to execute
    @property (nonatomic,strong) id<OperationDelegate> operation;
    //Last operation executed used to allow the user to repeat the operation
    @property (nonatomic,strong) id<OperationDelegate> lastOperation;



@end

@implementation Calculator

-(id) init{
    if([super init]){
        self.ans = [NSNumber numberWithFloat:0.0];
        self.history= [[NSMutableDictionary alloc]init];
        self.numberFormatter = [[NSNumberFormatter alloc] init];
        [self.numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [self setVariablesInNil];
    }
    return self;
}

/* Appends the comma to the current operand if it wasn't pressed before, notifies value update*/
-(void) commaPressed{
    if(!self.commaYetPressed){
        self.commaYetPressed=YES;
        self.operandString= [self.operandString stringByAppendingString:@"."];
    }

    [self calculateFormulaAndNotify];
}

/*Sets the number pressed on the corresponding operand according to the value of the variable operation*/
-(void)numberPressed:(NSString *)number{
    if(![number isEqualToString:@"0"] || ! [self.operandString isEqualToString:@"0"]){
        self.operandString= [self.operandString stringByAppendingString:number];
    }
    if(self.operation!=nil){
        self.secondOperand=[NSNumber numberWithFloat:[self.operandString floatValue]];
    }else{
        self.firstOperand=[NSNumber numberWithFloat:[self.operandString floatValue]];
        self.firstOperandDerivated=NO;
    }
    [self calculateFormulaAndNotify];
}

/* Saves the current operation,in case of having an executable operation (first operand,operation and operand)
 first execute */
-(void)operationPressed:(id<OperationDelegate>)oper{
    if(self.operation!=nil && self.secondOperand!=nil){
        [self executeOperation];
        self.firstOperand=self.ans;
        self.firstOperandDerivated=YES;
    }
    if(self.firstOperand==nil && self.secondOperand==nil){
        self.firstOperandDerivated=YES;
    }
    self.operation=oper;
    self.commaYetPressed=NO;
    self.operandString=@"";
    [self calculateFormulaAndNotify];
};

/*Caculates the current formula and notifies*/
-(NSString*) calculateFormulaAndNotify{
    NSString * formula=@"";
    NSString * ans=@"";

    if(self.firstOperand!=nil && !self.firstOperandDerivated){
        formula= [formula stringByAppendingString: [self.numberFormatter stringFromNumber:[NSNumber numberWithFloat:[self.firstOperand floatValue]]]];
    }
    else{
        if(self.firstOperandDerivated){
        formula= [formula stringByAppendingString: @"Ans"];
        }
    }
    
    if(self.operation!=nil){
        formula= [formula stringByAppendingString:[self.operation operationString]];
    }
    
    if(self.secondOperand!=nil){
        formula= [formula stringByAppendingString: [self.numberFormatter stringFromNumber:[NSNumber numberWithFloat:[self.secondOperand floatValue]]]];
    }
    
    if(self.ans!=nil){
        ans=[ ans stringByAppendingString:[self.numberFormatter stringFromNumber:self.ans]];
    }
    [self.delegate onValueUpdate:formula withResult:ans];
    return formula;
};

/*Executes the binary operation between the first operand and the second operand. If the user
 only inserts the first operand and executes the operation ans loads firstOperand. 
 If the user executes the operation and no operators or operation is saved, it´s asummed that
 the user wants to re-execute the last operation based on the last ans (firstOperand) and the
 lastSecondOperand and lastOperation.
 */
-(void) executeOperation{
    
    if(self.operation==nil && self.secondOperand==nil && self.firstOperand!=nil){
        self.ans=self.firstOperand;
    }else if(self.operation==nil && self.secondOperand==nil && self.firstOperand==nil){
        self.firstOperand=self.ans;
        self.firstOperandDerivated=YES;
        self.secondOperand=self.lastSecondOperand;
        self.operation=self.lastOperation;
        
    }
        
    if(self.operation!=nil && self.secondOperand!=nil )
    {
        NSString * operationDetail= [self calculateFormulaAndNotify];
        
        if(self.firstOperand==nil){
            self.firstOperand=self.ans;
            self.firstOperandDerivated=YES;
        }
        self.ans=[NSNumber numberWithFloat:[self.operation operate:[self.firstOperand floatValue]  with:[self.secondOperand floatValue]]];
        [self.history setValue:[self.numberFormatter stringFromNumber:[NSNumber numberWithFloat:[self.ans floatValue]]] forKey:operationDetail];
        
    }
    self.lastSecondOperand=self.secondOperand;
    self.lastOperation=self.operation;
    [self calculateFormulaAndNotify];
    [self setVariablesInNil];
}

/* Logs the history of operations done in the last session*/
-(void) printHistory{
    NSLog(@"History");
    for (NSString* key in self.history) {
        NSLog(@"%@ = %@ \n", key, [self.history objectForKey:key]);
    }
}

/* Resets calculator variables and notifies value update */
-(void)reset{
    self.ans = [[NSNumber alloc]initWithFloat:0];
    [self setVariablesInNil];
    self.firstOperandDerivated=NO;
    [self calculateFormulaAndNotify];
}

-(void) setVariablesInNil{
    self.firstOperand=nil;
    self.secondOperand=nil;
    self.operation=nil;
    self.operandString=@"";
    self.commaYetPressed=NO;
}



@end
