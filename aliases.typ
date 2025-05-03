#import "@local/leipzig-glossing:0.5.0": numbered-example, ex-ref

#let citet = cite.with(form: "prose")
#let citea = cite.with(form: "author")
#let citey = cite.with(form: "year")
#let citeb(..args) = {
  show regex("\(|\)"): none
  cite(..args, form: "normal") 
}

#let ex = numbered-example
#let er = ex-ref
#let st(text, label: none, judge: none) = (source: (text,), label: label, judge: judge)


#let qu(qr, var, term) = $qr var. med term$

#let denote(term) = $bracket.l.double term bracket.r.double$
#let opair(fst, snd) = $angle.l fst, snd angle.r$

#let nextx =  [(#context(counter("example-count").get().first() + 1))]
#let anextx = [(#context(counter("example-count").get().first() + 2))]
#let lastx =  [(#context(counter("example-count").get().first()    ))]
#let blastx = [(#context(counter("example-count").get().first() - 1))]

#let judge(j) = [#context(h(-measure(j).width))#j]
