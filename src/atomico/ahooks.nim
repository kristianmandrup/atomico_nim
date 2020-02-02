import macros, jsffi

type
  State* = JsObject
  Context* = JsObject
  Reference* = JsObject
    current*: auto

# please note that seqs cannot have differing types, even in the js target 
proc tuplifyState(self: seq[JsObject]): tuple[state, setter: JsObject] = 
(state: self[0], setter: self[1])
  
proc useStateImpl(initialState: State): seq[JsObject] {. importjs "Atomico.useState" .}

proc useState*(initialState: State): tuple(state: JsObject, setterFn: proc(newState: JsObject)) =
  tuplifyState(useStateImpl(initialState)) 

proc useState*(): seq[auto] {. importjs "Atomico.useState" .}
proc useState*(initialState: State): seq[auto] {. importjs "Atomico.useState" .}
proc useEffect*(didUpdate: proc()) {. importjs "Atomico.useEffect" .}
proc useEffect*(didUpdate: proc(), triggerDependencies: seq[auto]) {. importjs "Atomico.useEffect" .}
proc useContext*(context: JsObject): Context {. importjs "Atomico.useContext" .}
proc useReducer*(reducer: proc()) {. importjs "Atomico.useReducer" .}
proc useReducer*(reducer: proc(), initialArg: auto) {. importjs "Atomico.useReducer" .}
proc useReducer*(reducer: proc(), initialArg: auto, init: proc()) {. importjs "Atomico.useReducer" .}
proc useCallback*(callback: proc()) {. importjs "Atomico.useCallback" .}
proc useCallback*(callback: proc(), triggerDependencies: seq[auto]) {. importjs "Atomico.useCallback" .}
proc useMemo*(createFn: proc(), recomputeDependencies: seq[auto]) {. importjs "Atomico.useMemo" .}
proc useRef*(): Reference {. importjs "Atomico.useRef" .}