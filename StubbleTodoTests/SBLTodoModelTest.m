#import <XCTest/XCTest.h>
#import <Stubble/SBLMock.h>
#import "SBLTodoModel.h"

@interface SBLTodoModelTest : XCTestCase {
    SBLTodoModel *testObject;
    id<SBLTodoModelObserver> mockObserver;
}

@end

@implementation SBLTodoModelTest

- (void)setUp {
    [super setUp];
    testObject = [[SBLTodoModel alloc] init];
    mockObserver = mock(@protocol(SBLTodoModelObserver));
    [testObject escAddObserver:mockObserver];
}

- (void)testWhenModelAddsTodoItemWithTextCalledThenTodoItemsAreUpdated {
    NSString *todoItem1 = @"todo item one";
    NSString *todoItem2 = @"todo item two";
    
    [testObject addTodoItemWithText:todoItem1];

    NSArray *expected = @[todoItem1];
    XCTAssertEqualObjects(testObject.todoItems, expected);
    
    [testObject addTodoItemWithText:todoItem2];
    
    expected = @[todoItem2, todoItem1];
    XCTAssertEqualObjects(testObject.todoItems, expected);
}


- (void)testWhenModelAddsTodoItemThenObserverIsNotified {
    [testObject addTodoItemWithText:@"new todo item"];
    verifyCalled([mockObserver todoItemsUpdated]);
}

- (void)testWhenModelDeletesTodoItemThenTodoItemsAreUpdated {
    NSString *todoItem1 = @"todo item one";
    NSString *todoItem2 = @"todo item two";
    
    [testObject addTodoItemWithText:todoItem1];
    [testObject addTodoItemWithText:todoItem2];
    
    [testObject deleteTodoItemAtIndex:1];
    
    NSArray *expected = @[todoItem2];
    XCTAssertEqualObjects(testObject.todoItems, expected);
}

- (void)testWhenModelDeletesTodoItemThenObserverIsNotified {
    NSString *todoItem1 = @"todo item one";
    
    [testObject addTodoItemWithText:todoItem1];
    
    resetMock(mockObserver);
    
    [testObject deleteTodoItemAtIndex:0];
    verifyCalled([mockObserver todoItemsUpdated]);
}

@end
