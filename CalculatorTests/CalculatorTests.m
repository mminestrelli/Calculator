//
//  CalculatorTests.m
//  CalculatorTests
//
//  Created by Mauricio Minestrelli on 7/2/14.
//  Copyright (c) 2014 Mercadolibre. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Calculator.h"

@interface CalculatorTests : XCTestCase

@end

@implementation CalculatorTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testAddition
{
    Calculator * calc=[[Calculator alloc] init];
    [calc add:10.0];
    XCTAssertEqual([calc.ans floatValue] , 10.0, "La suma de 0 mas 10 deberia ser 10");
    [calc release];
}
-(void)testSubstraction
{
    Calculator * calc=[[Calculator alloc] init];
    [calc substract:10.0];
    XCTAssertEqual([calc.ans floatValue] , -10.0, "La resta de 0 - 10 debe ser -10");
    [calc release];
}
-(void)testMultiplication
{
    Calculator * calc=[[Calculator alloc] init];
    [calc add:10.0];
    [calc multiply:2.0];
    XCTAssertEqual([calc.ans floatValue] , 20.0, "La multiplicacion de 10 por 2 debe ser 20");
    [calc release];
}
-(void)testDivision
{
    Calculator * calc=[[Calculator alloc] init];
    [calc add:10.0];
    [calc divide:2.0];
    XCTAssertEqual([calc.ans floatValue] , 5.0, "10/2 deberia ser 5");
    [calc release];
}
-(void)testReset
{
    Calculator * calc=[[Calculator alloc] init];
    XCTAssertEqual([calc.ans floatValue] , 0.0, "Ans deberia ser 0");
    [calc release];
    
}


@end
