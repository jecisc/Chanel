Extension { #name : #RBMessageNode }

{ #category : #'*Chanel' }
RBMessageNode >> isSuperSendTo: aSelector [
	^ self isSuperSend and: [  self selector = aSelector ]
]
