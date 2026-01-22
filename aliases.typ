#import "@preview/eggs:0.4.0": judge, ex-ref

#let citet = cite.with(form: "prose")
#let citea = cite.with(form: "author")
#let citey = cite.with(form: "year")
#let citeb(..args) = {
  show regex("\(|\)"): none
  cite(..args, form: "normal") 
}
#let citetm(..args) = {
  let years = args.pos().map(cite.with(form: "year"))
  [#cite(args.at(0), form: "author") (#years.join("; "))]
}

#let hf = h(1fr)

#let sc = smallcaps

#let denote(term) = $bracket.l.double term bracket.r.double$
#let opair(fst, snd) = $angle.l fst, snd angle.r$

#let nextx = ex-ref(1)
#let lastx = ex-ref(0)
#let anextx = ex-ref(2)
#let blastx = ex-ref(-1)

#let show-suppl = suppl => {
  if suppl != none {
    [, #suppl]
  }
}

#let shortcite(
  it,
  forms: (
    p: (citeit, suppl) => citeit(form: "prose"),
    ps: (citeit, suppl) => [#citeit(form: "author", supplement: none)'s (#citeit(form: "year")#show-suppl(suppl))],
    pns: (citeit, suppl) => [#citeit(form: "author", supplement: none)' (#citeit(form: "year")#show-suppl(suppl))],
    b: (citeit, suppl) => {
      show regex("\(|\)"): none
      citeit()
    },
    a: (citeit, suppl) => citeit(form: "author"),
    y: (citeit, suppl) => citeit(form: "year"),
  )
) = {
  if it.element == none {
    let suppl = it.supplement

    if suppl not in (none, auto, []) {
      if (
        suppl.has("children")
          and suppl.at("children").at(1) == [:]
      ) {
        let children = suppl.at("children")
        let abbr = (children.at(0).text)

        let suppl = if children.len() == 3 {
          children.at(2)
        } else if children.len() > 3 {
          children.slice(2).join()
        } else {
          none
        }

        let citeit = cite.with(it.target, supplement: suppl)

        if abbr in forms {
          forms.at(abbr)(citeit, suppl)
        } else {
          citeit()
        }

      } else {
        it
      }
    } else {
      it
    }

    // Return reference
  } else {
    it
  }
}
