# Bouton oui/non : a utiliser dans CarnetGF pour contourner l'absence de données SIG

dialog.t.test <- function(){
  tt <- tktoplevel()
  tkwm.title(tt,"SIG")

  done <- tclVar(0)

  yes.but <- tkbutton(tt, text="OUI", command=function()tclvalue(done)<-2)
  no.but <- tkbutton(tt, text="NON", command=function()tclvalue(done)<-1)



  tkgrid(tklabel(tt,text="Disposez-vous de toutes les données SIG suivantes?"),columnspan=2)
  tkgrid(tklabel(tt,
                 #                    font="Times New Roman",
                 wraplength="4i",
                 justify="left",
                 text="le fichier vecteur délimitant le périmètre
le fichier vecteurs (points) localisant les placettes
le fichier vecteur contenant le parcellaire forestier
le fichier vecteur délimitant les différents peuplements"
  ))
  tkgrid(yes.but, no.but)


  tkwait.variable(done)
  tkdestroy(tt)
  return(done)
}

a <- tclvalue(dialog.t.test())








########Brouillon#######

mydialog <- function(){

  xvar <- tclVar("1")
  yvar <- tclVar("2")
  zvar <- tclVar("3")

  tt <- tktoplevel()
  tkwm.title(tt,"MYTEST")
  x.entry <- tkentry(tt, textvariable=xvar)
  y.entry <- tkentry(tt, textvariable=yvar)
  z.entry <- tkentry(tt, textvariable=zvar)

  reset <- function()
  {
    tclvalue(xvar)<-""
    tclvalue(yvar)<-""
    tclvalue(zvar)<-""
  }

  reset.but <- tkbutton(tt, text="Reset", command=reset)

  submit <- function() {
    x <- as.numeric(tclvalue(xvar))
    y <- as.numeric(tclvalue(yvar))
    z <- as.numeric(tclvalue(zvar))
    resultat <- print(x+y+z)
    tkmessageBox(message="Done!")
    return(resultat)
    #tkdestroy(tt)
  }
  submit.but <- tkbutton(tt, text="submit", command=submit)

  tkgrid(tklabel(tt,text="MYTEST"),columnspan=2)
  tkgrid(tklabel(tt,text="x variable"), x.entry)
  tkgrid(tklabel(tt,text="y variable"), y.entry)
  tkgrid(tklabel(tt,text="z variable"), z.entry)
  tkgrid(submit.but, reset.but)

}

mydialog()

