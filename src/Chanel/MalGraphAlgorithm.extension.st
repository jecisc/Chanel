Extension { #name : #MalGraphAlgorithm }

{ #category : #'*Chanel' }
MalGraphAlgorithm >> addIncomingEdgesFollowing: aBlock [
	self edges: (nodes flatCollect: [ :node | (aBlock value: node model) collect: [ :each | node model -> each ] ]) from: #key to: #value
]

{ #category : #'*Chanel' }
MalGraphAlgorithm class >> nodes: aCollection incomingEdgesProperty: aValuable [
	^ self new
		nodes: aCollection;
		addIncomingEdgesFollowing: aValuable;
		yourself
]
