Extension { #name : #RBVariableNode }

{ #category : #'*Chanel' }
RBVariableNode >> isTempNamed: aSymbol [
	^ self isTemp and: [ self name = aSymbol ]
]
