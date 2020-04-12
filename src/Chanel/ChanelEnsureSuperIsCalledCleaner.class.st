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
	methods
		select: [ :method | 
			method methodClass isInstanceSide
				and: [ method selector = #initialize
						and: [ method sendNodes
								ifNotEmpty: [ :nodes | nodes noneSatisfy: [ :node | node isSuperSendTo: #initialize ] ]
								ifEmpty: [ false ] ] ] ]
		thenDo: [ :method | 
			| ast |
			ast := method ast.
			ast body addNodeFirst: (RBMessageNode superCallTo: #initialize).
			method methodClass compile: ast formattedCode ]
]

{ #category : #cleaning }
ChanelEnsureSuperIsCalledCleaner >> ensureSuperSetUpForMethods: methods [
	methods
		select: [ :method | 
			method methodClass isTestCase
				and: [ method selector = #setUp
						and: [ method sendNodes
								ifNotEmpty: [ :nodes | (nodes first isSuperSendTo: #setUp) not ]
								ifEmpty: [ false ] ] ] ]
		thenDo: [ :method | 
			| ast |
			ast := method ast.
			ast sendNodes select: [ :each | each isSuperSendTo: #setUp ] thenDo: #removeFromTree.
			ast body addNodeFirst: (RBMessageNode superCallTo: #setUp).
			method methodClass compile: ast formattedCode ]
]

{ #category : #cleaning }
ChanelEnsureSuperIsCalledCleaner >> ensureSuperTearDownForMethods: methods [
	methods
		select: [ :method | 
			method methodClass isTestCase
				and: [ method selector = #tearDown
						and: [ method sendNodes
								ifNotEmpty: [ :nodes | (nodes last isSuperSendTo: #tearDown) not ]
								ifEmpty: [ false ] ] ] ]
		thenDo: [ :method | 
			| ast |
			ast := method ast.
			ast sendNodes select: [ :each | each isSuperSendTo: #tearDown ] thenDo: #removeFromTree.
			ast body addNodeLast: (RBMessageNode superCallTo: #tearDown).
			method methodClass compile: ast formattedCode ]
]
