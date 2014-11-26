//
//  main.m
//  app55-integration
//
//  Created by Tim Behrsin on 20/10/2013.
//  Copyright (c) 2013 App55 Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "A55Gateway.h"

#define ASYNC_BEGIN(name) dispatch_semaphore_t __SEMAPHORE##name = dispatch_semaphore_create(0);
#define ASYNC_NOTIFY(name) dispatch_semaphore_signal(__SEMAPHORE##name);
#define ASYNC_WAIT(name) while(dispatch_semaphore_wait(__SEMAPHORE##name, DISPATCH_TIME_NOW)) \
    [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode \
                             beforeDate:[NSDate dateWithTimeIntervalSinceNow:10]];

static BOOL terminating = NO;

@interface TestRunner : NSObject <NSURLConnectionDataDelegate>
@property (readonly) A55Gateway *gateway;

- (id)initWithGateway:(A55Gateway*)gateway;
- (void)start;
- (void)runTests:(NSTimer*)timer;
@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString *environment = [[[NSProcessInfo processInfo] environment] objectForKey:@"APP55_ENVIRONMENT"];
        if(environment == nil) environment = @"Development";

        NSString *apiKey = [[[NSProcessInfo processInfo] environment] objectForKey:@"APP55_API_KEY"];
        NSString *apiSecret = [[[NSProcessInfo processInfo] environment] objectForKey:@"APP55_API_SECRET"];
        
        printf("App55 %s - API Key <%s>\n\n", [environment UTF8String], [apiKey UTF8String]);
        
        environment = [environment lowercaseString];
        A55EnvironmentName environmentName;
        if([environment isEqualToString:@"development"]) environmentName = A55Development;
        else if([environment isEqualToString:@"sandbox"]) environmentName = A55Sandbox;
        else if([environment isEqualToString:@"production"]) environmentName = A55Production;
        else @throw [NSException exceptionWithName:NSInvalidArgumentException
                                            reason:[NSString stringWithFormat:
                                                    @"Invalid environment %@ specified",
                                                    environment]
                                          userInfo:nil];
        
        
        A55Gateway *gateway = [A55Gateway gatewayWithEnvironment:[A55Environment environment:environmentName]
                                                          apiKey:apiKey
                                                       apiSecret:apiSecret];
        
        
        [[[TestRunner alloc] initWithGateway:gateway] start];
        while(!terminating) {
            [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.10]];
        }
    }
    return 0;
}




@implementation TestRunner
@synthesize gateway;

- (id)initWithGateway:(A55Gateway *)_gateway {
    if(self = [self init]) {
        gateway = _gateway;
    }
    return self;
}

- (void)start {
    [NSTimer scheduledTimerWithTimeInterval:0.0 target:self selector:@selector(runTests:) userInfo:nil repeats:NO];
    
}

- (A55UserCreateResponse*)createUserWithEmail:(NSString*)_email
                                        phone:(NSString*)_phone
                                     password:(NSString*)_password
                              confirmPassword:(NSString*)_confirmPassword
                                    firstName:(NSString*)_firstName
                                     lastName:(NSString*)_lastName {

        NSDate *now = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyyMMddHHmmss"];
        
        NSString *email = _email ? _email : [NSString stringWithFormat:@"example-%@@app55.com", [formatter stringFromDate:now]];
        NSString *phone = _phone ? _phone : @"0123 456 7890";
        NSString *password = _password ? _password : @"pa55word";
        NSString *confirmPassword = _confirmPassword ? _confirmPassword : password;
        NSString *firstName = _firstName ? _firstName : @"APP";
        NSString *lastName = _lastName ? _lastName : @"USER";
        
        A55User *user = [A55User userWithEmail:email phone:phone password:password confirmPassword:confirmPassword];
        user.name = [A55Name nameWithFirstName:firstName lastName:lastName];
        
        printf("Creating user %s... ", [email UTF8String]);
        
        __block A55UserCreateResponse* response = nil;
        ASYNC_BEGIN(createUser);
        [[gateway createUser:user] send:^(A55Response *r) {
            response = (A55UserCreateResponse*)r;
            ASYNC_NOTIFY(createUser);
        } error:^(A55Exception *error) {
            @throw [NSException exceptionWithName:NSGenericException
                                           reason:[error description]
                                         userInfo:nil];
        }];
        ASYNC_WAIT(createUser);
        
        printf("DONE (user-id %d)\n", [response.user.identifier intValue]);
        
        return response;
}

