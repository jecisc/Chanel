Extension { #name : #RBProgramNode }

{ #category : #'*Chanel-Pharo8' }
RBProgramNode >> isArgumentVariable [
	^ self isArgument
]

{ #category : #'*Chanel-Pharo8' }
RBProgramNode >> isTempVariable [
	^ self isTemp
]
