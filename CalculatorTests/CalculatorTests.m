//
//  CalculatorTests.m
//  CalculatorTests
//
//  Created by Mauricio Minestrelli on 7/2/14.
//  Copyright (c) 2014 Mercadolibre. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Calculator.h"
#import "Operation.h"

#import "AddOperation.h"
#import "SubstractOperation.h"
#import "MultiplicationOperation.h"
#import "DivisionOperation.h"

@interface CalculatorTests : XCTestCase{
}

@property(strong,nonatomic) id<OperationDelegate> operation;
@property(strong,nonatomic) Calculator* calc;
@end

@implementation CalculatorTests

- (void)setUp
{
    [super setUp];
    self.calc=[[Calculator alloc] init];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testAddition
{
    self.operation= [[AddOperation alloc]init];
    [self.calc operationPressed:self.operation];
    [self.calc numberPressed:@"1"];
    [self.calc numberPressed:@"0"];
    [self.calc executeOperation];
    XCTAssertEqual([self.calc.ans floatValue] , 10.0, "La suma de 0 mas 10 deberia ser 10");
}

-(void)testMultipleAddition
{
    self.operation= [[AddOperation alloc]init];
    [self.calc operationPressed:self.operation];
    [self.calc numberPressed:@"1"];
    [self.calc numberPressed:@"0"];
    self.operation= [[AddOperation alloc]init];
    [self.calc operationPressed:self.operation];
    [self.calc numberPressed:@"1"];
    [self.calc numberPressed:@"0"];
    [self.calc executeOperation];
    XCTAssertEqual([self.calc.ans floatValue] , 20.0, "La suma de 0 mas 10 deberia ser 10");
}

-(void)testCommaOperation
{
    CGFloat n=10.7;
    self.operation= [[AddOperation alloc]init];
    [self.calc operationPressed:self.operation];
    [self.calc numberPressed:@"1"];
    [self.calc numberPressed:@"0"];
    [self.calc commaPressed];
    [self.calc numberPressed:@"7"];
    [self.calc printOperandString];
    [self.calc printHistory];
    [self.calc executeOperation];
    XCTAssertEqual([self.calc.ans floatValue] , n, "La suma de 0 mas 10 deberia ser 10");
}

-(void)testMultipleCommaOperation
{
    
    CGFloat n=10.7;
    self.operation= [[AddOperation alloc]init];
    [self.calc operationPressed:self.operation];
    [self.calc numberPressed:@"1"];
    [self.calc numberPressed:@"0"];
    [self.calc commaPressed];
    [self.calc commaPressed];
    [self.calc commaPressed];
    [self.calc numberPressed:@"7"];
    
    [self.calc executeOperation];
    XCTAssertEqual([self.calc.ans floatValue] , n, "La suma de 0 mas 10 deberia ser 10");
}
-(void)testSubstraction
{
    self.operation= [[SubstractOperation alloc]init];
    [self.calc operationPressed:self.operation];
    [self.calc numberPressed:@"1"];
    [self.calc numberPressed:@"0"];
    [self.calc executeOperation];
    XCTAssertEqual([self.calc.ans floatValue] , -10.0, "La resta de 0 mas 10 deberia ser -10");
}

-(void)testMultiplication
{
    self.operation= [[MultiplicationOperation alloc]init];
    [self.calc numberPressed:@"1"];
    [self.calc numberPressed:@"0"];
    [self.calc operationPressed:self.operation];
    [self.calc numberPressed:@"1"];
    [self.calc numberPressed:@"0"];
    [self.calc executeOperation];
    XCTAssertEqual([self.calc.ans floatValue] , 100.0, "La multiplicacion de 10 por 10 deberia ser 100");
}

-(void)testNestedMultiplication
{
    [self testMultiplication];
    self.operation= [[MultiplicationOperation alloc]init];
    [self.calc operationPressed:self.operation];
    [self.calc numberPressed:@"1"];
    [self.calc numberPressed:@"0"];
    [self.calc executeOperation];
    XCTAssertEqual([self.calc.ans floatValue] , 1000.0, "La multiplicacion de 10 por 10 deberia ser 100");
}
-(void)testDivision
{
    [self.calc numberPressed:@"1"];
    [self.calc numberPressed:@"0"];
    self.operation= [[DivisionOperation alloc]init];
    [self.calc operationPressed:self.operation];
    [self.calc numberPressed:@"2"];
    [self.calc executeOperation];
    XCTAssertEqual([self.calc.ans floatValue] , 5.0, "La division de 10 con 2 deberia ser 5");
}
-(void)testReset
{
    XCTAssertEqual([self.calc.ans floatValue] , 0.0, "Ans deberia ser 0");
}



@end
