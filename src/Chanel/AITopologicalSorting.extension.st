Extension { #name : #AITopologicalSorting }

{ #category : #'*Chanel' }
AITopologicalSorting >> addIncomingEdgesFollowing: aBlock [
	self edges: (nodes flatCollect: [ :node | (aBlock value: node model) collect: [ :each | node model -> each ] ]) from: #key to: #value
]

{ #category : #'*Chanel' }
AITopologicalSorting class >> nodes: aCollection incomingEdgesProperty: aValuable [
	^ self new
		nodes: aCollection;
		addIncomingEdgesFollowing: aValuable;
		yourself
]

{ #category : #'*Chanel' }
AITopologicalSorting class >> sort: nodes followingIncomingProperty: aValuable [
	^ (self nodes: nodes incomingEdgesProperty: aValuable) run collect: #model
]
