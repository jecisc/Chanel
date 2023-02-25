Extension { #name : #RBVariableNode }

{ #category : #'*Chanel' }
RBVariableNode >> canBeUselessNode [
	"This is an ugly hack.
	Pharo AST has a bug to know if a temporary is a declaration or a usage. See https://github.com/pharo-project/pharo/issues/6277

	This hack checks if the temporary is directly in its parent statements since declarations are not in the statements. In that case it's a candidate for removal."

	self class environment at: #CopiedLocalVariable ifPresent: [ :c | (self variable isKindOf: c) ifTrue: [ ^ false ] ].
	self isTempVariable ifTrue: [ ^ self parent statements includes: self ].

	"If the parent of an arg is a method node, then it's probably the argument definition."
	self isArgumentVariable ifTrue: [ ^ self parent isMethod not ].

	^ super canBeUselessNode
]

{ #category : #'*Chanel' }
RBVariableNode >> declaringScope [
	| ancestor |
	ancestor := self parent.
	[ ancestor isNil ] whileFalse: [ (ancestor hasTemporaryNamed: self name) ifTrue: [ ^ ancestor ] ].
	self error: 'Undeclared temporary'
]

{ #category : #'*Chanel' }
RBVariableNode >> inlineAssignment [
	"Replace the assignment in which I am by its value without the assignation to the temporary."

	self parent isAssignment
		ifTrue: [ self parent inline ]
		ifFalse: [ "This might happen for dead temporaries. See testRemoveTemporary2." self removeFromTree ]
]

{ #category : #'*Chanel' }
RBVariableNode >> inlineTemporary [
	"Can be called only if the temporary is not read. Will remove the temporary declaration and inline the assignments."

	self declaringScope
		nodesDo: [ :node | (node isTempNamed: self name) ifTrue: [ node inlineAssignment ] ];
		removeTemporaryNamed: self name
]

{ #category : #'*Chanel' }
RBVariableNode >> isNotReadOnce [
	^ self declaringScope allChildren noneSatisfy: [ :node | (node isTempNamed: self name) and: [ node isRead ] ]
]

{ #category : #'*Chanel' }
RBVariableNode >> isTempNamed: aSymbol [
	^ self isTempVariable and: [ self name = aSymbol ]
]
