// CV Pandoc Template for Typst — Adam Altmejd

// --- Page setup ---
#set page(
  paper: "a4",
  margin: (left: 30mm, right: 25mm, top: 18mm, bottom: 23mm),
  footer: context {
    let pg = counter(page).get().first()
$if(git-hash)$
    if pg == 1 {
      align(center, text(font: "Operator Mono", size: 0.7em, "Commit $git-hash$ on $git-date$"))
    } else {
      align(right, str(pg))
    }
$else$
    if pg > 1 {
      align(right, str(pg))
    }
$endif$
  },
)

// --- Fonts ---
#set text(
  font: "Minion Pro",
  size: 11pt,
)

// --- Paragraph ---
#set par(
  justify: false,
  leading: 0.55em,
  spacing: 8pt,
)

// --- Links ---
#show link: set text(fill: black)

// --- Headings ---
// Rule is an inline box so its bottom edge sits on the text baseline, matching LaTeX \rule[0pt]
#show heading.where(level: 1): it => {
  v(10pt)
  // Code mode avoids markup newlines inserting word spaces between inline elements
  block(below: 8pt, {
    h(-18mm)
    box(width: 16mm, height: 1mm, fill: black)
    h(2mm)
    text(font: "Gill Sans Std", weight: 300, size: 14.4pt, it.body)
  })
}

#show heading.where(level: 2): it => block(above: 8pt, below: 6pt,
  text(font: "Gill Sans Std", weight: 300, size: 12pt, it.body)
)

#show heading.where(level: 3): it => {
  text(font: "Gill Sans Std", weight: "regular", it.body)
}

// --- Description/term lists (year | description layout) ---
#show terms.item: it => {
  block(above: 5.5pt, below: 0pt)[
    #place(left, dx: -28mm,
      box(width: 26mm,
        align(right, text(font: "Gill Sans Std", size: 0.8em, it.term))
      )
    )
    #it.description
  ]
}

// --- Monospace ---
#show raw: set text(font: "Operator Mono", size: 0.8em)

// --- Font Awesome 5 icons ---
#let fa-icon(codepoint) = {
  text(font: "Font Awesome 5 Free Solid", codepoint)
}
#let fa-brand(codepoint) = {
  text(font: "Font Awesome 5 Brands", codepoint)
}
#let fa-phone = fa-icon("\u{f095}")
#let fa-envelope = fa-icon("\u{f0e0}")
#let fa-globe = fa-icon("\u{f0ac}")
#let fa-twitter = fa-brand("\u{f099}")

// ==========================================================
// HEADER
// ==========================================================
#grid(
  columns: (2fr, 1.6fr, 1.2fr),
  align(left + bottom)[
    #text(font: "Gill Sans Std", stretch: 75%, size: 35pt)[$author$]\
    #text(font: "Gill Sans Std", stretch: 75%, size: 29pt)[$title$]
  ],
  align(right + bottom, text(font: "Gill Sans Std", size: 9pt)[
    #link("$address.online$")[$address.affiliation$]\
    $address.main$\
    $address.city$\
    $address.country$
  ]),
  align(right + bottom, text(font: "Gill Sans Std", size: 9pt)[
    $mobile$ #h(2pt) #fa-phone\
    #link("mailto:$email$")[$email$] #h(2pt) #fa-envelope\
    #link("https://$homepage$")[$homepage$] #h(2pt) #fa-globe\
    #link("https://twitter.com/$twitter$")[\@$twitter$] #h(2pt) #fa-twitter
  ]),
)

#v(8pt)

// ==========================================================
// BODY
// ==========================================================

$body$
