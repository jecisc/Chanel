Extension { #name : 'RBMessageNode' }

{ #category : '*Chanel' }
RBMessageNode >> canHaveUselessChildren [
	^ false
]

{ #category : '*Chanel' }
RBMessageNode >> inlineAssignationFromArguments [
	| variable |
	variable := self arguments anyOne lastAssignmentVariable.
	self arguments do: #inlineLastStatement.

	"If my parent is an assignment with the same name, then it's useless to wrap me in another assigment."
	(self parent isAssignment and: [ self parent variable = variable ]) ifTrue: [ ^ self ].
	self replaceWith: (RBAssignmentNode variable: variable value: self copy)
]

{ #category : '*Chanel' }
RBMessageNode >> isConditionNecessarilyExecutingABranch [
	"I contains a collection of conditionals that will always end up executing one of their branch. So we know that at least one of the argument will be executed."

	^ #(#ifTrue:ifFalse: #ifFalse:ifTrue: #ifNil:ifNotNil: #ifNotNil:ifNil: #ifEmpty:ifNotEmpty: #ifNotEmpty:ifEmpty: #ifExists:ifAbsent:) includes: self selector
]

{ #category : '*Chanel' }
RBMessageNode >> isSelfSendTo: aSelector [
	^ self isSelfSend and: [  self selector = aSelector ]
]

{ #category : '*Chanel' }
RBMessageNode >> isSuperSendTo: aSelector [
	^ self isSuperSend and: [  self selector = aSelector ]
]

{ #category : '*Chanel' }
RBMessageNode class >> superSendTo: aSelector [
  ^self receiver: RBVariableNode superNode selector: aSelector
]

{ #category : '*Chanel' }
RBMessageNode >> wrapsInReturn [
	self parent isReturn ifTrue: [ ^ self ].

	self replaceWith: (RBReturnNode value: self copy)
]