- (A55UserCreateResponse*)createUser {
    return [self createUserWithEmail:nil phone:nil password:nil confirmPassword:nil firstName:nil lastName:nil];
}

- (A55UserGetResponse*)getUserWithIdentifier:(NSNumber*)identifier {
        A55User *user = [A55User userWithIdentifier:identifier];
        
        printf("Getting user %d... ", [user.identifier intValue]);
        
        __block A55UserGetResponse* response;
        ASYNC_BEGIN(getUser);
        [[gateway getUser:user] send:^(id r) {
            response = r;
            ASYNC_NOTIFY(getUser);
        } error:^(id error) {
            @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                           reason:[error description]
                                         userInfo:nil];
        }];
        ASYNC_WAIT(getUser);
        
        printf("DONE\n");
        
        return response;
}

- (A55CardCreateResponse*)createCardWithUser:(A55User*)_user ipAddress:(NSString*)ipAddress {
        A55Card *card = [A55Card cardWithHolderName:@"APP55 USER"
                                             number:@"4111111111111111"
                                             expiry:@"04/2019"
                                       securityCode:@"240"
                                            address:[A55Address addressWithStreet:@"8 Exchange Quay"
                                                                             city:@"Manchester"
                                                                       postalCode:@"M5 3EJ"
                                                                          country:@"GB"]];
        A55User *user = [A55User userWithIdentifier:_user.identifier];
        
        printf("Creating card... ");
        
        __block A55CardCreateResponse* response;
        ASYNC_BEGIN(createCard);
        [[gateway createCard:card user:user] send:^(id r) {
            response = r;
            ASYNC_NOTIFY(createCard);
        } error:^(id error) {
            @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                           reason:[error description]
                                         userInfo:nil];
        }];
        ASYNC_WAIT(createCard);
        
        printf("DONE (card-token %s)\n", [response.card.token UTF8String]);
        
        return response;
}

- (A55CardCreateResponse*)createCardWithUser:(A55User*)user {
    return [self createCardWithUser:user ipAddress:nil];
}

- (A55TransactionCreateResponse*)createTransactionWithUser:(A55User*)_user
                                                      card:(A55Card*)_card
                                                identifier:(NSString*)identifier
                                                    source:(NSString*)source
                                                      type:(NSString*)type
                                                 ipAddress:(NSString*)ipAddress
                                              errorHandler:(A55ErrorHandler)errorHandler {
        A55Card *card = [A55Card cardWithToken:_card.token];
        A55User *user = [A55User userWithIdentifier:_user.identifier];
        A55Transaction *transaction = [A55Transaction transactionWithIdentifier:identifier
                                                                         amount:@"0.10"
                                                                       currency:@"EUR"
                                                                    description:nil
                                                                           type:type];
        transaction.source = source;
        
        printf("Creating transaction... ");
        
        __block A55TransactionCreateResponse* response;
        ASYNC_BEGIN(createTransaction);
        [[gateway createTransactionWithCard:card
                                       user:user
                                transaction:transaction
                                  ipAddress:ipAddress] send:^(id r) {
            response = r;
            printf("DONE (transaction-id %s)\n", [response.transaction.identifier UTF8String]);
            ASYNC_NOTIFY(createTransaction);
        } error:^(id error) {
            if(errorHandler) {
                errorHandler(error);
                ASYNC_NOTIFY(createTransaction);
            }
            else @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                                reason:[error description]
                                              userInfo:@{ @"error": error }];
        }];
        ASYNC_WAIT(createTransaction);
        
    
        
        return response;
}


