# Network Module Usage

For required protocol implementation, investigate Concrete Samples folder.
I prefixed classes with EK to avoid name conflict.

Firstly make sure you don't forget setting your environment (baseUrl). 

AppDelegate is a good place to use.

### Dependencies: Alamofire & SwiftyJSON

```swift

import EKNetworkModule

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
    EKAPIClient.shared.environment = EKNetworkEnvironment(
       baseUrl: "https://www.mybaseurl.com/",
       timeInterval: 20 // Default
    )

    return true
}
```

## Creating JSON Model.

To create (generate) your Request (post methods) and Response models you can use online tools like *https://app.quicktype.io/*

You basically give your sample JSON to tool and it gives back to you Auto-Generated swift class model. (Including nested instances)

Make sure you add Codable options as well.

Lets create a model together.

Assume you have a JSON like below.

```json
{
    "customerKey": {
        "custId": 22022163
    }
}
```
Copy this JSON to any tool you like to use. And let him generate codes like below.

```swift
import Foundation

class CustomerKey: Codable {
    var custID: Int?

    // You can ignore if you want to use exact same keys in JSON
    enum CodingKeys: String, CodingKey {
        case custID 
    }
    
}
```

## Creating a Request (Confirm Request protocol).

To create a request, you must confirm **Request** protocol. (Except GET request, GET is optional)

```swift
import Alamofire

protocol Request: Codable {
    associatedtype Response: Codable
    var endPoint: String { get set }
    var httpMethod: HTTPMethod { get set }
}
```

You can investigate Request protocol in the project. It just has 3 parameters.

* **httpMethod**: HTTPMethod
* **endPoint**: String
* **associatedtype**: Response: Codable

Then lets create one.

```swift
import Foundation

final class MyRequestObject: Request {

    var httpMethod: HTTPMethod = .post
    var endPoint: String = "user/inquireReferCode"
    
    // Create same way you did for CustomerKey
    typealias Response = MyResponseObject 


    public var customerKey: CustomerKey?

    enum CodingKeys: CodingKey {
        case customerKey
    }

}
```

Okay so now lets see how we can execute Http Request

Use **APIClient** instance, required methods are already implemented.

## Request Samples

* ##### POST, GET

```swift
let request = MyRequestObject()
EKAPIClient.shared.execute(
    request: request,
    success: { (myResponseObjectModel) in
        
    },
    failure: { error in
        // Handle error
    }
)
```

You don't need to create Request object for **GET** requests. 
You can just jump right into request.

```swift
EKAPIClient.shared.executeGET(
    endPoint: "articles", 
    success: { (articles: [Article]) in
        print(articles.count)
        // ..
    }, 
    failure: { error in
        // Handle error
    })
```


### Extra

#### Question: I want to handle presenting/dismissin loader for every request, is there an easy way to do this?

Answer: Implement `NetworkInterceptorProtocol` & inject in `APIClientProtocol` concrete class <br> 
`NetworkInterceptorProtocol` includes `onBeforeRequest` & `onRequestCompleted` methods, you can do proper setup.

<hr>

#### Question: What if I want to make a request to another baseUrl?

Answer: Use `ovverideBaseUrlOnce(baseUrl: String)` method to achieve, after this request the url you set first (in `AppDelegate` is activated again)

```swift
EKAPIClient.shared
    .ovverideBaseUrlOnce(baseUrl: "https://api.temproary-base-url.com/")
    .execute()
```
