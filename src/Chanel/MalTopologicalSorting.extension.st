Extension { #name : #MalTopologicalSorting }

{ #category : #'*Chanel' }
MalTopologicalSorting class >> sort: nodes followingIncomingProperty: aValuable [
	^ (self nodes: nodes incomingEdgesProperty: aValuable) run collect: #model
]
