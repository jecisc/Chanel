Extension { #name : #RBTemporaryNode }

{ #category : #'*Chanel' }
RBTemporaryNode >> canBeUselessNode [
	"This is an ugly hack.
	Pharo AST has a bug to know if a temporary is a declaration or a usage. See https://github.com/pharo-project/pharo/issues/6277
	
	This hack checks if the temporary is directly in its parent statements since declarations are not in the statements. In that case it's a candidate for removal."

	^ self parent statements includes: self
]

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

	self parent isAssignment
		ifTrue: [ self parent replaceWith: self parent value ]
		ifFalse: [ "This might happen for dead temporaries. See testRemoveTemporary2." self removeFromTree ]
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
	^ self declaringScope allChildren noneSatisfy: [ :node | (node isTempNamed: self name) and: [ node isRead ] ]
]
