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
    NSString * _lastOperationString;
    NSMutableDictionary * _history;
    NSNumberFormatter * _numberFormatter;
    BOOL _commaYetPressed;
    BOOL _erase;
    id<Operation> _operation;
    id<Operation> _lastOperation;

}
    @property (nonatomic,strong) NSNumber * firstOperand;
    @property (nonatomic,strong) NSNumber * secondOperand;
    @property (nonatomic,strong) NSNumber * lastSecondOperand;
    @property (nonatomic,strong) NSNumberFormatter * numberFormatter;
    @property (nonatomic,copy) NSString * lastOperationString;
    @property (nonatomic,copy) NSString * operandString;
    @property (nonatomic) BOOL commaYetPressed;
    @property (nonatomic) BOOL erase;
    @property (nonatomic,strong) NSMutableDictionary * history;
    @property (nonatomic,strong) id<Operation> operation;
    @property (nonatomic,strong) id<Operation> lastOperation;



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


-(void) commaPressed{
    if(!self.commaYetPressed){
        self.commaYetPressed=YES;
        self.operandString= [self.operandString stringByAppendingString:@"."];
    }
    self.lastOperationString=[self.lastOperationString stringByAppendingString:@"."];
    [self.delegate onDisplayChange:self.lastOperationString withResult:self.ans];
}

-(void)numberPressed:(NSString *)number{
    if(![number isEqualToString:@"0"] || ! [self.operandString isEqualToString:@"0"]){
        self.operandString= [self.operandString stringByAppendingString:number];
        
        self.lastOperationString=[self.lastOperationString stringByAppendingString:number];
    }
    if(self.operation!=nil){
        self.secondOperand=[NSNumber numberWithFloat:[self.operandString floatValue]];
    }else{
        self.firstOperand=[NSNumber numberWithFloat:[self.operandString floatValue]];
    }
    
    [self.delegate onDisplayChange:self.lastOperationString withResult:self.ans];
}

-(void)operationPressed:(id<Operation>)oper{
    if(self.operation!=nil && self.secondOperand!=nil){
        [self executeOperation];
        self.firstOperand=self.ans;
    }
    self.erase=YES;
    self.operation=oper;
    self.commaYetPressed=NO;
    self.operandString=@"";
    self.lastOperationString=[self.lastOperationString stringByAppendingString:[oper operationString] ];
    [self.delegate onDisplayChange:self.lastOperationString withResult:self.ans];
};

-(NSString*) lastOperationPerformed{
    NSString * operationDetail=@"";

    if(self.firstOperand!=nil){
        operationDetail= [operationDetail stringByAppendingString: [self.numberFormatter stringFromNumber:[NSNumber numberWithFloat:[self.firstOperand floatValue]]]];}
    else{
        if(self.erase){
            
            operationDetail= [operationDetail stringByAppendingString: [self.numberFormatter stringFromNumber:[NSNumber numberWithFloat:[self.ans floatValue]]]];
        }
    }
    
    if(self.operation!=nil){
        operationDetail= [operationDetail stringByAppendingString:[self.operation operationString]];
    }
    
    if(self.secondOperand!=nil){
        operationDetail= [operationDetail stringByAppendingString: [self.numberFormatter stringFromNumber:[NSNumber numberWithFloat:[self.secondOperand floatValue]]]];
    }
    self.lastOperationString=operationDetail;
    [self.delegate onDisplayChange:operationDetail withResult:self.ans];
    return operationDetail;
};


-(void) executeOperation{
    
    if(self.operation==nil && self.secondOperand==nil && self.firstOperand!=nil){
        self.ans=self.firstOperand;
    }else if(self.operation==nil && self.secondOperand==nil && self.firstOperand==nil){
        self.firstOperand=self.ans;
        self.secondOperand=self.lastSecondOperand;
        self.operation=self.lastOperation;
        
    }
        
    if(self.operation!=nil && self.secondOperand!=nil )
    {
        NSString * operationDetail= [self lastOperationPerformed];
        
        if(self.firstOperand==nil){
            self.firstOperand=self.ans;
        }
        self.ans=[NSNumber numberWithFloat:[self.operation operate:[self.firstOperand floatValue]  with:[self.secondOperand floatValue]]];
        [self.history setValue:[self.numberFormatter stringFromNumber:[NSNumber numberWithFloat:[self.ans floatValue]]] forKey:operationDetail];
    }
    self.lastSecondOperand=self.secondOperand;
    self.lastOperation=self.operation;
    [self.delegate onDisplayChange:self.lastOperationString withResult:self.ans];
    [self setVariablesInNil];
}

-(void) printHistory{
    NSLog(@"History");
    for (NSString* key in self.history) {
        NSLog(@"%@ = %@ \n", key, [self.history objectForKey:key]);
    }
}

-(void)reset{
    self.ans = [[NSNumber alloc]initWithFloat:0];
    [self setVariablesInNil];
    [self.delegate onDisplayChange:self.lastOperationString withResult:self.ans];
}

-(void) setVariablesInNil{
    self.firstOperand=nil;
    self.secondOperand=nil;
    self.operation=nil;
    self.operandString=@"";
    self.lastOperationString=@"";
    self.commaYetPressed=NO;
    self.erase=NO;
}



@end
