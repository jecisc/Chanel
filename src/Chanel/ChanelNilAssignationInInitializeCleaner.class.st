"
Description
--------------------

I remove all nil assignations in initialize methods because most of the time they are not needed.
Be careful, in some cases, they are. 
"
Class {
	#name : #ChanelNilAssignationInInitializeCleaner,
	#superclass : #ChanelAbstractCleaner,
	#category : #Chanel
}

{ #category : #accessing }
ChanelNilAssignationInInitializeCleaner class >> priority [
	^ 6000
]

{ #category : #cleaning }
ChanelNilAssignationInInitializeCleaner >> clean [
	(self configuration localMethods select: [ :method | method selector = #initialize ])
		do: [ :method | 
			| ast |
			ast := method ast.
			(ast assignmentNodes select: [ :assignment | assignment value value isNil ])
				ifNotEmpty: [ :nilAssignmentNode | 
					nilAssignmentNode do: #removeFromTree.
					method methodClass compile: ast formattedCode ] ]
]
