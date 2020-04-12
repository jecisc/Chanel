"
I am a baseline to define the structure and dependencies of the Chanel project.
"
Class {
	#name : #BaselineOfChanel,
	#superclass : #BaselineOf,
	#category : #BaselineOfChanel
}

{ #category : #baseline }
BaselineOfChanel >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ self iterators: spec.

			spec
				package: 'Chanel' with: [ spec requires: #('Iterators') ];
				package: 'Chanel-Tests' with: [ spec requires: #('Chanel') ].

			spec
				group: 'Core' with: #('Chanel');
				group: 'Tests' with: #('Chanel-Tests') ].

	spec
		for: #(#'pharo7.x')
		do: [ spec
				package: 'Chanel-Pharo7';
				package: 'Chanel-Tests' with: [ spec requires: 'Chanel-Pharo7' ] ]
]

{ #category : #dependencies }
BaselineOfChanel >> iterators: spec [
	spec
		baseline: 'Iterators'
		with: [ spec
				loads: #('core' 'collections' 'shell-dsl' 'inspector-extensions');
				repository: 'github://juliendelplanque/Iterators:v1.x.x/src' ]
]

{ #category : #dependencies }
BaselineOfChanel >> pharoBackwardCompatibility: spec [
	spec baseline: 'PharoBackwardCompatibility' with: [ spec repository: 'github://jecisc/PharoBackwardCompatibility:v1.x.x/src' ]
]

{ #category : #accessing }
BaselineOfChanel >> projectClass [
	^ MetacelloCypressBaselineProject
]