- (A55TransactionCreateResponse*)createTransactionWithUser:(A55User*)_user
                                                      card:(A55Card*)_card
                                                identifier:(NSString*)identifier
                                                    source:(NSString*)source
                                                      type:(NSString*)type
                                                 ipAddress:(NSString*)ipAddress {
    return [self createTransactionWithUser:_user card:_card identifier:identifier source:source type:type ipAddress:ipAddress errorHandler:nil];
}

- (A55TransactionCreateResponse*)createTransactionWithUser:(A55User*)user
                                                      card:(A55Card*)card
                                                 ipAddress:(NSString*)ipAddress
                                              errorHandler:(A55ErrorHandler)errorHandler {
    return [self createTransactionWithUser:user card:card identifier:nil source:nil type:nil ipAddress:ipAddress errorHandler:errorHandler];
}

- (A55TransactionCreateResponse*)createTransactionWithUser:(A55User*)user
                                                      card:(A55Card*)card
                                                 ipAddress:(NSString*)ipAddress {
    return [self createTransactionWithUser:user card:card identifier:nil source:nil type:nil ipAddress:ipAddress errorHandler:nil];
}

- (A55TransactionCreateResponse*)createAnonymousTransactionWithCard:(A55Card*)_card
                                                         identifier:(NSString*)identifier
                                                             source:(NSString*)source
                                                               type:(NSString*)type
                                                          ipAddress:(NSString*)ipAddress
                                                              email:(NSString*)email
                                                       errorHandler:(A55ErrorHandler)errorHandler {
        A55Card *card = _card ? _card : [A55Card cardWithHolderName:@"APP55 USER"
                                                           number:@"4111111111111111"
                                                           expiry:@"04/2019"
                                                     securityCode:@"240"
                                                          address:[A55Address addressWithStreet:@"8 Exchange Quay"
                                                                                           city:@"Manchester"
                                                                                     postalCode:@"M5 3EJ"
                                                                                        country:@"GB"]];
        A55User *user = [A55User userWithEmail:email];
        A55Transaction *transaction = [A55Transaction transactionWithIdentifier:identifier
                                                                         amount:@"0.10"
                                                                       currency:@"EUR"
                                                                    description:nil
                                                                           type:type];
        transaction.source = source;
        
        printf("Creating anonymous transaction... ");
        
        __block A55TransactionCreateResponse* response;
        ASYNC_BEGIN(createTransaction);
        [[gateway createTransactionWithCard:card
                                       user:user
                                transaction:transaction
                                  ipAddress:ipAddress] send:^(id r) {
            response = r;
            printf("DONE (transaction-id %s)\n", [response.transaction.identifier UTF8String]);

            ASYNC_NOTIFY(createTransaction);
        } error:^(id error) {
            if(errorHandler) {
                errorHandler(error);
                ASYNC_NOTIFY(createTransaction);
            } else @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                                reason:[error description]
                                              userInfo:@{ @"error": error }];
        }];
        ASYNC_WAIT(createTransaction);
    
        return response;
}

- (A55TransactionCommitResponse*)commitTransaction:(A55Transaction*)_transaction {
        A55Transaction *transaction = [A55Transaction transactionWithIdentifier:_transaction.identifier];
        
        printf("Committing transaction...");
        
        __block A55TransactionCommitResponse* response;
        ASYNC_BEGIN(commitTransaction);
        [[gateway commitTransaction:transaction] send:^(id r) {
            response = r;
            ASYNC_NOTIFY(commitTransaction);
        } error:^(id error) {
            @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                           reason:[error description]
                                         userInfo:nil];
        }];
        ASYNC_WAIT(commitTransaction);
        
        printf("DONE\n");
        
        return response;
}

