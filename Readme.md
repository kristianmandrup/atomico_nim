# Atomico bindings for Nim

Library for creation of interfaces based on web-components, using only functions and hooks.

- [Atomico github project repo](https://github.com/atomicojs/atomico)
- [Atomico documentation](https://atomico.gitbook.io/)

## API

```nim
proc h*(tagName: cstring, attrs: JsObject, text: cstring): VDomNode
proc h*(tagName: cstring, attrs: JsObject, children: seq[VDomNode]): VDomNode
proc html(htmlString: cstring): VDomNode
proc customElement*(tagName: cstring, component: WebComponent)
```

### Hooks

```nim
proc useProp*(propName: cstring): tuple(state: JsObject, setterFn: proc(newState: JsObject))
proc useState*(initialState: State): tuple(state: JsObject, setterFn: proc(newState: JsObject))

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

proc useRoute*(routePath: cstring): tuple(inRoute: JsObject, params: seq[auto])
proc useRedirect*(routePath: cstring): cstring

proc useStateGenerator*(callbackGenerator: auto, initialState: auto, vars: seq[auto]): tuple(state: JsObject, promise: PromiseJs)
```
