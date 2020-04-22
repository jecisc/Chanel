Extension { #name : #RBMessageNode }

{ #category : #'*Chanel' }
RBMessageNode >> isSelfSendTo: aSelector [
	^ self isSelfSend and: [  self selector = aSelector ]
]

{ #category : #'*Chanel' }
RBMessageNode >> isSuperSendTo: aSelector [
	^ self isSuperSend and: [  self selector = aSelector ]
]

{ #category : #'*Chanel' }
RBMessageNode class >> superSendTo: aSelector [
	^ self receiver: (RBVariableNode named: #super) selector: aSelector
]
