//
//  DeezerSession.m
//  Deezer
//
//  Created by Rems on 18/01/2014.
//  Copyright (c) 2014 RemiLavedrine. All rights reserved.
//

#import "DeezerSession.h"

// Singleton
static DeezerSession * theDeezerSession = nil;

@implementation DeezerSession


#pragma mark - Shared Instance

/**
 @brief Create or return the shared instance. Register to quit app notifications.
 @author : Rémi Lavedrine
 @date : 25/04/12
 @remarks : <#(optional)#>
 */
+ (DeezerSession *)sharedInstance {
    if(theDeezerSession == nil) {
        theDeezerSession = [[DeezerSession alloc] init];
    }
    
    return theDeezerSession;
}


#pragma mark - Search Artist

#define kBaseDeezerApiUrl @"http://api.deezer.com/"

/**
 @brief Search all the artists from the given NSString.
 @author : Rémi Lavedrine
 @date : 18/01/2014
 @param :
 request : The URL request to load. The request object is deep-copied as part of the initialization process. Changes made to request after this method returns do not affect the request that is used for the loading process.
 queue : The operation queue to which the handler block is dispatched when the request completes or failed.
 handler : The handler block to execute.
 @discussion : If the request completes successfully, the data parameter of the handler block contains the resource data, and the error parameter is nil. If the request fails, the data parameter is nil and the error parameter contain information about the failure.
 @remarks : <#(optional)#>
 */
- (void)searchAsynchronouslyArtist:(NSString *)artistName
                 completionHandler:(SearchActionCompletionBlock)completionHandler {
    NSURLRequest *r = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@search/artist?q=%@", kBaseDeezerApiUrl, artistName]]];

    [NSURLConnection sendAsynchronousRequest:r
                                       queue:[NSOperationQueue currentQueue]
                           completionHandler:completionHandler];
}


#pragma mark - Search Artist Album

/**
 @brief Search all the album for an given artist id.
 @author : Rémi Lavedrine
 @date : 18/01/2014
 @param :
 request : The URL request to load. The request object is deep-copied as part of the initialization process. Changes made to request after this method returns do not affect the request that is used for the loading process.
 queue : The operation queue to which the handler block is dispatched when the request completes or failed.
 handler : The handler block to execute.
 @discussion : If the request completes successfully, the data parameter of the handler block contains the resource data, and the error parameter is nil. If the request fails, the data parameter is nil and the error parameter contain information about the failure.
 @remarks : <#(optional)#>
 */
- (void)searchAsynchronouslyArtistAlbum:(NSString *)artistId
            completionHandler:(SearchActionCompletionBlock)completionHandler {
    NSURLRequest *r = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@artist/%@/albums", kBaseDeezerApiUrl, artistId]]];
    
    [NSURLConnection sendAsynchronousRequest:r
                                       queue:[NSOperationQueue currentQueue]
                           completionHandler:completionHandler];
}


#pragma mark - Search Album Tracks

/**
 @brief Search all the tracks for an given album id.
 @author : Rémi Lavedrine
 @date : 18/01/2014
 @param :
 request : The URL request to load. The request object is deep-copied as part of the initialization process. Changes made to request after this method returns do not affect the request that is used for the loading process.
 queue : The operation queue to which the handler block is dispatched when the request completes or failed.
 handler : The handler block to execute.
 @discussion : If the request completes successfully, the data parameter of the handler block contains the resource data, and the error parameter is nil. If the request fails, the data parameter is nil and the error parameter contain information about the failure.
 @remarks : <#(optional)#>
 */
- (void)searchAsynchronouslyAlbumTracks:(NSString *)albumId
        completionHandler:(SearchActionCompletionBlock)completionHandler {
    NSURLRequest *r = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@album/%@", kBaseDeezerApiUrl, albumId]]];
    
    [NSURLConnection sendAsynchronousRequest:r
                                       queue:[NSOperationQueue currentQueue]
                           completionHandler:completionHandler];
}


@end
