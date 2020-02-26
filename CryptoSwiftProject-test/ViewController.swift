//
//  ViewController.swift
//  CryptoSwiftProject-test
//
//  Created by Aneesh Prabu on 28/10/19.
//  Copyright © 2019 Aneesh Prabu. All rights reserved.
//

import UIKit
import CryptoSwift

class ViewController: UIViewController {
    
    let input: ArraySlice<UInt8> = [0,1,2,3,4,5,6,7,8,9]
    let key: Array<UInt8> = [0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00]
    var encrypted:[UInt8]?
    var tag:Any?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //MARK: - Encryption block
        
        do {
            // In combined mode, the authentication tag is directly appended to the encrypted message. This is usually what you want.
            let gcm = GCM(iv: Array("0123456789012345".utf8), mode: .combined)
            let aes = try? AES(key: key, blockMode: gcm, padding: .noPadding)
            do {
                encrypted = try aes?.encrypt(input)
                print(encrypted! as Any)
            }
            catch {
                fatalError("Error in encryption")
            }
            let tag = gcm.authenticationTag
            print(tag! as Any)
            
        }
        
        
        //MARK: - Decryption Block
        
        do {
            // In combined mode, the authentication tag is appended to the encrypted message. This is usually what you want.
            let gcm = GCM(iv: Array("0123456789012345".utf8), mode: .combined)
            let aes = try AES(key: key, blockMode: gcm, padding: .noPadding)
            let decrypted = try aes.decrypt(encrypted!)
            
            print(decrypted)
        } catch {
            print("[ERROR] Decryption failed")// failed
        }
        
    }


}

