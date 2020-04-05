Extension { #name : #RBMethodNode }

{ #category : #'*Chanel-Pharo6' }
RBMethodNode >> allSequenceNodes [

	^ self allChildren select: #isSequence
]
