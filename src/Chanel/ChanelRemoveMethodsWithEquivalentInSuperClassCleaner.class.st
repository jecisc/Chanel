"
Description
--------------------

I am a cleaner removing methods overriding another method with exactly the same AST.
"
Class {
	#name : #ChanelRemoveMethodsWithEquivalentInSuperClassCleaner,
	#superclass : #ChanelAbstractCleaner,
	#category : #Chanel
}

{ #category : #accessing }
ChanelRemoveMethodsWithEquivalentInSuperClassCleaner class >> priority [
	^ 1500
]

{ #category : #cleaning }
ChanelRemoveMethodsWithEquivalentInSuperClassCleaner >> clean [
	| overridenMethod |
	self configuration definedClasses iterator
		| #isTrait rejectIt
		| [ :class | class localMethods, class class localMethods ] flatCollectIt 
		| [ :method | method methodClass superclass isNil ] rejectIt
		| [ :method | (overridenMethod := (method methodClass superclass lookupSelector: method selector)) isNil ] rejectIt
		| [ :method | method ast = overridenMethod ast ] selectIt
		> #removeMethod doIt
]
