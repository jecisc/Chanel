Extension { #name : #RBMethodNode }

{ #category : #'*Chanel' }
RBMethodNode >> allTemporaries [
	^ self allSequenceNodes flatCollect: #temporaries
]

{ #category : #'*Chanel' }
RBMethodNode >> install [
	('Updating: ' , self method printString) record.
	^ self methodClass compile: self formattedCode
]
