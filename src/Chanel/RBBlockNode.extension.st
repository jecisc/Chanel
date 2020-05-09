Extension { #name : #RBBlockNode }

{ #category : #'*Chanel' }
RBBlockNode >> inlineLastReturn [
	self statements last inline
]

{ #category : #'*Chanel' }
RBBlockNode >> lastStatementIsReturn [
	^ self statements last isReturn
]
