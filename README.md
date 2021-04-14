# BreakingBadCharExplorer

Dear Reviwer,

I have done what could I have done in my free time. I think I have completed all requirements. Though did not test thoroughly.

##1. Created NetworkKit similar to what I have been using in my current project.
I kept it simple with minimum interface.
Also added simple test case to demonstrate how can we test our own custom network client

##2. Created DTOKit to parse APIResponse. 
Made it generic so that it reduces the boilerplates for additional APIRequests.
Addd simple test case to demonstate how can we test against APIEndpoint.

##3. Added a Flow (FlowProtocol) and RootFlow for intitial presentation and navigation of ViewControllers

##4. Implemented MVVM architecture to render the list screen

Please note that I have create few reusable classes/struct/extension which can be good usecase to dump in new module SharedKit.
I added one test cases around view models to show case how view models can be used to test presentation logic. Not to mention that there should be more test cases.


Please note that - After checking out repo make sure to build both module before running the main target.
