Extension { #name : #RBMessageNode }

{ #category : #'*Chanel' }
RBMessageNode >> canHaveUselessChildren [
	^ false
]

{ #category : #'*Chanel' }
RBMessageNode >> isConditionNecessarilyExecutingABranch [
	^ #(#ifTrue:ifFalse: #ifFalse:ifTrue: #ifNil:ifNotNil: #ifNotNil:ifNil: #ifEmpty:ifNotEmpty: #ifNotEmpty:ifEmpty: #ifExists:ifAbsent:) includes: self selector
]

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

{ #category : #'*Chanel' }
RBMessageNode >> wrapsInReturn [
	self parent isReturn ifTrue: [ ^ self ].

	self replaceWith: (RBReturnNode value: self copy)
]
