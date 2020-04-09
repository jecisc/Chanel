Extension { #name : #RBSequenceNode }

{ #category : #'*Chanel-Pharo6' }
RBSequenceNode >> addNodeLast: aNode [

	self lastIsReturn
		ifTrue: [ self addNode: aNode before: self statements last ]
		ifFalse: [ self addNode: aNode ]
]
