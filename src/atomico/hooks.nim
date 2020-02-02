import macros, jsffi, asyncjs

type
  State* = JsObject
  Context* = JsObject
  Component* = JsObject
  Reference* = JsObject
    current*: auto


proc tuplifyState(self: seq[JsObject]): tuple[state, setter: JsObject] = 
(state: self[0], setter: self[1])

proc tuplifyRoute(self: seq[JsObject]): tuple[inRoute, params: JsObject] = 
(inRoute: self[0], params: self[1])

proc tuplifyStateGen(self: seq[JsObject]): tuple[state, promise: JsObject] = 
(state: self[0], promise: self[1])

proc useStateImpl(initialState: State): seq[JsObject] {. importjs "useState" .}

proc usePropImp(initialState: State): seq[JsObject] {. importjs "useProp" .}

proc useRouteImpl(initialState: State): seq[JsObject] {. importjs "useRoute" .}

proc useStateGeneratorImpl(callbackGenerator: auto, initialState: auto, vars: seq[auto]): seq[JsObject] {. importjs "useStateGenerator" .}
    
proc useState*(initialState: State): tuple(state: JsObject, setterFn: proc(newState: JsObject)) =
  tuplifyState(useStateImpl(initialState))

proc useProp*(propName: cstring): tuple(state: JsObject, setterFn: proc(newState: JsObject)) =
  tuplifyState(usePropImpl(propName))
  
proc useRoute*(routePath: cstring): tuple(inRoute: JsObject, params: seq[auto]) =
  tuplifyRoute(useRouteImpl(routePath))

proc useStateGenerator*(callbackGenerator: auto, initialState: auto, vars: seq[auto]): tuple(state: JsObject, promise: PromiseJs) =
  tuplifyStateGen(useStateGeneratorImpl(callbackGenerator, initialState, vars))  
  
{.push importjs.}
proc useEffect*(didUpdate: proc())
proc useEffect*(didUpdate: proc(), triggerDependencies: seq[auto])
proc useContext*(context: JsObject): Context
proc useReducer*(reducer: proc())
proc useReducer*(reducer: proc(), initialArg: auto)
proc useReducer*(reducer: proc(), initialArg: auto, init: proc())
proc useCallback*(callback: proc())
proc useCallback*(callback: proc(), triggerDependencies: seq[auto])
proc useMemo*(createFn: proc(), recomputeDependencies: seq[auto])
proc useRef*(): Reference

proc useEvent*(eventName: cstring, eventConfig: JsObject)
proc usePublic*(publicFnName: cstring, publicFn: JsObject)

proc useLazy*(asyncCallback: PromiseJs, args: seq[auto]): Component

# for dynamic import
proc useLazyNode*(importFn: proc()): Component

proc useRedirect*(routePath: cstring): cstring
{.pop.}