- (A55Transaction*)multipleTransactionsWithUser:(A55User*)user card:(A55Card*)card typeArray:(NSArray*)types {
    printf("Testing transactions of types %s\n", [[types componentsJoinedByString:@", "] UTF8String]);
    A55Transaction *transaction = [A55Transaction transactionWithIdentifier:nil];
    for(NSString *type in types) {
        __block id error = nil;
        transaction = [self createTransactionWithUser:user card:card identifier:transaction.identifier source:nil type:type ipAddress:@"127.0.0.1" errorHandler:^(A55Exception *e) {
            error = e;
        }].transaction;
        if(error) return nil;
        [self commitTransaction:transaction];
    }
    return transaction;

}


- (A55Transaction*)duplicateTransactionsWithUser:(A55User*)user card:(A55Card*)card typeArray:(NSArray*)types {
    if(![self multipleTransactionsWithUser:user card:card typeArray:types]) {
        printf("EXPECTED ERROR\n");
        return nil;
    }
    
    @throw [NSException exceptionWithName:NSGenericException reason:@"No duplicate transaction" userInfo:nil];
}

- (A55Transaction*)multipleAnonymousTransactionsWithTypeArray:(NSArray*)types {
    printf("Testing transactions of types %s\n", [[types componentsJoinedByString:@", "] UTF8String]);
    A55Transaction *transaction = [A55Transaction transactionWithIdentifier:nil];
    for(NSString *type in types) {
        __block id error = nil;
        transaction = [self createAnonymousTransactionWithCard:nil
                                                    identifier:transaction.identifier
                                                        source:nil
                                                          type:type
                                                     ipAddress:@"127.0.0.1"
                                                         email:@"example@app55.com"
                                                  errorHandler:^(A55Exception *e) {
                                                      error = e;
                                                  }].transaction;
        if(error) return nil;
        [self commitTransaction:transaction];
    }
    return transaction;
    
}

- (A55Transaction*)duplicateAnonymousTransactionsWithTypeArray:(NSArray*)types {
    if(![self multipleAnonymousTransactionsWithTypeArray:types]) {
        printf("EXPECTED ERROR\n");
        return nil;
    }

    @throw [NSException exceptionWithName:NSGenericException reason:@"No duplicate transaction" userInfo:nil];
}

- (A55CardListResponse*)listCardsWithUser:(A55User*)_user {
        A55User *user = [A55User userWithIdentifier:_user.identifier];
        
        printf("Listing cards... ");
        __block A55CardListResponse* response;
        ASYNC_BEGIN(listCards);
        [[gateway listCards:user] send:^(id r) {
            response = r;
            ASYNC_NOTIFY(listCards);
        } error:^(id error) {
            @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                           reason:[error description]
                                         userInfo:nil];
        }];
        ASYNC_WAIT(listCards);
        
        printf("DONE (%lu cards)\n", (unsigned long)response.cards.count);
        
        return response;
}

- (A55CardDeleteResponse*)deleteCardsWithUser:(A55User*)_user card:(A55Card*)_card {
        A55User *user = [A55User userWithIdentifier:_user.identifier];
        A55Card *card = [A55Card cardWithToken:_card.token];
        
        printf("Deleting card %s... ", [card.token UTF8String]);
        __block A55CardDeleteResponse* response;
        ASYNC_BEGIN(deleteCards);
        [[gateway deleteCard:card user:user] send:^(id r) {
            response = r;
            ASYNC_NOTIFY(deleteCards);
        } error:^(id error) {
            @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                           reason:[error description]
                                         userInfo:nil];
        }];
        ASYNC_WAIT(deleteCards);
        
        printf("DONE\n");
        
        return response;
}

- (A55UserUpdateResponse*)updateUser:(A55User*)user {
        printf("Updating user... ");
        __block A55UserUpdateResponse* response;
        ASYNC_BEGIN(updateUser);
        [[gateway updateUser:user] send:^(id r) {
            response = r;
            ASYNC_NOTIFY(updateUser);
        } error:^(id error) {
            @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                           reason:[error description]
                                         userInfo:nil];
        }];
        ASYNC_WAIT(updateUser);
        printf("DONE\n");
        return response;
}

