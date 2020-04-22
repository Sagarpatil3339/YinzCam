//
//  DataService.swift
//  YinzCam
//
//  Created by Prasad Patil on 4/19/20.
//  Copyright © 2020 Prasad Patil. All rights reserved.
//

import Foundation
import UIKit

/* Handling all the Network calls */

    // Catche Object
fileprivate let imageCache = NSCache<NSString, UIImage>()

struct DataService {
    // MARK: - Properties
    enum ResultType {
        case success
        case failure
    }
    
    typealias NetworkRouterCompletion = (_ data:Data? ,_ error:Error?)->();
    
    // MARK: - Services
    
    // For Network call and handling data
    func httpRequest(request: URLRequest, completionHandler:@escaping NetworkRouterCompletion){
        
        let session = URLSession.shared;
        
        let task = session.dataTask(with: request){ (data, response, error) -> Void in
            
            guard let data = data else {
                completionHandler(nil,error);
                return;
            }
            if let response = response as? HTTPURLResponse{
                
                let Result = self.handleRsponse(response);
                
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
    
    // For handling response Code
    private func handleRsponse (_ response:HTTPURLResponse) -> ResultType {
        
        switch response.statusCode {
        case 200...299:
            return .success
        default:
            return .failure;
        }
    }
    
    // Network call for downloading images and storing in Catche
    func downloadImage(url: String, completion: @escaping (_ image: UIImage?, _ error: Error? ) -> Void) {
        let endPoint = URL(string: url)
        guard let endpointUrl = endPoint else {
            return;
        }
        if let cachedImage = imageCache.object(forKey: url as NSString) {
            completion(cachedImage, nil)
        } else {
            var request = URLRequest(url: endpointUrl);
            request.httpMethod = "GET";
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept");
            httpRequest(request: request, completionHandler: { (data, error) in
                if let error = error {
                    completion(nil, error)
                }
                if let receivedData = data {
                    DispatchQueue.main.async {
                        if let image = UIImage(data: receivedData) {
                            imageCache.setObject(image, forKey: endpointUrl.absoluteString as NSString)
                            completion(image, nil)
                        }
                    }
                }});
        }
    }
}
