Extension { #name : #RBProgramNode }

{ #category : #'*Chanel' }
RBProgramNode >> allParents [
	^ parent 
		ifNil: [ OrderedCollection new ]
		ifNotNil: [ 
			parent allParents
				addLast: parent;
				yourself ]
]

{ #category : #'*Chanel' }
RBProgramNode >> canBeUselessNode [
	^ self isImmediateNode
]

{ #category : #'*Chanel' }
RBProgramNode >> canHaveUselessChildren [
	"Return false if all the children of this node can be important and should not be remove by Chanel."

	^ true
]

{ #category : #'*Chanel' }
RBProgramNode >> hasMessages [
	^ self sendNodes isNotEmpty
]

{ #category : #'*Chanel' }
RBProgramNode >> isTempNamed: aSymbol [
	^ false
]

{ #category : #'*Chanel' }
RBProgramNode >> nilAssignmentNodes [
	^ self assignmentNodes select: [ :assignment | assignment value value isNil ]
]

{ #category : #'*Chanel' }
RBProgramNode >> removeFromTree [
	self parent removeNode: self
]
