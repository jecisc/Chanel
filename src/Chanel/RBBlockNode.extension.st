Extension { #name : #RBBlockNode }

{ #category : #'*Chanel' }
RBBlockNode >> inlineLastStatement [
	self statements last inline
]

{ #category : #'*Chanel' }
RBBlockNode >> lastAssignmentVariable [
	"We know that the last statement is an assignment. We want to return its value."

	^ self statements last variable
]

{ #category : #'*Chanel' }
RBBlockNode >> lastStatementIsAssignment [
	^ self statements ifEmpty: [ false ] ifNotEmpty: [ :s | s last isAssignment ]
]

{ #category : #'*Chanel' }
RBBlockNode >> lastStatementIsReturn [
	^ self statements ifEmpty: [ false ] ifNotEmpty: [ :s | s last isReturn ]
]
