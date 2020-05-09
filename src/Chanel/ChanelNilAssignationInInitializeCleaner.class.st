"
Description
--------------------

I remove all nil assignations in initialize methods because most of the time they are not needed.
Be careful, in some cases, they are. 
"
Class {
	#name : #ChanelNilAssignationInInitializeCleaner,
	#superclass : #ChanelAbstractCleaner,
	#category : #Chanel
}

{ #category : #cleaning }
ChanelNilAssignationInInitializeCleaner >> clean [
	self configuration localMethods iterator
		| [ :method | method selector = #initialize ] selectIt
		| [ :method | method ast nilAssignmentNodes isNotEmpty ] selectIt
		| [ :method | method ast nilAssignmentNodes do: #removeFromTree ] doIt
		> #installAST doIt
]
