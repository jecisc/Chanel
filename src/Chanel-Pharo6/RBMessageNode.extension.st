Extension { #name : #RBMessageNode }

{ #category : #'*Chanel-Pharo6' }
RBMessageNode >> removeFromTree [

	self parent removeNode: self
]
