Extension { #name : #RBTemporaryNode }

{ #category : #'*Chanel' }
RBTemporaryNode >> declaringScope [
	| ancestor |
	ancestor := self parent.
	[ ancestor isNil ] whileFalse: [ (ancestor temporaries anySatisfy: [ :each | each name = self name ]) ifTrue: [ ^ ancestor ] ].
	self error: 'Undeclared temporary'
]

{ #category : #'*Chanel' }
RBTemporaryNode >> isReadAtLeastOnce [
	^ self declaringScope allChildren noneSatisfy: [ :node | node isTemp and: [ node name = self name and: [ node isRead ] ] ]
]
