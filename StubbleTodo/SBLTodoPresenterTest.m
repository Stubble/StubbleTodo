#import <XCTest/XCTest.h>
#import <Stubble/SBLMock.h>
#import <ESCObservable/ESCObservable.h>
#import "SBLTodoPresenter.h"

@interface SBLTodoPresenterTest : XCTestCase {
    SBLTodoModel<ESCObservableInternal> *mockModel;
	SBLTodoView<ESCObservableInternal> *mockView;
}

@end

@implementation SBLTodoPresenterTest

- (void)setUp {
    [super setUp];
	mockModel = mock(SBLTodoModel.class);
    [mockModel escRegisterObserverProtocol:@protocol(SBLTodoModelObserver)];
	mockView = mock(SBLTodoView.class);
    [mockView escRegisterObserverProtocol:@protocol(SBLTodoViewObserver)];
}

- (void)bindTestObject {
    [SBLTodoPresenter bindWithModel:mockModel view:mockView];
}

- (void)testWhenPresenterIsCreatedThenViewTodoItemsIsSetFromModel {
    NSArray *todoItems = @[@"todo item 1", @"todo item 2"];
    
    [when(mockModel.todoItems) thenReturn:todoItems];
    
    [self bindTestObject];
    
    verifyCalled([mockView setTodoItems:todoItems]);
}

- (void)testWhenTextEnteredInViewThenModelAddTodoItemIsCalled {
    [self bindTestObject];
    
    NSString *enteredText = @"new todo item";
    
    [mockView.escNotifier textEntered:enteredText];
    
    verifyCalled([mockModel addTodoItemWithText:enteredText]);
}

- (void)testWhenTodoItemsUpdatedThenViewIsUpdated {
    [self bindTestObject];
    
    NSArray *todoItems = @[@"todo item 1", @"todo item 2"];
    
    [when(mockModel.todoItems) thenReturn:todoItems];
    [mockModel.escNotifier todoItemsUpdated];
    
    verifyCalled([mockView setTodoItems:todoItems]);
}

- (void)testWhenTodoItemDeletedInViewThenModelDeleteTodoItemIsCalled {
    [self bindTestObject];
    
    NSInteger index = arc4random();
    
    [mockView.escNotifier todoItemDeletedAtIndex:index];
    
    verifyCalled([mockModel deleteTodoItemAtIndex:index]);
}

@end
