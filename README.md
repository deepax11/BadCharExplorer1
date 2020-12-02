# BadCharExplorer1

Dear Reviwer,

I have done what could I have done in my free time. I did not complete all the requirement but leaving it in right direction on which you can give me the feedback.

##1. Created NetworkKit similar to what I have been using in my current project.
I kept it simple with minimum interface.
Also added simple test case to demonstrate how can we test our own custom network client

##2. Created DTOKit to parse APIResponse. 
Made it generic so that it reduces the boilerplates for additional APIRequests.
Addd simple test case to demonstate how can we test against APIEndpoint.
Please note that: characters API response is quite open ended. But I belive few properties could be made enum which also conforms to codable protocol.
This way we can filter character based on those propeerties easily.

##3. Added a Flow (FlowProtocol) and RootFlow for intitial presentation and nvigation of ViewControllers

##4. Implemented MVVM architecture to render the list screen


##Things which are not done:
1. Test cases against BadCharListViewModel - APIRequest : Inject MockedAPIRequests which triggers error OR return desirable codable objects
2. Test case against BadCharListViewModel - BadCharListVC: MockedViewModel which causes VC to show error or List
3. Filterring for character based on their name and appearence
4. Detail screen