- (A55UserAuthenticateResponse*)authenticateUser:(A55User*)user {
        printf("Authenticating user... ");
        __block A55UserAuthenticateResponse* response;
        ASYNC_BEGIN(authenticateUser);
        [[gateway authenticateUser:user] send:^(id r) {
            response = r;
            ASYNC_NOTIFY(authenticateUser);
        } error:^(id error) {
            @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                           reason:[error description]
                                         userInfo:nil];
        }];
        ASYNC_WAIT(authenticateUser);
        printf("DONE\n");
        return response;
}

- (A55ScheduleCreateResponse*)createScheduleWithUser:(A55User*)_user card:(A55Card*)_card amount:(NSString*)amount {
        NSDate *now = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
        [formatter setDateFormat:@"yyyy-MM-dd"];

        A55User *user = [A55User userWithIdentifier:_user.identifier];
        A55Card *card = [A55Card cardWithToken:_card.token];
        A55Transaction *transaction = [A55Transaction transactionWithAmount:@"0.10" currency:@"EUR" description:@"Scheduled Transaction"];
        A55Schedule *schedule = [A55Schedule scheduleWithTimeUnit:@"daily" start:[formatter stringFromDate:now]];
        
        printf("Creating schedule... ");
        
        __block A55ScheduleCreateResponse* response;
        ASYNC_BEGIN(createSchedule);
        [[gateway createScheduleWithCard:card
                                    user:user
                             transaction:transaction
                                schedule:schedule] send:^(id r) {
            response = r;
            ASYNC_NOTIFY(createSchedule);
        } error:^(id error) {
            @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                           reason:[error description]
                                         userInfo:nil];
        }];
        ASYNC_WAIT(createSchedule);
        
        printf("DONE (schedule %d)\n", [response.schedule.identifier intValue]);
        return response;
}

- (A55ScheduleGetResponse*)getScheduleWithUser:(A55User*)_user schedule:(A55Schedule*)_schedule {
        A55User *user = [A55User userWithIdentifier:_user.identifier];
        A55Schedule *schedule = [A55Schedule scheduleWithIdentifier:_schedule.identifier];
        
        printf("Getting schedule... ");
        
        __block A55ScheduleGetResponse* response;
        ASYNC_BEGIN(getSchedule);
        [[gateway getScheduleWithUser:user
                             schedule:schedule] send:^(id r) {
            response = r;
            ASYNC_NOTIFY(getSchedule);
        } error:^(id error) {
            @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                           reason:[error description]
                                         userInfo:nil];
        }];
        ASYNC_WAIT(getSchedule);
        
        printf("DONE\n");
        return response;
}

- (A55ScheduleUpdateResponse*)updateScheduleWithUser:(A55User*)_user card:(A55Card*)_card schedule:(A55Schedule*)_schedule {
        A55User *user = [A55User userWithIdentifier:_user.identifier];
        A55Card *card = [A55Card cardWithToken:_card.token];
        A55Schedule *schedule = [A55Schedule scheduleWithIdentifier:_schedule.identifier end:_schedule.end];
        
        printf("Updating schedule... ");
        
        __block A55ScheduleUpdateResponse* response;
        ASYNC_BEGIN(updateSchedule);
        [[gateway updateScheduleWithCard:card
                                    user:user
                                schedule:schedule] send:^(id r) {
            response = r;
            ASYNC_NOTIFY(updateSchedule);
        } error:^(id error) {
            @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                           reason:[error description]
                                         userInfo:nil];
        }];
        ASYNC_WAIT(updateSchedule);
        
        printf("DONE\n");
        return response;
}

