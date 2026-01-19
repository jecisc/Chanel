Extension { #name : 'RBReturnNode' }

{ #category : '*Chanel' }
RBReturnNode >> canHaveUselessChildren [
	^ false
]

{ #category : '*Chanel' }
RBReturnNode >> inline [
	self replaceWith: self value
]
