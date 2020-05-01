Extension { #name : #RBArgumentNode }

{ #category : #'*Chanel' }
RBArgumentNode >> canBeUselessNode [
	"If the parent is a method node, then it's probably the argument definition."

	^ self parent isMethod not
]
