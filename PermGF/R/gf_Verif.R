#' Vérification des données brutes de chaque dispositif.
#' @description La fonction permet de sélectionner un ou plusieurs dispositifs et d'éditer un rapport aux formats html, pdf ou doc.
#'
#' @return Edition d'un rapport par dispositif
#'
#' @param format paramètre permettant de fixer le format du fichier en sortie.
#' @details Le format de sortie sera  \cr
#' du .html si le paramètre vaut 0 (valeur par défaut),  \cr
#' du .pdf si le format est égal à 1,  \cr
#' du .doc si format est égal à 2
#' @author Bruciamacchie Max
#' @import rmarkdown
#' @import tcltk
#' @import openxlsx
#' @import tools
#' @export

gf_Verif <- function(file, modif=F){
  # -------------- Gestion des dossiers
  rep <- getwd()
  dir.create("Out", showWarnings = F)
  dir.create("Out/Verif", showWarnings = F)
  outputdir="../Out/Verif/"
  template = "Template/gf_Verif.Rmd"
  setwd(rep)
  # -------------- Edition des rapports
  # disp = ListDisp[1]  disp2 = ListDisp[2]
  if (modif) {
    ListeFormat <- c("html","docx","pdf")
    format <- tk_select.list(as.character(ListeFormat), multiple=F, title = "Choix du format de fichier")
    extent = format
  } else{
    extent = "docx"
  }
  if (extent != "pdf") {
    tryCatch(render(input = template,
                    output_format = output_format(knitr = knitr_options(),
                                                  pandoc = pandoc_options(to = extent)),
                    output_dir = outputdir,
                    output_file = paste0(file_path_sans_ext(file),".",extent),
                    encoding="UTF-8"),
             finally= print(paste("Edition du rapport de vérification du dispositif :", file_path_sans_ext(file))))
  } else {
    tryCatch(render(input = template,
                    output_format = "pdf_document",
                    output_dir = outputdir,
                    output_file = paste0(file_path_sans_ext(file),".",extent),
                    encoding="UTF-8"),
             finally= print(paste("Edition du rapport de vérification du dispositif :", file_path_sans_ext(file))))

  }
}
