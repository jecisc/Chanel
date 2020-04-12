"
Description
--------------------

I am a cleaner checking that we do not miss some super calls:
- Ensure #setUp in TestCases always begins by `super setUp` (move it if not the first messand sent)
- Ensure #tearDown in TestCases always ends by `super tearDown` (move it if not the last messand sent)
- Ensure #initialize on instance side always has `super initialize`

"
Class {
	#name : #ChanelEnsureSuperIsCalledCleaner,
	#superclass : #ChanelAbstractCleaner,
	#category : #Chanel
}

{ #category : #accessing }
ChanelEnsureSuperIsCalledCleaner class >> priority [
	^ 5000
]

{ #category : #cleaning }
ChanelEnsureSuperIsCalledCleaner >> clean [
	self configuration localMethods
		in: [ :methods | 
			self
				ensureSuperSetUpForMethods: methods;
				ensureSuperTearDownForMethods: methods;
				ensureSuperInitializeForMethods: methods ]
]

{ #category : #cleaning }
ChanelEnsureSuperIsCalledCleaner >> ensureSuperInitializeForMethods: methods [
	methods iterator
		| #isInstanceSide selectIt
		| [ :method | method selector = #initialize ] selectIt
		| #hasMessages selectIt
		| [ :method | method sendNodes noneSatisfy: [ :node | node isSuperSendTo: #initialize ] ] selectIt
		| [ :method | 
			| ast |
			ast := method ast.
			ast body addNodeFirst: (RBMessageNode superSendTo: #initialize).
			ast install ] doIt
		> Execute
]

{ #category : #cleaning }
ChanelEnsureSuperIsCalledCleaner >> ensureSuperSetUpForMethods: methods [
	methods iterator
		| [ :method | method methodClass isTestCase ] selectIt
		| [ :method | method selector = #setUp ] selectIt
		| #hasMessages selectIt
		| [ :method | method sendNodes first isSuperSendTo: #setUp ] rejectIt
		| [ :method | 
			| ast |
			ast := method ast.
			ast sendNodes select: [ :each | each isSuperSendTo: #setUp ] thenDo: #removeFromTree.
			ast body addNodeFirst: (RBMessageNode superSendTo: #setUp).
			ast install ] doIt
		> Execute
]

{ #category : #cleaning }
ChanelEnsureSuperIsCalledCleaner >> ensureSuperTearDownForMethods: methods [
	methods iterator
		| [ :method | method methodClass isTestCase ] selectIt
		| [ :method | method selector = #tearDown ] selectIt
		| #hasMessages selectIt
		| [ :method | method sendNodes last isSuperSendTo: #tearDown ] rejectIt
		| [ :method | 
			| ast |
			ast := method ast.
			ast sendNodes select: [ :each | each isSuperSendTo: #tearDown ] thenDo: #removeFromTree.
			ast body addNodeLast: (RBMessageNode superSendTo: #tearDown).
			ast install ] doIt
		> Execute
]