- (A55ScheduleListResponse*)listSchedules:(A55User*)_user active:(NSNumber*)active {
        A55User *user = [A55User userWithIdentifier:_user.identifier];
        
        printf("Listing schedule... ");
        
        __block A55ScheduleListResponse* response;
        ASYNC_BEGIN(listSchedules);
        [[gateway listSchedules:user active:active] send:^(id r) {
            response = r;
            ASYNC_NOTIFY(listSchedules);
        } error:^(id error) {
            @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                           reason:[error description]
                                         userInfo:nil];
        }];
        ASYNC_WAIT(listSchedules);
        
        printf("DONE (%lu schedules)\n", (unsigned long)response.schedules.count);
        return response;
}

- (A55ScheduleListResponse*)listSchedules:(A55User*)user {
    return [self listSchedules:user active:nil];
}

- (A55ScheduleDeleteResponse*)deleteSchedule:(A55User*)_user schedule:(A55Schedule*)_schedule {
        A55User *user = [A55User userWithIdentifier:_user.identifier];
        A55Schedule *schedule = [A55Schedule scheduleWithIdentifier:_schedule.identifier];
        
        printf("Delete schedule... ");
        
        __block A55ScheduleDeleteResponse* response;
        ASYNC_BEGIN(deleteSchedule);
        [[gateway deleteScheduleWithUser:user schedule:schedule] send:^(id r) {
            response = r;
            ASYNC_NOTIFY(deleteSchedule);
        } error:^(id error) {
            @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                           reason:[error description]
                                         userInfo:nil];
        }];
        ASYNC_WAIT(deleteSchedule);
        
        printf("DONE\n");
        return response;
}


