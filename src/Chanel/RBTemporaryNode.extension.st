Extension { #name : #RBTemporaryNode }

{ #category : #'*Chanel' }
RBTemporaryNode >> declaringScope [
	| ancestor |
	ancestor := self parent.
	[ ancestor isNil ] whileFalse: [ (ancestor hasTemporaryNamed: self name) ifTrue: [ ^ ancestor ] ].
	self error: 'Undeclared temporary'
]

{ #category : #'*Chanel' }
RBTemporaryNode >> inlineAssignment [
	"Replace the assignment in which I am by its value without the assignation to the temporary."

	self parent replaceWith: self parent value
]

{ #category : #'*Chanel' }
RBTemporaryNode >> inlineTemporary [
	"Can be called only if the temporary is not read. Will remove the temporary declaration and inline the assignments."

	self declaringScope
		nodesDo: [ :node | (node isTempNamed: self name) ifTrue: [ node inlineAssignment ] ];
		removeTemporaryNamed: self name
]

{ #category : #'*Chanel' }
RBTemporaryNode >> isNotReadOnce [
	^ self declaringScope allChildren noneSatisfy: [ :node | node isTemp and: [ node name = self name and: [ node isRead ] ] ]
]
