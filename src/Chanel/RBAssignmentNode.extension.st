Extension { #name : #RBAssignmentNode }

{ #category : #'*Chanel' }
RBAssignmentNode >> removeFromTree [
	self parent removeNode: self
]