- (void)runTests:(NSTimer *)timer {
    A55Transaction *transaction = [self createAnonymousTransactionWithCard:nil
                                                                identifier:nil
                                                                    source:nil
                                                                      type:nil
                                                                 ipAddress:@"127.0.0.1"
                                                                     email:nil
                                                              errorHandler:nil].transaction;
    [self commitTransaction:transaction];
    
    A55User *user = [self createUser].user;
    A55User *userCheck = [self getUserWithIdentifier:user.identifier].user;
    assert([user.identifier isEqualToNumber:userCheck.identifier]);
    assert([user.email isEqualToString:userCheck.email]);
    assert([user.name.first isEqualToString:userCheck.name.first]);
    assert([user.name.last isEqualToString:userCheck.name.last]);
    
    A55Card *card1 = [self createCardWithUser:user ipAddress:@"127.0.0.1"].card;
    transaction = [self createTransactionWithUser:user
                                             card:card1
                                        ipAddress:@"127.0.0.1"].transaction;
    [self commitTransaction:transaction];
    
    A55Card *card2 = [self createCardWithUser:user ipAddress:@"127.0.0.1"].card;
    transaction = [self createTransactionWithUser:user
                                             card:card2
                                        ipAddress:@"127.0.0.1"].transaction;
    [self commitTransaction:transaction];
    
    A55Card *card3 = [self createCardWithUser:user ipAddress:@"127.0.0.1"].card;
    transaction = [self createTransactionWithUser:user
                                             card:card3
                                        ipAddress:@"127.0.0.1"].transaction;
    [self commitTransaction:transaction];
    
    transaction = [self createAnonymousTransactionWithCard:nil
                                                identifier:nil
                                                    source:nil
                                                      type:nil
                                                 ipAddress:@"127.0.0.1"
                                                     email:nil
                                              errorHandler:nil].transaction;
    [self commitTransaction:transaction];

    
    [self multipleTransactionsWithUser:user card:card3 typeArray:[NSArray arrayWithObjects:@"auth", @"capture", @"void", nil]];
    [self multipleTransactionsWithUser:user card:card3 typeArray:[NSArray arrayWithObjects:@"auth", @"void", nil]];
    [self multipleTransactionsWithUser:user card:card3 typeArray:[NSArray arrayWithObjects:@"sale", @"void", nil]];
    [self duplicateTransactionsWithUser:user card:card3 typeArray:[NSArray arrayWithObjects:@"sale", @"sale", nil]];
    [self duplicateTransactionsWithUser:user card:card3 typeArray:[NSArray arrayWithObjects:@"sale", @"auth", nil]];
    [self duplicateTransactionsWithUser:user card:card3 typeArray:[NSArray arrayWithObjects:@"sale", @"capture", nil]];
    [self duplicateTransactionsWithUser:user card:card3 typeArray:[NSArray arrayWithObjects:@"auth", @"sale", nil]];
    [self duplicateTransactionsWithUser:user card:card3 typeArray:[NSArray arrayWithObjects:@"auth", @"sale", nil]];
    [self duplicateTransactionsWithUser:user card:card3 typeArray:[NSArray arrayWithObjects:@"auth", @"auth", nil]];
    [self duplicateTransactionsWithUser:user card:card3 typeArray:[NSArray arrayWithObjects:@"auth", @"capture", @"sale", nil]];
    [self duplicateTransactionsWithUser:user card:card3 typeArray:[NSArray arrayWithObjects:@"auth", @"capture", @"auth", nil]];
    [self duplicateTransactionsWithUser:user card:card3 typeArray:[NSArray arrayWithObjects:@"auth", @"capture", @"capture", nil]];
    [self duplicateTransactionsWithUser:user card:card3 typeArray:[NSArray arrayWithObjects:@"sale", @"void", @"void", nil]];
    [self duplicateTransactionsWithUser:user card:card3 typeArray:[NSArray arrayWithObjects:@"auth", @"void", @"void", nil]];
    [self duplicateTransactionsWithUser:user card:card3 typeArray:[NSArray arrayWithObjects:@"auth", @"capture", @"void", @"void", nil]];
    if([self multipleTransactionsWithUser:user card:card3 typeArray:[NSArray arrayWithObjects:@"capture", nil]])
        @throw [NSException exceptionWithName:NSGenericException reason:@"Payment was authorised" userInfo:nil];
    if([self multipleTransactionsWithUser:user card:card3 typeArray:[NSArray arrayWithObjects:@"void", nil]])
        @throw [NSException exceptionWithName:NSGenericException reason:@"Payment was authorised" userInfo:nil];
    
    [self multipleAnonymousTransactionsWithTypeArray:[NSArray arrayWithObjects:@"auth", @"capture", @"void", nil]];
    [self multipleAnonymousTransactionsWithTypeArray:[NSArray arrayWithObjects:@"auth", @"void", nil]];
    [self multipleAnonymousTransactionsWithTypeArray:[NSArray arrayWithObjects:@"sale", @"void", nil]];
    [self duplicateAnonymousTransactionsWithTypeArray:[NSArray arrayWithObjects:@"sale", @"sale", nil]];
    [self duplicateAnonymousTransactionsWithTypeArray:[NSArray arrayWithObjects:@"sale", @"auth", nil]];
    [self duplicateAnonymousTransactionsWithTypeArray:[NSArray arrayWithObjects:@"sale", @"capture", nil]];
    [self duplicateAnonymousTransactionsWithTypeArray:[NSArray arrayWithObjects:@"auth", @"sale", nil]];
    [self duplicateAnonymousTransactionsWithTypeArray:[NSArray arrayWithObjects:@"auth", @"sale", nil]];
    [self duplicateAnonymousTransactionsWithTypeArray:[NSArray arrayWithObjects:@"auth", @"auth", nil]];
    [self duplicateAnonymousTransactionsWithTypeArray:[NSArray arrayWithObjects:@"auth", @"capture", @"sale", nil]];
    [self duplicateAnonymousTransactionsWithTypeArray:[NSArray arrayWithObjects:@"auth", @"capture", @"auth", nil]];
    [self duplicateAnonymousTransactionsWithTypeArray:[NSArray arrayWithObjects:@"auth", @"capture", @"capture", nil]];
    [self duplicateAnonymousTransactionsWithTypeArray:[NSArray arrayWithObjects:@"sale", @"void", @"void", nil]];
    [self duplicateAnonymousTransactionsWithTypeArray:[NSArray arrayWithObjects:@"auth", @"void", @"void", nil]];
    [self duplicateAnonymousTransactionsWithTypeArray:[NSArray arrayWithObjects:@"auth", @"capture", @"void", @"void", nil]];
    if([self multipleAnonymousTransactionsWithTypeArray:[NSArray arrayWithObjects:@"capture", nil]])
        @throw [NSException exceptionWithName:NSGenericException reason:@"Payment was authorised" userInfo:nil];
    if([self multipleAnonymousTransactionsWithTypeArray:[NSArray arrayWithObjects:@"void", nil]])
        @throw [NSException exceptionWithName:NSGenericException reason:@"Payment was authorised" userInfo:nil];

    NSDate *tomorrow = [NSDate dateWithNaturalLanguageString:@"tomorrow"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    A55Schedule *schedule1 = [self createScheduleWithUser:user card:card1 amount:@"0.10"].schedule;
    sleep(5);
    A55Schedule *schedule = [self getScheduleWithUser:user schedule:schedule1].schedule;
    assert(schedule.end == nil);
    assert([schedule.next isEqualToString:[formatter stringFromDate:tomorrow]]);
    assert([schedule.units isEqualToNumber:[NSNumber numberWithInt:1]]);
    [self updateScheduleWithUser:user card:card2 schedule:[A55Schedule scheduleWithIdentifier:schedule.identifier end:[formatter stringFromDate:tomorrow]]];
    A55ScheduleGetResponse *response = [self getScheduleWithUser:user schedule:schedule];
    assert([response.schedule.end isEqualToString:[formatter stringFromDate:tomorrow]]);
    assert([response.card.token isEqualToString:card2.token]);
    A55Schedule *schedule2 = [self createScheduleWithUser:user card:card1 amount:@"0.11"].schedule;
    A55Schedule *schedule3 = [self createScheduleWithUser:user card:card3 amount:@"0.12"].schedule;
    NSArray *schedules = [self listSchedules:user].schedules;
    NSArray *aSchedule1 = [schedules filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self.id == %@", schedule1.identifier]];
    assert(aSchedule1.count == 1);
    NSArray *aSchedule2 = [schedules filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self.id == %@", schedule2.identifier]];
    assert(aSchedule2.count == 1);
    NSArray *aSchedule3 = [schedules filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self.id == %@", schedule3.identifier]];
    assert(aSchedule3.count == 1);
    assert(schedules.count == 3);
    [self deleteSchedule:user schedule:schedule1];
    [self deleteSchedule:user schedule:schedule2];
    [self deleteSchedule:user schedule:schedule3];
    assert([self listSchedules:user].schedules.count == 3);
    assert([self listSchedules:user active:[NSNumber numberWithBool:YES]].schedules.count == 0);
    
    NSArray *cards = [self listCardsWithUser:user].cards;
    NSArray *aCard1 = [cards filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self.token == %@", card1.token]];
    assert(aCard1.count == 1);
    NSArray *aCard2 = [cards filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self.token == %@", card2.token]];
    assert(aCard2.count == 1);
    NSArray *aCard3 = [cards filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self.token == %@", card3.token]];
    assert(aCard3.count == 1);
    
    [self deleteCardsWithUser:user card:card1];
    [self deleteCardsWithUser:user card:card2];
    [self deleteCardsWithUser:user card:card3];
    
    assert([self listCardsWithUser:user].cards.count == 0);
    
    
    NSDate *now = [NSDate date];
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    
    NSString *email = [NSString stringWithFormat:@"example-%@@app55.com", [formatter stringFromDate:now]];
    [self updateUser:[A55User userWithIdentifier:user.identifier email:email password:@"password01" confirmPassword:@"password01"]];
    
    A55User *user2 = [self authenticateUser:[A55User userWithEmail:email password:@"password01"]].user;
    assert([user.identifier isEqualToNumber:user2.identifier]);
    
    terminating = YES;
}


@end

