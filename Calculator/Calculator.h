//
//  Calculator.h
//  Calculator
//
//  Created by Mauricio Minestrelli on 7/2/14.
//  Copyright (c) 2014 Mercadolibre. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OperationDelegate.h"
#import "CalculatorDelegate.h"


@interface Calculator : NSObject
@property (nonatomic,strong) NSNumber * ans;
@property (nonatomic,assign) id<CalculatorDelegate> delegate;

-(void)operationPressed:(id<OperationDelegate>)operation;
-(NSString *) calculateFormulaAndNotify;
-(void) numberPressed:(NSString *) number;
-(void) commaPressed;
-(void)reset;
-(void) printHistory;
-(void) executeOperation;

@end
