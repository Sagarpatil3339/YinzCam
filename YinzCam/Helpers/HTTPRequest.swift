//
//  HTTPRequest.swift
//  YinzCam
//
//  Created by Prasad Patil on 4/19/20.
//  Copyright © 2020 Prasad Patil. All rights reserved.
//

import Foundation
enum ResultType {
    case success
    case failure
}

private func handleRsponse (_ response:HTTPURLResponse) -> ResultType {
    
    switch response.statusCode {
    case 200...299:
        return .success
    default:
        return .failure;
    }
    
}
typealias NetworkRouterCompletion = (_ data:Data? ,_ error:Error?)->();

func httpRequest(request: URLRequest, completionHandler:@escaping NetworkRouterCompletion){
    
    let session = URLSession.shared;
    
    let task = session.dataTask(with: request){ (data, response, error) -> Void in
        
        guard let data = data else {
            completionHandler(nil,error);
            return;
        }
        if let response = response as? HTTPURLResponse{
            
            let Result = handleRsponse(response);
            
            switch Result{
            case .success:
                completionHandler(data,nil);
                break;
            case .failure:
                completionHandler(nil,error);
                break;
            }
        }
    }
    task.resume();
    
}
