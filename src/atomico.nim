import macros, dom, jsffi

when not defined(js):
  {.error: "Atomico.nim is only available for the JS target".}

type
  VDomNode* = JsObject
  WebComponent* = JsObject

{.push importcpp.}
proc h*(tagName: cstring, attrs: JsObject, text: cstring): VDomNode
proc h*(tagName: cstring, attrs: JsObject, children: seq[VDomNode]): VDomNode
proc html(htmlString: cstring): VDomNode
proc customElement*(tagName: cstring, component: WebComponent)
{.pop.}
