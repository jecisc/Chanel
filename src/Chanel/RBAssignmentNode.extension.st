Extension { #name : #RBAssignmentNode }

{ #category : #'*Chanel' }
RBAssignmentNode >> canHaveUselessChildren [
	^ false
]

{ #category : #'*Chanel' }
RBAssignmentNode >> removeAssignations [
	"In case the assignation is in an assignation, we want to remove the parent aswel."

	self parent isAssignment
		ifTrue: [ self parent removeAssignations ]
		ifFalse: [ self removeFromTree ]
]
