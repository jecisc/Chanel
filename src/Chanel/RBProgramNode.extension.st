Extension { #name : #RBProgramNode }

{ #category : #'*Chanel' }
RBProgramNode >> hasMessages [
	^ self sendNodes isNotEmpty
]

{ #category : #'*Chanel' }
RBProgramNode >> isTempNamed: aSymbol [
	^ false
]

{ #category : #'*Chanel' }
RBProgramNode >> nilAssignmentNodes [
	^ self assignmentNodes select: [ :assignment | assignment value value isNil ]
]

{ #category : #'*Chanel' }
RBProgramNode >> removeFromTree [
	self parent removeNode: self
]
