Extension { #name : #RBBlockNode }

{ #category : #'*Chanel' }
RBBlockNode >> inlineLastReturn [
	self statements last inline
]
