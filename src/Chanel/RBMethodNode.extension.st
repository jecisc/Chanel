Extension { #name : #RBMethodNode }

{ #category : #'*Chanel' }
RBMethodNode >> install [
	^ self methodClass compile: self formattedCode
]
