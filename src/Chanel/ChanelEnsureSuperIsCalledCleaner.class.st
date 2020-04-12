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
						and: [ method ast sendNodes
								ifNotEmpty: [ :nodes | (nodes anySatisfy: [ :node | node isSuperSend and: [ node selector = #initialize ] ]) not ]
								ifEmpty: [ false ] ] ] ]
		thenDo: [ :method | 
			| ast |
			ast := method ast.
			ast body addNodeFirst: (RBMessageNode receiver: (RBVariableNode named: #super) selector: #initialize).
			method methodClass compile: ast formattedCode ]
]

{ #category : #cleaning }
ChanelEnsureSuperIsCalledCleaner >> ensureSuperSetUpForMethods: methods [
	methods
		select: [ :method | 
			method methodClass isTestCase
				and: [ method selector = #setUp
						and: [ method ast sendNodes
								ifNotEmpty: [ :nodes | (nodes first isSuperSend and: [ nodes first selector = #setUp ]) not ]
								ifEmpty: [ false ] ] ] ]
		thenDo: [ :method | 
			| ast |
			ast := method ast.
			ast sendNodes select: [ :each | each isSuperSend and: [ each selector = #setUp ] ] thenDo: #removeFromTree.
			ast body addNodeFirst: (RBMessageNode receiver: (RBVariableNode named: #super) selector: #setUp).
			method methodClass compile: ast formattedCode ]
]

{ #category : #cleaning }
ChanelEnsureSuperIsCalledCleaner >> ensureSuperTearDownForMethods: methods [
	methods
		select: [ :method | 
			method methodClass isTestCase
				and: [ method selector = #tearDown
						and: [ method ast sendNodes
								ifNotEmpty: [ :nodes | (nodes last isSuperSend and: [ nodes last selector = #tearDown ]) not ]
								ifEmpty: [ false ] ] ] ]
		thenDo: [ :method | 
			| ast |
			ast := method ast.
			ast sendNodes select: [ :each | each isSuperSend and: [ each selector = #tearDown ] ] thenDo: #removeFromTree.
			ast body addNodeLast: (RBMessageNode receiver: (RBVariableNode named: #super) selector: #tearDown).
			method methodClass compile: ast formattedCode ]
]
