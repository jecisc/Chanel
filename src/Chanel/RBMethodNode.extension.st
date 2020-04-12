Extension { #name : #RBMethodNode }

{ #category : #'*Chanel' }
RBMethodNode >> allTemporaries [
	^ self allSequenceNodes flatCollect: #temporaries
]

{ #category : #'*Chanel' }
RBMethodNode >> install [
	^ self methodClass compile: self formattedCode
]
